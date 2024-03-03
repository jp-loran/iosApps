//
//  PokemonCell.swift
//  PokemonDetail
//
//  Created by Juan Pablo Alvarez Loran on 29/02/24.
//

import UIKit

class PokemonCell: UITableViewCell {

    
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
