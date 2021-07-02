//
//  MapViewModel.swift
//  FlightSearch
//
//  Created by Mind on 26/05/21.
//


import UIKit
import MapKit
import CoreLocation

//MARK: - CustomPin Class
class customPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(pinTitle: String, pinSubTitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

//MARK: - Methods For MEasuring Distance
class GetDistance {
    let locationManager = CLLocationManager()
    func setDistance(mapObject: MainTableViewModel) -> String {
        let mapLatitude = mapObject.lat
        let mapLongitude = mapObject.lon
        let dest = CLLocationCoordinate2D(latitude: Double(mapLatitude!)!, longitude: Double(mapLongitude!)!)
        let location1 = CLLocation(latitude: Double(mapLatitude!)!, longitude: Double(mapLongitude!)!)
        let destinationLocation =  CLLocation(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
        let distance = destinationLocation.distance(from: location1) / 1000
        return String(format: "%.0f", distance) + "Km"
    }
    
    func getDirections(mapObject: MainTableViewModel) -> (customPin, customPin, CLLocationCoordinate2D, CLLocationCoordinate2D) {
        let mapLatitude = mapObject.lat
        let mapLongitude = mapObject.lon
        let destination = CLLocationCoordinate2D(latitude: Double(mapLatitude!)!, longitude: Double(mapLongitude!)!)
        let sourceLocation =  CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
        let destinationCoordinates = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)
        let sourcePin = customPin(pinTitle: "Your Location", pinSubTitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: mapObject.name!, pinSubTitle: "", location: destinationCoordinates)
        return (sourcePin, destinationPin, sourceLocation, destinationCoordinates)
    }
}

//MARK: - Methods For Mark User Location
class LocationManager: NSObject {
    
    static let shared = LocationManager()
    var currentLocation: CLLocation?
    fileprivate let locationManager = CLLocationManager()
    
    func centerViewOnUserLocation() -> MKCoordinateRegion {
        let regionInMeters: Double = 10000
        let location = locationManager.location?.coordinate
        let region = MKCoordinateRegion.init(center: location!, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        return region
    }
    
    func isLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled(){
            startUpdatingLocation()
        } else {}
    }

    func startUpdatingLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
}

// MARK: -
extension LocationManager: CLLocationManagerDelegate {

// MARK: - CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let locValue = manager.location else { return }
        self.currentLocation = locValue
        self.locationManager.stopUpdatingLocation()
        print("CLLocationManager: Locations = \(locValue.coordinate.latitude) \(locValue.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.currentLocation = nil
        print("CLLocationManager: \(error)")
    }
}


//MARK:- Comments
//    var isLocationServiceAuthorized: Bool {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedAlways, .authorizedWhenInUse:
//            return true
//        case .denied, .restricted:
//            return false
//        default:
//            return false
//        }
//    }
