//
//  SimpleTableViewCell.swift
//  LocationFinder
//
//  Created by Joshua Relova on 23/05/2019.
//  Copyright © 2019 Joshua Relova. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {

    @IBOutlet var locationImageView: UIImageView!
    @IBOutlet var mainText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(isImageHidden: Bool, title: String?, attributedString: NSAttributedString?) {
        locationImageView.isHidden = isImageHidden
        
        if let titleText = title {
             mainText.text = titleText
        } else if let attributedText = attributedString {
             mainText.attributedText = attributedText
        }
       
    }
    
}
