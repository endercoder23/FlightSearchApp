//
//  MainTableViewModel.swift
//  FlightSearch
//
//  Created by Mind on 25/05/21.
//

import Foundation
enum flightData {
    case name
    case city
    case state
    case country
    case none
}

struct MainTableViewModel {
    
    let name: String?
    let city: String?
    let state: String?
    let country: String?
    let woeid: String?
    let runway_length: String?
    let direct_flights: String?
    let lon: String?
    let lat: String?
    
    init(flightDetails: FlightData){
        self.city = flightDetails.city
        self.state = flightDetails.state
        self.country = flightDetails.country
        self.name = flightDetails.name
        self.direct_flights = flightDetails.direct_flights
        self.runway_length = flightDetails.runway_length
        self.woeid = flightDetails.woeid
        self.lat = flightDetails.lat
        self.lon = flightDetails.lon
    }
}
protocol filteredFlightData {

}
