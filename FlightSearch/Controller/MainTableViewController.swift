
import UIKit
import RangeSeekSlider
import Alamofire

class MainTableViewController: UITableViewController {
    
    //MARK: - Declared Variables
    @IBOutlet weak var filterButton: UIBarButtonItem!
    private let cellReuseIdentifier = "FlightTableViewCell"
    var filteredViewModel = [MainTableViewModel]()
    var filteredviewModelObject: MainTableViewModel?
    private var filData: Bool = false
    var dataIndex: Int = 0
    let urLJSON = "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
    var boolForCountry: Bool = false
    var fetchData = FetchData()
    var location = LocationManager()
    lazy var searchController : UISearchController = {
        var searchController = UISearchController(searchResultsController: nil)
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search City", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.go
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        return searchController
    }()
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .lightGray
        configTableView()
        filData = false
        self.navigationItem.searchController = searchController
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadData(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool)   {
        fetchData.fetchFlightData( completion: { (success) -> Void in
            if success{
                self.filterAndReload()
            }
        })
    }
    //MARK:- Helper Methods
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem){
        showFilterVC()
    }
    
    private func showFilterVC(){
        let flightViewModelData = fetchData.flightViewModel
        let slideVC = FilterScreenView()
        slideVC.numberOfCountries = flightViewModelData
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    private func configTableView() {
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    @objc func loadData(notification: NSNotification){
        self.filteredViewModel = fetchData.searchFlights(searchText: searchController.searchBar.text!, value: true)
        print(self.filteredViewModel.count)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func filterAndReload() {
        self.filteredViewModel = getFilteredRecord()
        tableView.reloadData()
    }
    
    private func getFilteredRecord() -> [MainTableViewModel] {
        return fetchData.searchFlights( searchText: searchController.searchBar.text!, value: false)
    }
}

// MARK: - TableView Delegate & DataSource
extension MainTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! FlightTableViewCell
        cell.mainTableViewModel = filteredViewModel[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataIndex = indexPath.row
        filData = true
        let AirportVC = storyboard?.instantiateViewController(withIdentifier: "AirportTableViewController") as! AirportTableViewController
        AirportVC.secondAirtportData = getFilteredRecord()
        self.navigationController?.pushViewController(AirportVC, animated: true)
    }
}

// MARK: - UISearchControllerDelegate, UISearchBarDelegate
extension MainTableViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filData = false
        self.filterAndReload()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filterAndReload()
    }
}

//MARK: - Half View Transition Delegate
extension MainTableViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        FIlterViewController(presentedViewController: presented, presenting: presenting)
    }
}


//MARK: - Important comment


/*func fetchData(){
 
 
 .responseJSON { (response) in
 switch response.result {
 case .success(let value):
 if let JSON = value as? [String: Any] {
 let status = JSON["status"] as! String
 print(status)
 }
 case .failure(let error): break
 // error handling
 }
 }
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
 self.flightData.append(contentsOf: jsonDecoded!)
 DispatchQueue.main.async {
 self.tableView.reloadData()
 }
 }
 task.resume()
 }
 
 
 }*/
