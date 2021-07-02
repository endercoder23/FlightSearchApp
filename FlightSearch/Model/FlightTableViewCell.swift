//
//  FlightTableViewCell.swift
//  FlightSearch
//
//  Created by Mind on 07/05/21.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
