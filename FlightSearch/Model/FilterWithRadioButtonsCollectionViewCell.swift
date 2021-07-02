
import UIKit
protocol FilterWithRadioButtonsCollectionViewCellDelegate: AnyObject {
    func didTapRadioButton(Index: Int)
}

class FilterWithRadioButtonsCollectionViewCell: UICollectionViewCell {
//MARK: - Outlets and Declared Variables
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var flightCountry: UILabel!
    let filterScreen = FilterScreenView()
    public weak var delegate: FilterWithRadioButtonsCollectionViewCellDelegate?

//MARK: - Nib Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        tapGestureForLabel()
    }
    
    func tapGestureForLabel() {
        flightCountry.isUserInteractionEnabled = true
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(didTapCountryLabel))
        flightCountry.addGestureRecognizer(tapLabel)
    }
    
    @objc func didTapCountryLabel() {
        delegate?.didTapRadioButton(Index: radioButton.tag)
    }
    
    @IBAction func radioButtonSelected(_ sender: UIButton) {
        delegate?.didTapRadioButton(Index: radioButton.tag)
    }
}

    
    

