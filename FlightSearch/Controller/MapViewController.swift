
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
//MARK: - Outlets
    @IBOutlet weak var mapViewKit: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stateCountryLabel: UILabel!
    @IBOutlet weak var runwayLengthLabel: UILabel!
    
//MARK: - Declared Variables
    let locationManager = CLLocationManager()
    let cellIdentifier = "MapViewTableViewController"
    let regionInMeters: Double = 10000
    var directionArray: [MKDirections] = []
    var mapObject: MainTableViewModel?
    var mapData = [MainTableViewModel]()
    var distance = GetDistance()
    var location = LocationManager()
    
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        location.isLocationServicesEnabled()
        checkLocationAuthorization()
        setFlightInformation()
    }

 //MARK: - User Output
    func setFlightInformation() {
        let countryeName = mapObject?.country ?? "NA"
        let stateName = mapObject?.state ?? "NA"
        cityNameLabel.text = mapObject?.city ?? "NA"
        stateCountryLabel.text = "\(stateName) \(countryeName)"
        runwayLengthLabel.text = (mapObject?.runway_length ?? "NA") + "KM"
    }
    
    func setDistance(){
        distanceLabel.text = distance.setDistance(mapObject: mapObject!)


    }
//MARK: - Location Services

    func centerViewOnUserLocation() {
        mapViewKit.setRegion(location.centerViewOnUserLocation(), animated: true)
    }

    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapViewKit.showsUserLocation = true
            centerViewOnUserLocation()
            setDistance()
            getDirection()
            //do map stuff
            break
        case .denied:
            let alert = UIAlertController(title: "error", message: "You have denied showing your location please turn it on before proceed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
}

}









/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


//MARK: - PIN

//class customPin: NSObject, MKAnnotation{
//    var coordinate: CLLocationCoordinate2D
//    var title: String?
//    var subtitle: String?
//    init(pinTitle: String, pinSubTitle: String, location: CLLocationCoordinate2D) {
//        self.title = pinTitle
//        self.subtitle = pinSubTitle
//        self.coordinate = location
//    }
//}


//func mapView(){
//    let sourceLocation =  CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
//            let destinationCoordinates = CLLocationCoordinate2D(latitude: 23.033414, longitude: 72.524764)
//            let sourcePin = customPin(pinTitle: "Your Location", pinSubTitle: "", location: sourceLocation)
//            let destinationPin = customPin(pinTitle: "Random", pinSubTitle: "", location: destinationCoordinates)
//            self.mapViewKit.addAnnotation(sourcePin)
//            self.mapViewKit.addAnnotation(destinationPin)
//            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
//            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
//
//            let directionRequest = MKDirections.Request()
//            directionRequest.source = MKMapItem(placemark: sourcePlacemark)
//            directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
//    directionRequest.transportType = .any
//            directionRequest.requestsAlternateRoutes = true
//
//            let directions = MKDirections(request: directionRequest)
//            directions.calculate{(response, error) in
//                guard let directionRsponse = response else  {
//                    if let error = error {
//                        print("No routes posible")
//
//                    }
//
//                    return
//                }
//                print(directionRsponse.routes[0])
//}
//
//}




//MARK: - user location function
//    func centerViewOnUserLocation() {
//        if let location = locationManager.location?.coordinate {
//            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//            mapViewKit.setRegion(region, animated: true)
//        }
//
//    }


//func setDistance(){
    //        let region = MKCoordinateRegion.init(center: dest, latitudinalMeters: Double(1500), longitudinalMeters: Double(1500))
    //        mapViewKit.setRegion(region, animated: true)
    //        getDirection(destination: dest, name: (mapObject?.name)!)
    //    setPinUsingMKPlacemark(location: dest)
//        setPinUsingMKPlacemark(location: dest)
    
//}

//
//    func setPinUsingMKPlacemark(location: CLLocationCoordinate2D) {
//        let pin = MKPlacemark(coordinate: location)
//        let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)  //800
//        mapViewKit.setRegion(coordinateRegion, animated: true)
//        mapViewKit.addAnnotation(pin)
//    }
//
//    func setPinUsingMKPlacemark(location: CLLocationCoordinate2D) {
//        let pin = MKPlacemark(coordinate: location)
//        let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)  //800
//        mapViewKit.setRegion(coordinateRegion, animated: true)
//        mapViewKit.addAnnotation(pin)
//    }
//            setPinUsingMKPlacemark(location: dest)

