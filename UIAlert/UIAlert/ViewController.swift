//
//  ViewController.swift
//  UIAlert
//
//  Created by Juan Pablo Alvarez Loran on 09/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func alertButton(_ sender: UIButton) {
        //Create alert controller
         let alertMessage = UIAlertController(title: "Título del mensaje", message: "Mensaje informativo", preferredStyle: .alert)
         
         //Create UIAlertAction's instance
         let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
         
         //Add action to alert controller
         alertMessage.addAction(okAction)
         
         //Display alert controller
         self.present(alertMessage, animated: true, completion: nil)    }
    
    
    @IBAction func dialogButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

