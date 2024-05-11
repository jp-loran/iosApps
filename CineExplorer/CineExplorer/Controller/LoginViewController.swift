//
//  LoginViewController.swift
//  CineExplorer
//
//  Created by Juan Pablo Alvarez Loran on 10/05/24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let username = userField.text, !username.isEmpty else {
            Helpers.showAlert(title: "Información incompleta", message: "Ingresa un email", on: self)
            return
        }
        
        if !Helpers.isValidEmail(username) {
            Helpers.showAlert(title: "Formato incorrecto", message: "Por favor, ingresa un email válido.", on: self)
                return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            Helpers.showAlert(title: "Información incompleta", message: "Ingresa la contraseña", on: self)
            return
        }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", username, password)
        fetchRequest.fetchLimit = 1

             do {
                 let users = try context.fetch(fetchRequest)

                       if let user = users.first {
                           if let userName = user.name {
                               Helpers.showAlert(title:"Inicio de sesión exitoso", message: "Iniciando sesión para el usuario \(userName)...", on:self)
                           }
                       } else {
                           Helpers.showAlert(title: "Error", message: "El usuario o la contraseña son incorrectos o no registrados", on: self)
                       }
             } catch {
                 Helpers.showAlert(title: "Error", message: "Ocurrió un problema al verificar el usuario", on: self)
             }
        
    }
    
    @IBAction func registerAction(_ sender: Any) {
        performSegue(withIdentifier: "showRegisterScreen", sender: self)
    }
    
}
