

import UIKit
import CoreLocation

class AirportTableViewController: UITableViewController {
    
    //MARK: - Declared Variables
    let cellIdentifier = "DetailedFlightTableViewCell"
    var secondAirtportData = [MainTableViewModel]()
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .lightGray
    }

    private func configTableView() {
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.mapObject = secondAirtportData[indexPath.row]
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}

// MARK: - TableView Delegate & DataSource
extension AirportTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secondAirtportData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailedFlightTableViewCell
        cell.flightInfo = secondAirtportData[indexPath.row]
        return cell
    }
}
