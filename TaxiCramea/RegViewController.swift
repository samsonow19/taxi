//
//  RegViewController.swift
//  TaxiCramea
//
//  Created by админ on 03.06.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit
import Alamofire
import PhoneNumberKit
import InputMask

class RegViewController: UIViewController,MaskedTextFieldDelegateListener {
    @IBOutlet weak var numBerTextFild: UITextField!
    @IBOutlet weak var patText: UITextField!
    @IBOutlet weak var firstNmaeText: UITextField!
    @IBOutlet weak var secondNameText: UITextField!
    @IBOutlet weak var techPasportText: UITextField!
    @IBOutlet weak var sityText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pas2Text: UITextField!
    @IBOutlet weak var pass1Text: UITextField!
    
    var maskedDelegate: MaskedTextFieldDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        maskedDelegate = MaskedTextFieldDelegate(format: "{7} ([000]) [000]-[00]-[00]")
        maskedDelegate.listener = self
        numBerTextFild.delegate = maskedDelegate
        maskedDelegate.put(text: "7 ", into: numBerTextFild)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    @IBAction func regClick(_ sender: Any) {
        

        
        let url = BASEURL + "registry.php"
        let parameters: Parameters = [
            "code": CODE,
            "password":  pass1Text.text ?? "",
            "password1": pas2Text.text ?? "",
            "phone": UITextField.text ?? "",
            "patronymic": patText.text ?? "",
            "surname": secondNameText.text ?? "",
            "name": firstNmaeText.text ?? "",
            "driver_licence": techPasportText.text ?? "",
            "sity": sityText.text ?? "",
            "email": emailText.text ?? "",
            ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
            print(respons.result.value)
            let user: UserModel = UserModel.shared
            user.load(data: self.convertToDictionary(text: respons.result.value)! as NSDictionary)
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
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
    


}
