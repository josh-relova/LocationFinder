//
//  LocationListViewController.swift
//  LocationFinder
//
//  Created by Joshua Relova on 23/05/2019.
//  Copyright © 2019 Joshua Relova. All rights reserved.
//

import UIKit
import Alamofire

protocol LocationListViewControllerDelegate : NSObjectProtocol {
    func didSelectLocation(locationName: String)
}

class LocationListViewController: UIViewController {

    @IBOutlet var locationTableView: UITableView!
    
    var locationArray = [LocationObject]()
    var previousRun = Date()
    weak var delegate: LocationListViewControllerDelegate?
    let minInterval = 0.05
    let searchBar:UISearchBar = UISearchBar(frame: CGRect.init(x: 0, y: 0, width: 300, height: 0))
    
    
    var headers: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        self.registerTableViewCells()
        self.fetchLocationList()
        
    }
    
    func setupNavBar() {
        searchBar.placeholder = "Search for a City"
        searchBar.delegate = self
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.hexStringToUIColor(hex: "#F1F1F2")
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.titleView = searchBar
    }
    
    func registerTableViewCells() {
        locationTableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
    }
    
    
    func fetchLocationList() {
        Alamofire.request("https://lemi.travel/api/v5/cities", method: .get, parameters: nil, encoding: Alamofire.JSONEncoding.default, headers: self.headers).responseJSON { (response) in
            if let locationList = response.result.value as? [[String:Any]] {
                for location in locationList {
                    if let locationData = LocationObject.fromJson(json: location) {
                        self.locationArray.append(locationData)
                    }
                }
            }
            self.locationTableView.reloadData()
        }
    }
    
    func fetchSearchedLocations(query: String) {
        Alamofire.request("https://lemi.travel/api/v5/cities?q=\(query)", method: .get, parameters: nil, encoding: Alamofire.JSONEncoding.default, headers: self.headers).responseJSON { (response) in
            if let locationList = response.result.value as? [[String:Any]] {
                self.locationArray.removeAll()
                for location in locationList {
                    if let locationData = LocationObject.fromJson(json: location) {
                        self.locationArray.append(locationData)
                    }
                }
            }
            self.locationTableView.reloadData()
        }
    }
}

extension LocationListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell {
            let location = locationArray[indexPath.row]
            cell.populateLocationCell(location: location)
            if indexPath.row == locationArray.count - 1 {
                cell.hideSepratorView()
            }
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let d = delegate, locationArray.count > 0 {
            d.didSelectLocation(locationName: locationArray[indexPath.row].name)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    
}

extension LocationListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchSearchedLocations(query: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchSearchedLocations(query: searchBar.text ?? "")
            searchBar.resignFirstResponder()
        }
    }
}


