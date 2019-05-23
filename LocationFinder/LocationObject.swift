//
//  LocationObject.swift
//  LocationFinder
//
//  Created by Joshua Relova on 23/05/2019.
//  Copyright © 2019 Joshua Relova. All rights reserved.
//

import UIKit

class LocationObject: NSObject {
    var name: String!
    var subtitle: String?
    var banner: String?
    var color: String?
    var tempName: String!
    
    class func fromJson(json:[String:Any]) -> LocationObject? {
        if let name = json["name"] as? String {
            let location = LocationObject()
            location.name = name
            location.tempName = String(name.prefix(3))
            
            if let subtitle = json["subtitle"] as? String {
                location.subtitle = subtitle
            }
            
            if let banner = json["banner"] as? String {
                location.banner = banner
            }
            
            if let color = json["color"] as? String {
                location.color = color
            }
           
            return location
        }
        return nil
    }
}
