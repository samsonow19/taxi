//
//  Avto.swift
//  TaxiCramea
//
//  Created by админ on 28.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import Foundation
class AvtoModel {
    var idUser: String!
    var classAvtoUserTaxi: String!
    var markaUserTaxi: String!
    var colorUserTaxi: String!
    var numberUserTaxi: String!
    var passportUserTaxi: String!
    var yearUserTaxi: String!
    var countPlaceUserTaxi: String!
    var imageUserTaxi: String!
    var imageURLUserTaxi: String!
    var childChairUserTaxi: String!
    var receiptUserTaxi: String!
    var smokingUserTaxi: String!
    var boosterUserTaxi: String!
    var festUserTaxi: String!
    var conditionUserTaxi: String!
    static let shared = AvtoModel()
  
    init(){
        
    }
    
    init(data : NSDictionary){
        self.idUser = data["id"] as! String
        self.classAvtoUserTaxi = data["class"] as! String
        self.markaUserTaxi = data["marka"] as! String
        self.colorUserTaxi = data["color"] as! String
        self.numberUserTaxi = data["number"] as! String
        self.passportUserTaxi = data["passport"] as! String
        self.yearUserTaxi = data["year"] as! String

        self.countPlaceUserTaxi = data["seats"] as! String
      //  self.imageUserTaxi = data["image"] as! String
        self.imageURLUserTaxi = data["image"] as! String
        self.childChairUserTaxi = data["babychair"] as! String
        self.receiptUserTaxi = data["receipts"] as! String
        self.smokingUserTaxi = data["smoking"] as! String
        self.boosterUserTaxi = data["booster"] as! String
        self.festUserTaxi = data["fest"] as! String
        self.conditionUserTaxi = data["conditioning"] as! String
        
    }
    
    func saveClassAvto() {
        let userDateDafaults  = UserDefaults.standard
        var userDate = [String]()
        userDate.append(classAvtoUserTaxi!)
        userDateDafaults.set(userDate, forKey: "AvtoClass")
        userDateDafaults.synchronize()
        
    }
    
    
    func getClassAvto() -> Bool {
        var userDate = [NSString]()
        let userDateDafaults  = UserDefaults.standard
        let  getValue = userDateDafaults.object(forKey: "AvtoClass")
        if getValue == nil {
            return false
        }
        userDate = getValue as! [NSString]
        self.classAvtoUserTaxi = userDate[0] as String
        return true
  
        
    }
    


}






