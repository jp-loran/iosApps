import UIKit
import CoreData
import AVFoundation

class NewDrinkViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var newDrinkImage: UIImageView!
    @IBOutlet weak var newDrinkName: UITextField!
    @IBOutlet weak var newDrinkDescription: UITextView!
    @IBOutlet weak var newDrinkIngredients: UITextView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newDrinkName.placeholder = "Enter drink name"
        
        // Set UITextView delegate
        newDrinkDescription.delegate = self
        newDrinkIngredients.delegate = self
        
        
        // Add tap gesture recognizer to the UIImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        newDrinkImage.addGestureRecognizer(tapGesture)
        newDrinkImage.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped() {
        checkCameraPermissions()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let name = newDrinkName.text, !name.isEmpty,
              let description = newDrinkDescription.text, !description.isEmpty,
              let ingredients = newDrinkIngredients.text, !ingredients.isEmpty else {
            // Show an alert if validation fails
            let alert = UIAlertController(title: "Validation Error", message: "All fields are required.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Save the new drink to Core Data
        saveNewDrink(name: name, description: description, ingredients: ingredients)
        NotificationCenter.default.post(name: NSNotification.Name("NewDrinkAdded"), object: nil)
        
        // Dismiss the view controller or pop it from the navigation stack
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveNewDrink(name: String, description: String, ingredients: String) {
        let context = appDelegate!.persistentContainer.viewContext
        let newDrink = NSEntityDescription.insertNewObject(forEntityName: "Drinks", into: context)
        
        newDrink.setValue(name, forKey: "name")
        newDrink.setValue(description, forKey: "directions")
        newDrink.setValue(ingredients, forKey: "ingredients")
        
        if let image = newDrinkImage.image, let imageData = image.jpegData(compressionQuality: 1.0) {
            let imageName = "\(UUID().uuidString).jpg"
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            try? imageData.write(to: imagePath)
            newDrink.setValue(imageName, forKey: "img")
        }
        
        do {
            try context.save()
            print("New drink saved successfully")
        } catch {
            print("Failed to save new drink: \(error)")
        }
    }
    
    func checkCameraPermissions() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized:
            showCamera()
        case .denied:
            presentCameraSettings()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.showCamera()
                    }
                }
            }
        default:
            presentCameraSettings()
        }
    }
    
    func presentCameraSettings() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Camera Access Needed", message: "Camera access is required to take photos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .cancel, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            newDrinkImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
