//
//  InfoViewController.swift
//  MarvelApp
//
//  Created by Juan Pablo Alvarez Loran on 07/05/24.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func infoAction(_ sender: Any) {
     
        let urlString = "https://developer.marvel.com/"
              
              if let url = URL(string: urlString) {
                  if UIApplication.shared.canOpenURL(url) {
                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
                  } else {
                      print("Invalid URL or unable to open.")
                  }
              } else {
                  print("Invalid URL string.")
              }
    }
    

}
