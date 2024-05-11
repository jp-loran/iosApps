//
//  RegisterViewController.swift
//  CineExplorer
//
//  Created by Juan Pablo Alvarez Loran on 11/05/24.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var birthdayField: UIDatePicker!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        guard let name = nameField.text, !name.isEmpty else {
            Helpers.showAlert(title: "Información incompleta", message: "El nombre es requerido", on:self)
           return
       }
               
       guard let lastName = lastNameField.text, !lastName.isEmpty else {
           Helpers.showAlert(title: "Información incompleta", message: "El apellido es requerido", on:self)
           return
       }
       
       // Check if the email is empty or not in a valid email pattern
       guard let email = emailField.text, !email.isEmpty else {
           Helpers.showAlert(title: "Información incompleta", message: "El correo electrónico es requerido",on:self)
           return
       }
       
        if !Helpers.isValidEmail(email) {
           Helpers.showAlert(title: "Formato incorrecto", message: "Por favor, ingresa un email válido.",on:self)
           return
       }
       
       guard let password = passwordField.text, !password.isEmpty else {
           Helpers.showAlert(title: "Información incompleta", message: "La contraseña es requerida",on:self)
           return
       }
       
      let selectedDate = birthdayField.date
        
      let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "email == %@", email)
      fetchRequest.fetchLimit = 1
        
        
    do {
        let users = try context.fetch(fetchRequest)

        if users.first != nil {
                Helpers.showAlert(title:"Error al registrar", message: "Ya existe un usuario con el email registrado", on:self){
                    self.dismiss(animated: true, completion: nil)
                }
              } else {
                  let newUser = User(context: self.context)
                  newUser.name = name
                  newUser.lastName = lastName
                  newUser.email = email
                  newUser.password = password
                  newUser.birthday = selectedDate
                  
                  do {
                      try context.save()
                      performSegue(withIdentifier: "showWelcomeScreen", sender: self)
                      
                  } catch {
                      Helpers.showAlert(title: "Error", message: "Hubo un problema al guardar el usuario",on:self)
                  }
              }
    } catch {
        Helpers.showAlert(title: "Error", message: "Ocurrió un problema al verificar el usuario", on: self)
    }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWelcomeScreen" {
            if let destinationVC = segue.destination as? WelcomeViewController,
               let name = nameField.text, !name.isEmpty {
                destinationVC.userName = name
            }
        }
    }
}
