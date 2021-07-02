//
//  MainTableViewModel.swift
//  FlightSearch
//
//  Created by Mind on 25/05/21.
//

import Foundation
import Alamofire

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
    let carriers: String?

    
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
        self.carriers = flightDetails.carriers!
    }
}

//MARK: - Fetch Data From JSON
class FetchData{
    var flightData = [FlightData]()
    var flightViewModel = [MainTableViewModel]()
    let urLJSON = "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    func fetchFlightData(completion: @escaping(CompletionHandler)) {
        AF.request(urLJSON, method: .get).responseDecodable(of: [FlightData].self) { response in
            self.flightData = response.value ?? []
            self.flightViewModel = self.flightData.map({return MainTableViewModel(flightDetails: $0)})
            completion(true)
        }
    }

    func searchFlights(searchText: String, value: Bool) -> [MainTableViewModel] {
        if value {
            if let values = UserDefaults.standard.object(forKey: "SavedData") as? Data {
                let decoder = JSONDecoder()
                guard let loadedValues = try? decoder.decode(SavedData.self, from: values) else {
                    return flightViewModel
                }
                return flightViewModel.filter {
                    ($0.runway_length ?? "" > loadedValues.runwayLengthMin &&
                        $0.runway_length ?? ""  < loadedValues.runwayLengthMax) ||
                        ($0.direct_flights ?? "" > loadedValues.directFlightMin &&
                        $0.direct_flights ?? "" < loadedValues.directFlightMax) ||
                        ($0.carriers ?? "" > loadedValues.carriersMin &&
                        $0.carriers ?? "" < loadedValues.carrierMax) ||
                        loadedValues.selectedCountry.contains($0.country ?? "")
                }
            }
            return flightViewModel
        } else {
            if searchText.isEmpty ||
                searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return flightViewModel
            }else {
                return flightViewModel.filter {($0.city?.lowercased().contains(searchText.lowercased()) ?? false)}
            }
        }
    }
}

//MARK: - comments
   

