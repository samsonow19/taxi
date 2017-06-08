//
//  ViewController.swift
//  TaxiCramea
//
//  Created by админ on 18.02.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit
import Alamofire
import PhoneNumberKit
import InputMask



class ViewController: UIViewController ,MaskedTextFieldDelegateListener {
 
    @IBOutlet weak var LoginTextView: UITextField!
    @IBOutlet weak var PassTextFild: UITextField!
    
    var maskedDelegate: MaskedTextFieldDelegate!

    @IBAction func EnterInTaxi(_ sender: Any) {
        
    
        let name = LoginTextView.text?.replacingOccurrences(of: " ", with: "")
        let pass = PassTextFild.text
        let url = BASEURL + "authorization.php"
        let parameters: Parameters = [
            "name":   name ,
            "password":  pass ,
            "code": CODE,
            ]
        Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
        
            let user: UserModel = UserModel.shared
            user.load(data: self.convertToDictionary(text: respons.result.value)! as NSDictionary)
            user.saveUserModel()
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            secondViewController.classAvto = false
            self.navigationController?.pushViewController(secondViewController, animated: true)
          
        }
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


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user: UserModel = UserModel.shared
        if  user.getUserModel() {
            
            let avto: AvtoModel = AvtoModel.shared
          
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            if  avto.getClassAvto() {
                secondViewController.classAvto = true
            } else {
                secondViewController.classAvto = false
            }
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
       
        maskedDelegate = MaskedTextFieldDelegate(format: "{7} ([000]) [000]-[00]-[00]")
        maskedDelegate.listener = self
        LoginTextView.delegate = maskedDelegate
        maskedDelegate.put(text: "7 ", into: LoginTextView)
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
    



}

