//
//  DetailViewController.swift
//  P2-M9
//
//  Created by Juan Pablo Alvarez Loran on 18/07/24.
//

import UIKit

class DetailViewController: UIViewController {

    var drink: Drinks?;
    
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkDescription: UILabel!
    @IBOutlet weak var drinkIngredients: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drinkName.text = drink?.name
        drinkDescription.text = drink?.directions
        drinkIngredients.text = drink?.ingredients
        if let imageName = drink?.img {
            loadDrinkImage(imageName)
        }
    }
    
    func loadDrinkImage(_ imageName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localImagePath = documentsDirectory.appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: localImagePath.path) {
            drinkImage.image = UIImage(contentsOfFile: localImagePath.path)
        } else {
            let imageUrlString = "http://janzelaznog.com/DDAM/iOS/drinksimages/\(imageName)"
            guard let imageUrl = URL(string: imageUrlString) else {
                print("Invalid image URL")
                return
            }
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.drinkImage.image = image
                        }
                        
                        // Save the image to local storage
                        do {
                            try data.write(to: localImagePath)
                        } catch {
                            print("Failed to save image: \(error)")
                        }
                    } else {
                        print("Failed to create image from data")
                    }
                } else {
                    print("Failed to download image")
                }
            }
        }
    }
}
