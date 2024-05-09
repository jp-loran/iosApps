//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Juan Pablo Alvarez Loran on 06/05/24.
//

import UIKit
import CoreData

class CharacterDetailViewController: UIViewController {

    var character: Character?
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterDescription: UILabel!
    
    @IBOutlet weak var characterUrl: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: character!.thumbnail.url)
        
        characterName.text = character!.name
        characterImage.sd_setImage(with: url)
        characterUrl.text = character!.urls[0].url
        
        if let description = character?.description, !description.isEmpty {
            characterDescription.text = description
        } else {
            characterDescription.text = "This character has no description"
        }
        
    }
    
    
    @IBAction func addFavorite(_ sender: Any) {
        
        let favCharacter = CharacterFavorite(context: self.context)
        favCharacter.name = character!.name
        favCharacter.desc = character!.description
        favCharacter.thumbnail = character!.thumbnail.url
        
        do{
            try context.save()
            dismiss(animated: true, completion: nil)
        }catch{
            print("ERROR")
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
