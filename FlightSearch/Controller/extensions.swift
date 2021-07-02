//
//  extensions.swift
//  FlightSearch
//
//  Created by Mind on 25/05/21.
//

import Foundation
import Alamofire
import MapKit
//MARK: -   CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}


// MARK: - MAPVIEWCONTROLLER Functions for Get Direction
extension MapViewController: MKMapViewDelegate {
    
    func getDirection() {
        let getDistance = GetDistance()
        let sourcePin = getDistance.getDirections(mapObject: mapObject!).0
        let destinationPin = getDistance.getDirections(mapObject: mapObject!).1
        let sourceLocation = getDistance.getDirections(mapObject: mapObject!).2
        let destinationCoordinates = getDistance.getDirections(mapObject: mapObject!).3
        self.mapViewKit.addAnnotation(sourcePin)
        self.mapViewKit.addAnnotation(destinationPin)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        directionRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate{(response, error) in
            guard let directionRsponse = response else  {
                if let error = error {
                    print("error is \(error)")
                    self.alert(error.localizedDescription)
                }
                return
            }
            let route = directionRsponse.routes[0]
            self.mapViewKit.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapViewKit.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        self.mapViewKit.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        return renderer
    }
    func alert(_ message : String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}


extension String {
  func CGFloatValue() -> CGFloat? {
    guard let doubleValue = Double(self) else {
      return nil
    }
    return CGFloat(doubleValue)
  }
}


extension CGFloat {
  func StringValue() -> String {
    return "\(self)"
  }
}
