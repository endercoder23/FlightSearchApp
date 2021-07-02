//
//  FilterScreenView.swift
//  FlightSearch
//
//  Created by Mind on 10/06/21.
//

import UIKit
import RangeSeekSlider

class FilterScreenView: UIViewController {
    @IBOutlet weak var dragView: UIView!
    @IBOutlet weak var FilterButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var numberOfDirectFlights: RangeSeekSlider!
    @IBOutlet weak var runwayLength: RangeSeekSlider!
    @IBOutlet weak var numberOfCarriers: RangeSeekSlider!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelUIbutton: UIButton!
    var flightCountries : MainTableViewModel?
    var numberOfCountries = [MainTableViewModel]()
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FilterWithRadioButtonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterWithRadioButtonsCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        dragView.roundCorners(.allCorners, radius: 10)
        configureSlider()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin{
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureSlider(){
        runwayLength.delegate = self
        numberOfCarriers.delegate = self
        numberOfDirectFlights.delegate = self
        runwayLength.numberFormatter.positiveSuffix = "Meters"
    }

}

extension FilterScreenView: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === runwayLength {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

extension FilterScreenView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCountries.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterWithRadioButtonsCollectionViewCell", for: indexPath) as! FilterWithRadioButtonsCollectionViewCell
        cell.countriesData = numberOfCountries[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let imgWidth = collectionView.frame.width / 3 - 1

        return CGSize(width: imgWidth, height: imgWidth)
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
//MARK :-

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
