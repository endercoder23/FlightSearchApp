//
//  DetailedFlightTableViewCell.swift
//  FlightSearch
//
//  Created by Mind on 07/05/21.
//

import UIKit

class DetailedFlightTableViewCell: UITableViewCell {
    @IBOutlet weak var nameOfAirport: UILabel!
    @IBOutlet weak var stateCountryName: UILabel!
    @IBOutlet weak var woeId: UILabel!
    @IBOutlet weak var runwayLength: UILabel!
    @IBOutlet weak var directFlights: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
