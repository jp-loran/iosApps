//
//  MenuOptionCell.swift
//  GOW
//
//  Created by Juan Pablo Alvarez Loran on 08/03/24.
//

import UIKit

class MenuOptionCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let myFont = UIFont(name:"CGF Locust Resistance", size:17)
        let bodyMetrics = UIFontMetrics(forTextStyle: .body)
        menuLabel.font = bodyMetrics.scaledFont(for: myFont!)
        menuLabel.adjustsFontForContentSizeCategory = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
