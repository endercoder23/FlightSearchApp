
import UIKit
import RangeSeekSlider

class FilterScreenView: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var dragView: UIView!{
        didSet{
            dragView.roundCorners(.allCorners, radius: 10)
        }
    }
    @IBOutlet weak var FilterButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!{
        didSet{
            resetButton.clipsToBounds = true
            resetButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var numberOfDirectFlights: RangeSeekSlider!
    @IBOutlet weak var runwayLength: RangeSeekSlider!
    @IBOutlet weak var numberOfCarriers: RangeSeekSlider!
    @IBOutlet weak var ApplyButton: UIButton!{
        didSet{
            ApplyButton.clipsToBounds = true
            ApplyButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelUIbutton: UIButton!{
        didSet{
            cancelUIbutton.layer.cornerRadius = cancelUIbutton.bounds.width/2
        }
    }
    
    //MARK: - Delcared Variables
    var boolValue: Bool = false
    var countryObject: FilteredCountry?
    var numberOfCountries = [MainTableViewModel]()
    var filteredCountry: Array<FilteredCountry>?
    
    //MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FilterWithRadioButtonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterWithRadioButtonsCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        configureSlider()
        fetchingDataFromMainVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    //MARK: - Helper Methods
    func configureSlider(){
        runwayLength.delegate = self
        numberOfCarriers.delegate = self
        numberOfDirectFlights.delegate = self
        runwayLength.numberFormatter.positiveSuffix = "Meters"
        let minValueOfRunwayLength = numberOfCountries.min{$0.runway_length ?? "0" < $1.runway_length ?? "0"}?.runway_length ?? "0"
        let maxValueOfRunwayLength = numberOfCountries.max{$0.runway_length ?? "0" < $1.runway_length ?? "0"}?.runway_length ?? "0"
        let minValueOfDirectFlight = numberOfCountries.min{$0.direct_flights ?? "0" < $1.direct_flights ?? "0"}?.direct_flights ?? "0"
        let maxValueOfDirectFlight = numberOfCountries.max{$0.direct_flights ?? "0" < $1.direct_flights ?? "0"}?.runway_length ?? "0"
        let minCarriers = numberOfCountries.min{$0.carriers ?? "0" < $1.carriers ?? "0"}?.carriers ?? "0"
        let maxCarriers = numberOfCountries.max{$0.carriers ?? "0" < $1.carriers ?? "0"}?.carriers ?? "0"
        runwayLength.minValue = minValueOfRunwayLength.CGFloatValue() ?? 0.0
        runwayLength.maxValue = maxValueOfRunwayLength.CGFloatValue() ?? 0.0
        numberOfDirectFlights.minValue = minValueOfDirectFlight.CGFloatValue() ?? 0.0
        numberOfDirectFlights.maxValue = maxValueOfDirectFlight.CGFloatValue() ?? 0.0
        numberOfCarriers.minValue = minCarriers.CGFloatValue() ?? 0.0
        numberOfCarriers.maxValue = maxCarriers.CGFloatValue() ?? 0.0
    }
    
    func loadData(){
        
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedData")
            as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(SavedData.self, from: savedPerson) {
                self.runwayLength.selectedMinValue = loadedPerson.runwayLengthMin.CGFloatValue() ?? 0.0
                self.runwayLength.selectedMaxValue = loadedPerson.runwayLengthMax.CGFloatValue() ?? 0.0
                self.numberOfDirectFlights.selectedMinValue = loadedPerson.directFlightMin.CGFloatValue() ?? 0.0
                self.numberOfDirectFlights.selectedMaxValue = loadedPerson.directFlightMax.CGFloatValue() ?? 0.0
                self.numberOfCarriers.selectedMinValue = loadedPerson.carriersMin.CGFloatValue() ?? 0.0
                self.numberOfCarriers.selectedMaxValue = loadedPerson.carrierMax.CGFloatValue() ?? 0.0
                print(loadedPerson.selectedCountry)
                loadedPerson.selectedCountry.forEach{ country in
                    if let index = filteredCountry!.firstIndex(where: { $0.country == country}) {
                        filteredCountry![index].isSelected = true
                    }
                }
            }
        }
    }
    
    func fetchingDataFromMainVC() {
        var filteredCountry = Array(Set(self.numberOfCountries.compactMap({ ($0.country!)
        })))
        filteredCountry = (filteredCountry.filter({ $0 != ""}))
        filteredCountry.sort()
        self.filteredCountry = filteredCountry.map{FilteredCountry(country: $0)}
    }
    
    //MARK: - IBactions methods
    @IBAction func applyButton(_ sender: UIButton) {
        let countryArray = self.filteredCountry!.filter{$0.isSelected}.map{ $0.country}
        print(countryArray)
        let savedData = SavedData(runwayLengthMin: runwayLength.selectedMinValue.StringValue(),
                             runwayLengthMax: runwayLength.selectedMaxValue.StringValue(),
                             directFlightMin: numberOfDirectFlights.selectedMinValue.StringValue(),
                             directFlightMax: numberOfDirectFlights.selectedMaxValue.StringValue(),
                             carriersMin: numberOfCarriers.selectedMinValue.StringValue(),
                             carrierMax: numberOfCarriers.selectedMaxValue.StringValue(),
                             selectedCountry: countryArray)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedData) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedData")
        }
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "SavedData")
        runwayLength.selectedMinValue = 0
        runwayLength.selectedMaxValue = 0
        numberOfDirectFlights.selectedMinValue = 0
        numberOfDirectFlights.selectedMaxValue = 0
        numberOfCarriers.selectedMinValue = 0
        numberOfCarriers.selectedMaxValue = 0
        for i in 0..<filteredCountry!.count {
            filteredCountry![i].isSelected = false
        }
        collectionView.reloadData()
        
    }
    
    @IBAction func runwayLengthValue(_ sender: RangeSeekSlider) {
        
    }
    
    @IBAction func directFlightValue(_ sender: RangeSeekSlider) {
        
    }
    
    @IBAction func carriersValue(_ sender: RangeSeekSlider) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: - extension RangeSeek Slider
extension FilterScreenView: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider == runwayLength {
        }
        else if slider == numberOfDirectFlights {
            
        } else if slider == numberOfCarriers {
            
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

//MARK: - collectionView Delegates
extension FilterScreenView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCountry!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterWithRadioButtonsCollectionViewCell", for: indexPath) as! FilterWithRadioButtonsCollectionViewCell
        
        cell.flightCountry.text = filteredCountry![indexPath.row].country
        cell.radioButton.tag = indexPath.row
        cell.radioButton.isSelected = filteredCountry![indexPath.row].isSelected
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let imgWidth = collectionView.frame.width / 1.5
        return CGSize(width: imgWidth, height: imgWidth - 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
extension FilterScreenView: FilterWithRadioButtonsCollectionViewCellDelegate {
    func didTapRadioButton(Index: Int) {
        self.filteredCountry![Index].isSelected.toggle()
        collectionView.reloadData()
    }
}

//MARK: -
//            if let indexOfFilteredCountry = filteredCountry!.firstIndex(where: {$0.isSelected == true}){
//                filteredCountry![indexOfFilteredCountry].isSelected = false
//            }

//view did load()
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
//        view.addGestureRecognizer(panGesture)

//    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
//        let translation = sender.translation(in: view)
//
//        //not allowing user to drag the view upward
//        guard translation.y >= 0 else {return}
//
//        //setting x as 0 because we dont want users to move the frame side ways!! only straight up or down
//        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
//
//        if sender.state == .ended {
//            let dragVelocity = sender.velocity(in: view)
//            if dragVelocity.y >= 1300 {
//                self.dismiss(animated: true, completion: nil)
//            } else {
//                UIView.animate(withDuration: 0.3) {
//                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
//                }
//            }
//        }
//    }

//       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterWithRadioButtonsCollectionViewCell", for: indexPath) as! FilterWithRadioButtonsCollectionViewCell
//        cell.flightCountry.minimumScaleFactor = 0.5
//        cell.flightCountry.adjustsFontSizeToFitWidth = true
//        cell.flightCountry.numberOfLines = 0
//        cell.flightCountry.sizeToFit()
