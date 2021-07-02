//
//  AirportTableViewController.swift
//  FlightSearch
//
//  Created by Mind on 07/05/21.
//

import UIKit

class AirportTableViewController: UITableViewController {
    
    let cellIdentifier = "DetailedFlightTableViewCell"
    var flightInfo : FlightData?
    var secondAirtportData = [FlightData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        print(secondAirtportData)
        
        
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func configTableView() {
   
        self.tableView.register(UINib(nibName: "DetailedFlightTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return secondAirtportData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 10
        }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hiya")
        let secondAirport = secondAirtportData[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailedFlightTableViewCell
        let stateName = secondAirport.state ?? "NA"
        let countryName = secondAirport.country ?? "NA"
        let directF = secondAirport.direct_flight ?? "NA"
        let runwayL = secondAirport.runway_Length ?? "NA"
        let airportName = secondAirport.name ?? "NA"
        let id = secondAirport.woeid ?? "NA"
        
        cell.nameOfAirport.text = airportName
        cell.directFlights.text = directF
        cell.runwayLength.text = runwayL
        cell.stateCountryName.text = "\(stateName) \(countryName)"
            cell.woeId.text = id
      
        
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
