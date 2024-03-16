//
//  WeaponsCell.swift
//  GOW
//
//  Created by Juan Pablo Alvarez Loran on 09/03/24.
//

import UIKit

class WeaponsCell: UITableViewCell {

    @IBOutlet weak var weaponLabel: UILabel!
    
    @IBOutlet weak var weaponImage: UIImageView!
    
    
    @IBOutlet weak var weaponDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
