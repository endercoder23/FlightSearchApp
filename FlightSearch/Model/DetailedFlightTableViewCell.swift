//
//  DetailedFlightTableViewCell.swift
//  FlightSearch
//
//  Created by Mind on 07/05/21.
//

import UIKit

class DetailedFlightTableViewCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var nameOfAirport: UILabel!
    @IBOutlet weak var stateCountryName: UILabel!
    @IBOutlet weak var woeId: UILabel!
    @IBOutlet weak var runwayLength: UILabel!
    @IBOutlet weak var directFlights: UILabel!

    // MARK:- Declared Variables
    var flightInfo : MainTableViewModel? {
        didSet {
            if let flightInfo = flightInfo {
                nameOfAirport.text = flightInfo.name ?? "NA"
                stateCountryName.text = "\(flightInfo.state ?? "NA") \(flightInfo.country ?? "NA")"
                woeId.text = flightInfo.woeid ?? "NA"
                runwayLength.text = (flightInfo.runway_length ?? "NA") + "Km"
                directFlights.text = flightInfo.direct_flights ?? "NA"
            }
        }
    }
    
    //MARK: - Nib Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
