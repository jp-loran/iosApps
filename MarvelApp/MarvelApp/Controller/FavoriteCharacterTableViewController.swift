//
//  FavoriteCharacterTableViewController.swift
//  MarvelApp
//
//  Created by Juan Pablo Alvarez Loran on 07/05/24.
//

import UIKit
import CoreData

class FavoriteCharacterTableViewController: UITableViewController {

    var favoriteCharacters : [CharacterFavorite] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var favoriteCharacterTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteCharacterTable.delegate = self
        favoriteCharacterTable.dataSource = self
        
        let request: NSFetchRequest<CharacterFavorite> = CharacterFavorite.fetchRequest()
        
        do{
            favoriteCharacters = try context.fetch(request)
        }catch{
            print(error.localizedDescription)
        }
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(favoriteCharacters.count)
        let request: NSFetchRequest<CharacterFavorite> = CharacterFavorite.fetchRequest()
        
        do{
            favoriteCharacters = try context.fetch(request)
            favoriteCharacterTable.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteCharacterTable.dequeueReusableCell(withIdentifier: "favoriteCharacterCell", for: indexPath) as! FavoriteCharacterCell
        
        let character = favoriteCharacters[indexPath.row]
        
        cell.characterName.text = character.name
        cell.characterImage.sd_setImage(with: URL(string: character.thumbnail!))
        
        return cell
    }


}

