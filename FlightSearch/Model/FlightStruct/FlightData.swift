//
//  FlightData.swift
//  FlightSearch
//
//  Created by Mind on 07/05/21.
//

import Foundation
import Alamofire

struct FlightData: Codable{
    let name: String?
    let city: String?
    let state: String?
    let country: String?
    let woeid: String?
    let runway_length: String?
    let direct_flights: String?
    let lon: String?
    let lat: String?
    let carriers: String?
}

