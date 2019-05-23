//
//  LocationTableViewCell.swift
//  LocationFinder
//
//  Created by Joshua Relova on 23/05/2019.
//  Copyright © 2019 Joshua Relova. All rights reserved.
//

import UIKit
import Nuke

class LocationTableViewCell: UITableViewCell {

    @IBOutlet var locationImageview: UIImageView!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var prefixName: UILabel!
    @IBOutlet var separatorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorView.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func hideSepratorView() {
        self.separatorView.isHidden = true
    }
    
    func populateLocationCell(location: LocationObject) {
        self.locationImageview.image = UIImage(named: "placeholder")
        self.mainTitle.text = location.name
        self.prefixName.text = ""
        
        if let subText = location.subtitle {
            self.subTitle.text = subText
        }
        
        if let urlString = location.banner, let url = URL(string: urlString) {
            Manager.shared.loadImage(with: url, into: self.locationImageview)
        } else if let color = location.color {
            self.locationImageview.image = nil
            self.locationImageview.backgroundColor = UIColor.hexStringToUIColor(hex: color)
            self.prefixName.text = location.tempName
        }
    }
    
}
