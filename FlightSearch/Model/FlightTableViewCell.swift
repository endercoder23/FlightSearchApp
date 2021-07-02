//
//  FlightTableViewCell.swift
//  FlightSearch
//
//  Created by Mind on 07/05/21.
//

import UIKit
class FlightTableViewCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateCountryLabel: UILabel!
    
    //MARK: - Declared Variables
    var mainTableViewModel: MainTableViewModel? {
        didSet{
            if let mainTableViewModel = mainTableViewModel {
                cityLabel.text = mainTableViewModel.city ?? "NA"
                stateCountryLabel.text = "\(mainTableViewModel.state ?? "NA") \(mainTableViewModel.country ?? "NA")"
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
