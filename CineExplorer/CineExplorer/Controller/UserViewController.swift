import UIKit
import CoreData
import FirebaseAuth
class UserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userBirthday: UILabel!
    @IBOutlet weak var logout: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = userImage.frame.height / 2
        
        userImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera))
        userImage.addGestureRecognizer(tapGesture)
        
        if let email = UserDefaults.standard.string(forKey: "userEmail") {
            print(email)
            
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            fetchRequest.fetchLimit = 1
            
            do {
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    userName.text = user.name
                    userEmail.text = user.email
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    if let birthday = user.birthday {
                        let birthdayString = dateFormatter.string(from: birthday)
                        userBirthday.text = birthdayString
                    }
                    
                } else {
                    Helpers.showAlert(title: "Error", message: "El usuario o la contraseña son incorrectos o no registrados", on: self)
                }
            } catch {
                Helpers.showAlert(title: "Error", message: "Ocurrió un problema al verificar el usuario", on: self)
            }
        } else {
            Helpers.showAlert(title: "Error", message: "No email found in UserDefaults", on: self)
        }
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
    
    @objc func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            present(imagePicker, animated: true, completion: nil)
        } else {
            Helpers.showAlert(title: "Error", message: "Camera not available", on: self)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
            do {
                   try Auth.auth().signOut()
                   UserDefaults.standard.removeObject(forKey: "userEmail")
                   performSegue(withIdentifier: "logoutSegue", sender: self)
               } catch let signOutError as NSError {
                   Helpers.showAlert(title: "Error", message: "Error signing out: \(signOutError.localizedDescription)", on: self)
               }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
