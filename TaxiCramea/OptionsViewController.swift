//
//  OptionsViewController.swift
//  TaxiCramea
//
//  Created by админ on 08.06.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit
import Alamofire


class OptionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var yearPicker: UITextField!
    @IBOutlet weak var colorTextFild: UITextField!

    @IBOutlet weak var curImage: UIImageView!
    @IBOutlet weak var numberCurTextFild: UITextField!
    @IBOutlet weak var texhPasportTextfild: UITextField!
    @IBOutlet weak var marcaCurTextFild: UITextField!
    @IBOutlet weak var countPlaceTextFild: UITextField!
    @IBOutlet weak var boolReceipt: UISwitch!
    @IBOutlet weak var boolChair: UISwitch!
    @IBOutlet weak var boolSmoking: UISwitch!
    @IBOutlet weak var boolCondishon: UISwitch!
    @IBOutlet weak var boolBooster: UISwitch!
    @IBOutlet weak var boolFest: UISwitch!
    @IBAction func checkPhoto(_ sender: Any) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let theInfo:NSDictionary = info as NSDictionary
        
        let img:UIImage = theInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        curImage.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        
        let user: UserModel = UserModel.shared
        let avto: AvtoModel = AvtoModel.shared
        let url = BASEURL + "marka.php"
        let jpegCompressionQuality: CGFloat = 0.9
        let base64String = UIImageJPEGRepresentation(curImage.image! , jpegCompressionQuality)?.base64EncodedString()
        let nameImage = "carImage.jpeg";
   
        let parameters: Parameters = [
            "code": CODE ,
            "token":  user.tokenUserTaxi ,
            "id_user":  user.idUser ,
            "classAuto": "1",
            "mark": marcaCurTextFild.text ,
            "color": colorTextFild.text ,
            "licenceNumber": texhPasportTextfild.text ,
            "carNumber": numberCurTextFild.text ,
            "receipts": "1",
            "smoking": "1",
            "fest": "1",
            "booster": "1",
            "seats": countPlaceTextFild.text ,
            "babychair": "1",
            "year": yearPicker.text ,
            "conditioning": "1",
            "ImageName": nameImage ,
            "image": base64String ,
            ]
        Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
            var data = convertToDictionary(text: respons.result.value)
            let transfers =  data?["class"] as? NSDictionary
            if transfers != nil {
                Toast.init(text: "Данные сохранены").show()
                
            } else {
                Toast.init(text: "Не удалось сохранить данные").show()
            }
            
        }
        
    }
    
    /*
     "receipts": boolReceipt.isOn ? "0":"1",
     "smoking": boolSmoking.isOn ? "0":"1",
     "fest": boolFest.isOn ? "0":"1",
     "booster": boolBooster.isOn ? "0":"1",
     "seats": countPlaceTextFild.text ?? "",
     "babychair": boolChair.isOn ? "0":"1",
     "year": yearPicker.text ,
     "conditioning": boolCondishon.isOn ? "0":"1",
 */
    
    func getOptions() {
        
        let user: UserModel = UserModel.shared
        let avto: AvtoModel = AvtoModel.shared
        let url = BASEURL + "get_car.php"
        let parameters: Parameters = [
            "code": CODE ,
            "token":  user.tokenUserTaxi ,
            "id_user":  user.idUser ,
           ]
        Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
            var data = convertToDictionary(text: respons.result.value)
            let transfers =  data?["class"] as? NSDictionary
            if transfers != nil {
                self.marcaCurTextFild.text =  transfers?["mark"] as? String
                self.colorTextFild.text = transfers?["color"] as? String
                self.texhPasportTextfild.text = transfers?["licenceNumber"] as? String
                self.numberCurTextFild.text = transfers?["carNumber"] as? String
                self.countPlaceTextFild.text = transfers?["seats"] as? String
                self.yearPicker.text = transfers?["year"] as? String
                
                if transfers?["receipts"] as! String == "1" {
                    self.boolReceipt.isOn = true
                } else {
                    self.boolReceipt.isOn = false
                }
                
                if transfers?["smoking"] as! String == "1" {
                    self.boolSmoking.isOn = true
                } else {
                    self.boolSmoking.isOn = false
                }
                
                if transfers?["fest"] as! String == "1" {
                    self.boolFest.isOn = true
                } else {
                    self.boolFest.isOn = false
                }
                
                if transfers?["booster"] as! String == "1" {
                    self.boolBooster.isOn = true
                } else {
                    self.boolBooster.isOn = false
                }
                
                if transfers?["babychair"] as! String == "1" {
                    self.boolChair.isOn = true
                } else {
                    self.boolChair.isOn = false
                }
                
                if transfers?["conditioning"] as! String == "1" {
                    self.boolCondishon.isOn = true
                } else {
                    self.boolCondishon.isOn = false
                }
                
                avto.classAvtoUserTaxi = transfers?["class"] as! String 
                
                //Toast.init(text: "Данные загружены").show()
                
            } else {
                //Toast.init(text: "Не удалось взять данные").show()
            }
            
        }
        
        
    }
    
    var yearValue = [String]()
    var pickerYear = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 1990...2017 {
            yearValue.append(String(index))
        }

        pickerYear.delegate = self
        pickerYear.dataSource = self
        yearPicker.delegate = self
        yearPicker.inputView = self.pickerYear
        getOptions()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
 
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearValue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearValue[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearPicker.text = yearValue[row]
        
    }

    


}
