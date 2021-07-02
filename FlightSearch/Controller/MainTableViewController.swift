//
//  MainTableViewController.swift
//  FlightSearch
//
//  Created by Mind on 07/05/21.
//

import UIKit


class MainTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "FlightTableViewCell"
    let urLJSON = "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
    var flightData = [FlightData]()
    var nextVCFlightData = [FlightData]()
    var filteredData = [FlightData]()
    var searchButtonController = UISearchController(searchResultsController: nil)
    var searching = false
    var dataIndex : Int?

    

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .red
        self.navigationItem.searchController = searchButtonController
        configTableView()
        fetchFlightData()
        configureSearchController()
        
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func configureSearchController(){
        searchButtonController.loadViewIfNeeded()
        searchButtonController.searchResultsUpdater = self
        searchButtonController.searchBar.delegate = self
        searchButtonController.obscuresBackgroundDuringPresentation = false
        searchButtonController.searchBar.enablesReturnKeyAutomatically = false
        searchButtonController.searchBar.returnKeyType = UIReturnKeyType.go
        self.navigationItem.searchController = searchButtonController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchButtonController.searchBar.placeholder = "Search City"
        
        
    }
    
    func fetchFlightData() {

        let userUrl = "\(urLJSON)"
        print(userUrl)
        if let url = URL(string: userUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in

                guard error == nil, let safeData = data else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                let jsonDecoded = try? JSONDecoder().decode([FlightData].self, from: safeData)
//
                self.flightData.append(contentsOf: jsonDecoded!)
//                print(self.flightData)
//
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
    }
    private func configTableView() {
   
        self.tableView.register(UINib(nibName: "FlightTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        dataIndex = indexPath.section
        performSegue(withIdentifier: "PassToAirportDetail", sender: self)

    }
    
    func searchingData() -> Array<FlightData> {
        let indexPathData = filteredData[dataIndex!].city!
        if searching{
        for cityName in filteredData{
         
            if ((cityName.city!.lowercased().contains(indexPathData.lowercased()))){
                nextVCFlightData.append(cityName)
                print("yee\(nextVCFlightData)")
            }
        }
            return nextVCFlightData
        }
        else{
            let dataFlight = flightData[dataIndex!].city!
            for cityName in flightData{
             
                if ((cityName.city!.lowercased().contains(dataFlight.lowercased()))){
                    nextVCFlightData.append(cityName)
                    print("yee\(nextVCFlightData)")
                    
                }
            }
            return nextVCFlightData
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassToAirportDetail"{
            let secondTVC = segue.destination as! AirportTableViewController
            secondTVC.secondAirtportData = searchingData()
            
        }
    }
    
    
    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searching{
            return filteredData.count
        }
        else{
        return flightData.count
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 10
        }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! FlightTableViewCell
        if searching{
            if let stateName = self.filteredData[indexPath.section].state,
               let countryName = self.filteredData[indexPath.section].country{
             cell.cityLabel.text = self.filteredData[indexPath.section].city
             cell.stateCountryLabel.text = "\(stateName) \(countryName)"
             print("orewa")
           
            }
            print("hello")
            
            
            
        }else{
           if let stateName = self.flightData[indexPath.section].state,
              let countryName = self.flightData[indexPath.section].country{
            cell.cityLabel.text = self.flightData[indexPath.section].city
            cell.stateCountryLabel.text = "\(stateName) \(countryName)"
            print("orewa")
          
           }
            
        }
        return cell
       
    }

}

extension MainTableViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchButtonController.searchBar.text!
        if !searchText.isEmpty{
//            print("yeet")
            
            searching = true
            filteredData.removeAll()
            for cityName in flightData{
             
                if ((cityName.city!.lowercased().contains(searchText.lowercased()))){
                    filteredData.append(cityName)
                    print("uWu\(cityName)")
                }
            }
      
        }else{
            print("noice")
            searching=false
            filteredData.removeAll()
            filteredData = flightData
            
        }
        
        tableView.reloadData()
 
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("ahaa")
        searching = false
        filteredData.removeAll()
        tableView.reloadData()
    }
    
}
