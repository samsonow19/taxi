//
//  Order.swift
//  TaxiCramea
//
//  Created by Alexey Sinitsa on 31.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import Foundation

class OrderModel {
    var id: String!
    var time: String!
    var whence: String!
    var whereOrder: String!
    var cost: String!
    var commision: String!
    var info: String!
    var contact: String!
    
    
    var name: String!
    var number: String!
    var flight: String!
    var comment: String!
    var beforeDate: String!
    
    var classAvto: String!
    var your: String!
    var region1: String!
    var region2: String!
    var countTransfer: String!
   
    
   
    init(){
        
    }
    
    
    func loadShotOrder(data : NSDictionary) {
        self.id = getStrJSON(data: data, key: "id")
        self.time = getStrJSON(data: data, key: "traffic_date")
        self.whence = getStrJSON(data: data, key: "whence")
        self.whereOrder = getStrJSON(data: data, key: "destination")
        self.cost = getStrJSON(data: data, key: "price")
        self.region1 = getStrJSON(data: data, key: "region1")
    }
    
    
    func loadLongOrder(data : NSDictionary) { ///write
        self.id = getStrJSON(data: data, key: "id")
        self.time = getStrJSON(data: data, key: "traffic_date")
        self.whence = getStrJSON(data: data, key: "whence")
        self.whereOrder = getStrJSON(data: data, key: "destination")
        
        
        self.number = getStrJSON(data: data, key: "token")
        self.flight = getStrJSON(data: data, key: "score")
        self.comment = getStrJSON(data: data, key: "rayting")
        
        self.beforeDate = getStrJSON(data: data, key: "token")
        self.classAvto = getStrJSON(data: data, key: "score")
        self.your = getStrJSON(data: data, key: "rayting")
        self.region1 = getStrJSON(data: data, key: "token")
        self.region2 = getStrJSON(data: data, key: "score")
        self.countTransfer = getStrJSON(data: data, key: "rayting")
        

        
    }
    
    func getStrJSON(data: NSDictionary, key: String) -> String{
        //let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
}
