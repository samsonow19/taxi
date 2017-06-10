//
//  BuyViewController.swift
//  TaxiCramea
//
//  Created by админ on 08.06.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController {
    @IBOutlet weak var whereTextFild: UITextField!
    @IBOutlet weak var wenceTextFild: UITextField!
    @IBOutlet weak var dateTextFild: UITextField!
    @IBOutlet weak var timeTextFild1: UITextField!
    @IBOutlet weak var timeTextFild2: UITextField!
    
    let datePiker = UIDatePicker()
    let timePiker1 = UIDatePicker()
    let timePiker2 = UIDatePicker()
    
    var regionArray: [String] = ["Алушта большая", "Бахчисарай и районы", "Евпатория и районы" ,"Керчь и районы" ,"Красноперекопск и районы" ,"Николаевка и районы", "Севастополь и районы" , "Аэропорт Симферополя" , "Судак и районы", "Феодосия и районы", "Бахчисарай и районы", "Ялта большая"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePiker.datePickerMode = .date
        timePiker1.datePickerMode = .time
        timePiker2.datePickerMode = .time
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePressed) )
        toolbar.setItems([doneButton], animated: false)
        dateTextFild.inputAccessoryView = toolbar
        dateTextFild.inputView = datePiker
        
        
        let toolbarTime1 = UIToolbar()
        toolbarTime1.sizeToFit()
        let doneButtonTime1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTime1Pressed) )
        toolbarTime1.setItems([doneButtonTime1], animated: false)
        timeTextFild1.inputAccessoryView = toolbarTime1
        timeTextFild1.inputView = timePiker1
        
        
        let toolbarTime2 = UIToolbar()
        toolbarTime2.sizeToFit()
        let doneButtonTime2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTime2Pressed) )
        toolbarTime2.setItems([doneButtonTime2], animated: false)
        timeTextFild2.inputAccessoryView = toolbarTime2
        timeTextFild2.inputView = timePiker2
        
    }
    func doneDatePressed() {
        dateTextFild.text = "\(datePiker.date)"
        self.view.endEditing(true)
    }
    
    func doneTime1Pressed() {
        timeTextFild1.text = "\(timePiker1.date)"
        self.view.endEditing(true)
    }
    func doneTime2Pressed() {
        timeTextFild2.text = "\(timePiker2.date)"
        self.view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func savefindOrder(_ sender: Any) {
        
        let user: UserModel = UserModel.shared
        let url = BASEURL + "buy.php"
        let parameters: Parameters = [
            "code": CODE ,
            "token":  user.tokenUserTaxi ,
            "id_user":  user.idUser ,
            "destination": "1",
            "whence": "1",
            "data": "1",
            "data_to": "1",
            ]
        Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
            var data = self.convertToDictionary(text: respons.result.value)
            let test =  data?["error"] as? NSDictionary
            if test != nil {
                
            } else {
                
            }

        }
        
        
    }
    
    
    
    


}
