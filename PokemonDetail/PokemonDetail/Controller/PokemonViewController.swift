//
//  PokemonViewController.swift
//  PokemonDetail
//
//  Created by Juan Pablo Alvarez Loran on 29/02/24.
//

import UIKit

class PokemonViewController: UIViewController {

    let pokemonDataManager = PokemonDataManager()
    var selectedPokemon: Pokemon?
    @IBOutlet weak var pokemonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDataManager.fetch()
        var i=0
        while i<pokemonDataManager.countPokemons(){
            i+=1
        }
        // Do any additional setup after loading the view.
    }
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonDataManager.countPokemons()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonCell
        let pokemon = pokemonDataManager.getPokemon(at: indexPath.row)
        cell.pokemonImage.image = UIImage(named: pokemon.image)
        cell.pokemonLabel.text = pokemon.name
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pokemons"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIImageView(image: UIImage(named: "Pokemon"))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected \(indexPath.row)")
        selectedPokemon = pokemonDataManager.getPokemon(at: indexPath.row)
        self.performSegue(withIdentifier: "detailSegue", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PokemonDetailViewController
        destination.receivedPokemon = selectedPokemon
    }

}
