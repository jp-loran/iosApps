//
//  PokemonDetailViewController.swift
//  PokemonDetail
//
//  Created by Juan Pablo Alvarez Loran on 29/02/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    @IBOutlet weak var pokemonDetailLabel: UILabel!
    @IBOutlet weak var pokemonDetailImage: UIImageView!
    @IBOutlet weak var pokemonDetailBackButton: UIButton!
    
    
    var receivedPokemon: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDetailImage.image = UIImage(named: receivedPokemon!.image)
        pokemonDetailLabel.text = receivedPokemon!.name
        pokemonAbilityLabel.text = receivedPokemon!.ability
        
        pokemonDetailBackButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
    }
    
    @objc func closeModal(){
        self.dismiss(animated: true)
    }
    
}
