//
//  ViewController.swift
//  URLSession
//
//  Created by Juan Pablo Alvarez Loran on 03/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Crete configuration for URLSession
           let configuration = URLSessionConfiguration.default
           //Set timeout for request
           configuration.timeoutIntervalForResource = 5
           
           // Create a URLSession with default configuration
           let session = URLSession(configuration: configuration)

           // Create URL
   //        if let url = URL(string: "https://httpstat.us/200?sleep=10000") {
           if let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") {
               
               // Create URLRequest
               let request = URLRequest(url: url)
               
               
               // Create a data task
               let task = session.dataTask(with: request) { data, response, error in
                   
                   // Handle the response here
                   
                   //Check for error
                   if let error = error {
                       print("Error: ", error.localizedDescription)
                       return
                   }
                   
                   //Check for data
                   guard let data = data else {
                       print("No data received!")
                       return
                   }
                   
                   //Try to parse JSON data
                   do {
                       let jsonObject = try JSONSerialization.jsonObject(with: data)
                       print(jsonObject)  // Use the JSON data
                   } catch let error {
                       print("Error: ", error)
                   }
               }
               
               // Start the task
               task.resume()
           }


    }


}

