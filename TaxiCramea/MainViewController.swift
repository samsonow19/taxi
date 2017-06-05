//
//  MainViewController.swift
//  TaxiCramea
//
//  Created by админ on 28.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hightMenuButton: NSLayoutConstraint!

    @IBOutlet weak var reytLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nikLabel: UILabel!
    @IBOutlet weak var testView: UIView!
    
    var classAvto: Bool!
    var orderArray = [OrderModel]()
    
    @IBAction func regionButton(_ sender: UIButton) {
        testView.isHidden = true
        
        
        switch sender.tag {

        case 1:
            var user: UserModel = UserModel.shared
        case 2:
            var user: UserModel = UserModel.shared
        case 3:
            var user: UserModel = UserModel.shared
        case 4:
            var user: UserModel = UserModel.shared
        case 5:
            var user: UserModel = UserModel.shared
        case 6:
            var user: UserModel = UserModel.shared
        case 7:
            var user: UserModel = UserModel.shared
        case 8:
            var user: UserModel = UserModel.shared
        case 9:
            var user: UserModel = UserModel.shared
        case 10:
            var user: UserModel = UserModel.shared
        case 11:
            var user: UserModel = UserModel.shared
        case 12:
            var user: UserModel = UserModel.shared
        default:
            var user: UserModel = UserModel.shared
        }
   
        
    }
    @IBAction func beack(_ sender: UIButton) {

        testView.isHidden = false
    }
    @IBAction func optionsClick(_ sender: Any) {
    }
 
    @IBAction func buyClick(_ sender: Any) {
        
    }
    @IBAction func soundClick(_ sender: Any) {
        
    }
    
    @IBAction func exitClick(_ sender: Any) {
        
    }

    @IBAction func allOrder(_ sender: Any) {
        
    }
    
    @IBAction func myOrderClick(_ sender: Any) {
        
    }


  
    @IBAction func lookFor(_ sender: Any) {
        
    }
    

    @IBAction func findClick(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true;
        
        let user: UserModel = UserModel.shared
        reytLabel.text = user.rayting
        scoreLabel.text = user.score
        nikLabel.text = user.nameUserTaxi
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let userNib = UINib(nibName: "MainTableViewCell", bundle: nil)
        self.tableView.register(userNib, forCellReuseIdentifier: "MainTableViewCell")

        
        
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
     
        
    }
    
    
    func update() {

        let user: UserModel = UserModel.shared
        let avto: AvtoModel = AvtoModel.shared
        let url = BASEURL + "transfer.php"
        let parameters: Parameters = [
            "code": CODE ,
            "token":  user.tokenUserTaxi ?? "",
            "id_user":  user.idUser ?? "",
            "classAuto": "1",
            ]
        Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
            
            var data = self.convertToDictionary(text: respons.result.value)
      
            let transfers =  data?["transfer"] as? NSDictionary
                if transfers != nil {
                    var orderItem: OrderModel
                    for (_, value) in transfers! {
                        print(value)
                        orderItem = OrderModel()
                        orderItem.loadShotOrder(data: value as! NSDictionary)
                        self.orderArray.append(orderItem)
          
                    }
                    print(self.orderArray[0].region1)
                    self.tableView.reloadData()
                } else {
            
                }
         
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)  as! MainTableViewCell

         print(indexPath.row)
         var orderItem: OrderModel = OrderModel()
         orderItem = orderArray[indexPath.row]
         print(orderArray[indexPath.row].id)
         print(orderItem.id)
         cell.whereLabel.text = orderItem.whereOrder
         cell.whenceLabel.text = orderItem.whence
         cell.dateLabel.text = orderItem.time
         cell.costLabel.text = orderItem.cost
        
         return cell
        
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
 

}
