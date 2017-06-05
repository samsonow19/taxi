//
//  User.swift
//  TaxiCramea
//
//  Created by админ on 28.05.17.
//  Copyright © 2017 админ. All rights reserved.
//




import Foundation
    
    class UserModel {
        var idUser: String!
        var nameUserTaxi: String!
        var surnameUserTaxi: String!
        var patronymicUserTaxi: String!
        var tokenUserTaxi: String!
        var sityUserTaxi: String!
        var score: String!
        var rayting: String!
        var certificateUserTaxi: String!
        static let shared = UserModel()
      
        init(){
            
        }
        
  
        func load(data : NSDictionary) {
            self.idUser = data["id"] as! String
            self.nameUserTaxi = getStrJSON(data: data, key: "name")
            self.surnameUserTaxi = getStrJSON(data: data, key: "surname")
            self.sityUserTaxi = getStrJSON(data: data, key: "city")
            self.certificateUserTaxi = getStrJSON(data: data, key: "certificate")
            self.patronymicUserTaxi = getStrJSON(data: data, key: "patronymic")
            self.tokenUserTaxi = getStrJSON(data: data, key: "token")
            self.score = getStrJSON(data: data, key: "score")
            self.rayting = getStrJSON(data: data, key: "rayting")
        }
        
        func getStrJSON(data: NSDictionary, key: String) -> String{
            //let info : AnyObject? = data[key]
            if let info = data[key] as? String{
                return info
            }
            return ""
            
        }
        
        func saveUserModel() {
            let userDateDafaults  = UserDefaults.standard
            var userDate = [String]()
            userDate.append(idUser!)
            userDate.append(nameUserTaxi!)
            userDate.append(surnameUserTaxi!)
            userDate.append(patronymicUserTaxi!)
            userDate.append(tokenUserTaxi!)
            userDate.append(sityUserTaxi!)
            userDate.append(score!)
            userDate.append(rayting!)
            userDate.append(certificateUserTaxi!)
            userDateDafaults.set(userDate, forKey: "UserList")
            userDateDafaults.synchronize()
            
        }
        
        
        func getUserModel() -> Bool {
            var userDate = [NSString]()
            let userDateDafaults  = UserDefaults.standard
            let  getValue = userDateDafaults.object(forKey: "UserList")
            if getValue == nil{
                return false
            }
            
            userDate = getValue as! [NSString]
            self.idUser = userDate[0] as String
            self.nameUserTaxi = userDate[1] as String
            self.surnameUserTaxi = userDate[2] as String
            self.patronymicUserTaxi = userDate[3] as String
            self.tokenUserTaxi = userDate[4] as String
            self.sityUserTaxi = userDate[5] as String
            self.score = userDate[6] as String
            self.rayting = userDate[7] as String
            return true
        }
        
        
}





