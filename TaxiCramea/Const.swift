//
//  Const.swift
//  TaxiCramea
//
//  Created by админ on 27.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import Foundation


public var BASEURL = "http://app.taxi-sipaero.ru/api/"
public var CODE = "94234578754542615479" 

var regionArray: [String] = ["Алушта большая", "Бахчисарай и районы", "Евпатория и районы" ,"Керчь и районы" ,"Красноперекопск и районы" ,"Николаевка и районы", "Севастополь и районы" , "Аэропорт Симферополя" , "Судак и районы", "Феодосия и районы", "Бахчисарай и районы", "Ялта большая"]

enum CurrentDay {
    case toDay
    case tomorrow
    case afterTomorrow
}

func getStrJSON(data: NSDictionary, key: String) -> String{
    //let info : AnyObject? = data[key]
    if let info = data[key] as? String{
        return info
    }
    return ""
    
}



enum CurrentOptions {
    case allOrder
    case myOrder
    case iLookFor
    case iFind
}
func convertToDictionary(text: String?) -> [String: Any]? {
    if let data = text?.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
