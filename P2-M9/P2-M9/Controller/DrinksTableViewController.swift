import UIKit
import CoreData
import Network

class DrinksTableViewController: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var drinks: [Drinks] = []
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        startNetworkMonitor()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDrinks), name: NSNotification.Name("NewDrinkAdded"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NewDrinkAdded"), object: nil)
        monitor.cancel()
    }

    @objc func reloadDrinks() {
        fetchDrinks()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as? DrinkTableViewCell else {
            fatalError("The dequeued cell is not an instance of DrinkTableViewCell.")
        }

        let drink = drinks[indexPath.row]
        cell.nameLabel.text = drink.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let destinationVC = segue.destination as? DetailViewController, let indexPath = sender as? IndexPath {
                let selectedDrink = drinks[indexPath.row]
                destinationVC.drink = selectedDrink
            }
        }
    }

    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addButtonTapped() {
        performSegue(withIdentifier: "newDrinkSegue", sender: self)
    }
    
    func startNetworkMonitor() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                DispatchQueue.main.async {
                    self.fetchJSON()
                }
            } else {
                print("No connection.")
                DispatchQueue.main.async {
                    self.fetchDrinks()
                }
            }
        }
        monitor.start(queue: queue)
    }

    func fetchJSON() {
        guard let url = URL(string: "http://janzelaznog.com/DDAM/iOS/drinks.json") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching JSON: \(error)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                self.saveDrinksToCoreData(json!)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }
    
    func saveDrinksToCoreData(_ drinks: [[String: Any]]) {
        let context = appDelegate!.persistentContainer.viewContext

        for drinkData in drinks {
            guard let name = drinkData["name"] as? String else {
                print("Drink name missing")
                continue
            }
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Drinks")
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.isEmpty {
                    let drink = NSEntityDescription.insertNewObject(forEntityName: "Drinks", into: context)
                    drink.setValue(name, forKey: "name")
                    drink.setValue(drinkData["directions"], forKey: "directions")
                    drink.setValue(drinkData["img"], forKey: "img")
                    drink.setValue(drinkData["ingredients"], forKey: "ingredients")
                } else {
                    print("Drink with name '\(name)' already exists")
                }
            } catch {
                print("Failed to fetch drink: \(error)")
            }
        }

        do {
            try context.save()
            print("Drinks saved successfully to Core Data")
        } catch {
            print("Failed to save drinks: \(error)")
        }
        
        fetchDrinks()
    }
    
    func fetchDrinks() {
        let fetchRequest: NSFetchRequest<Drinks> = Drinks.fetchRequest()
        let context = appDelegate!.persistentContainer.viewContext

        do {
            drinks = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Failed to fetch drinks: \(error)")
        }
    }
}
