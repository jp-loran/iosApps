//
//  PokemonDataManager.swift
//  PokemonDetail
//
//  Created by Juan Pablo Alvarez Loran on 29/02/24.
//

import Foundation

class PokemonDataManager{
    private var pokemons: [Pokemon] = []
    
    let pokemonsArray = [
        ["image": "0", "name": "Wartortle", "ability": "Cute Charm"],
        ["image": "1", "name": "Bulbasaur", "ability": "Keen Eye"],
        ["image": "2", "name": "Blastoise", "ability": "Overgrow"],
        ["image": "3", "name": "Butterfree", "ability": "Water Absorb"],
        ["image": "4", "name": "Ivysaur", "ability": "Blaze"],
        ["image": "5", "name": "Jigglypuf", "ability": "Chlorophyll"],
        ["image": "6", "name": "Charmander", "ability": "Swift Swim"],
        ["image": "7", "name": "Meowth", "ability": "Oblivious"],
        ["image": "8", "name": "Alacazam", "ability": "Sand Veil"],
        ["image": "9", "name": "Pidgey", "ability": "Water Absorb"],
        ["image": "10", "name": "Raichu", "ability": "Keen Eye"],
        ["image": "11", "name": "Rattata", "ability": "Chlorophyll"],
        ["image": "12", "name": "Vaporeon", "ability": "Cute Charm"],
        ["image": "13", "name": "Jynx", "ability": "Water Absorb"],
        ["image": "14", "name": "Venusaur", "ability": "Technician"],
        ["image": "15", "name": "Linea", "ability": "Water Absorb"],
        ["image": "16", "name": "Slowbro", "ability": "Overgrow"],
        ["image": "17", "name": "Dewgong", "ability": "Intimidate"],
        ["image": "18", "name": "Spearow", "ability": "Water Absorb"],
        ["image": "19", "name": "Wigglytuff", "ability": "Intimidate"],
        ["image": "20", "name": "Scyther", "ability": "Keen Eye"],
        ["image": "21", "name": "Golduk", "ability": "Keen Eye"],
        ["image": "22", "name": "Lapras", "ability": "Oblivious"],
        ["image": "23", "name": "Sandshrew", "ability": "Swift Swim"]
    ]
    
    func fetch(){
        for pokemon in pokemonsArray{
            pokemons.append(Pokemon(dict:pokemon))
        }
    }
    
    func getPokemon(at index: Int) -> Pokemon{
        return pokemons[index]
    }
    
    func countPokemons() -> Int {
        return pokemons.count
    }
}
