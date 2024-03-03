//
//  Pokemon.swift
//  PokemonDetail
//
//  Created by Juan Pablo Alvarez Loran on 29/02/24.
//

import Foundation


struct Pokemon{
    let name : String
    let image : String
    let ability: String
    
    init(dict: [String:String]) {
        self.name = dict["name"]!
        self.image = dict["image"]!
        self.ability = dict["ability"]!
    }
}
