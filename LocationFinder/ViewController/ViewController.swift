//
//  ViewController.swift
//  LocationFinder
//
//  Created by Joshua Relova on 23/05/2019.
//  Copyright © 2019 Joshua Relova. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LocationListViewControllerDelegate {
    
    @IBOutlet var mainTableView: UITableView!
    
    var selectedLocation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.registerTableViewCells()
    }
    
    
    func registerTableViewCells() {
        mainTableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleTableViewCell")
    }
    
    func didSelectLocation(locationName: String) {
        selectedLocation = locationName
        mainTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationListSegue" {
            if let locationListVC: LocationListViewController = segue.destination as? LocationListViewController {
                locationListVC.delegate = self
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedLocation.count > 0 {
           return 2
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleTableViewCell") as? SimpleTableViewCell {
            if indexPath.row == 0 {
                cell.setupCell(isImageHidden: false, title: "Tap to select a city", attributedString: nil)
            } else {
                let attributedString = NSMutableAttributedString(string:"You selected: ")
                let attributes = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
                let selectedLocationName = NSMutableAttributedString(string: selectedLocation, attributes:attributes)
                
                attributedString.append(selectedLocationName)
                cell.setupCell(isImageHidden: true, title: nil, attributedString: attributedString)
            }
            
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "LocationListSegue", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}




