//
//  DataResponseExtension.swift
//  LocationFinder
//
//  Created by Joshua Relova on 23/05/2019.
//  Copyright © 2019 Joshua Relova. All rights reserved.
//

import UIKit
import Alamofire

extension DataResponse{

    func getJson() -> [String:Any]? {
        var json:[String:Any]?
        if let value = result.value as? [String:Any] {
            json = value
        } else if let value = result.value as? Array<Any>, value.count > 0 , let obj = value[0] as? [String:Any] {
            json = obj
        }
        
        return json
    }
    
    
    func getData() -> Any? {
        if let json = getJson() {
            if let data = json["data"] as? [String:Any] {
                return data
            } else if let data = json["data"] as? Array<Any> {
                return data
            }
        }
        return nil
    }
    
    func getMessage() -> String {
        if let json = getJson() {
            if let message = json["message"] as? String {
                return message
            } else {
                return ""
            }
        }
        return ""
    }
    
}
