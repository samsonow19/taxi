//
//  MainViewController.swift
//  TaxiCramea
//
//  Created by админ on 28.05.17.
//  Copyright © 2017 админ. All rights reserved.
//

import UIKit
import Alamofire
import Toaster



class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var regionButtonArray: [UIButton]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hightMenuButton: NSLayoutConstraint!

    @IBOutlet weak var reytLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nikLabel: UILabel!
    @IBOutlet weak var testView: UIView!
    
    var classAvto: Bool!
    var countOrderIntoRegion = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var orderArray = [OrderModel]()
    var orderCurrentArray = [OrderModel]()
    var currentRegion: String!  = regionArray[0]
    var currentDay = CurrentDay.toDay
    
    @IBAction func regionButton(_ sender: UIButton) {
        testView.isHidden = true
         currentRegion = regionArray[sender.tag-1]
         currentDay = CurrentDay.toDay
         getCurrentOrderByRegion()
   
    }
   // checkDay (Filter)
    @IBAction func toDayClick(_ sender: Any) {
        currentDay = CurrentDay.toDay
        getCurrentOrderByRegion()
    }
    @IBAction func tomorrowClick(_ sender: Any) {
        currentDay = CurrentDay.tomorrow
         getCurrentOrderByRegion()
    }
    @IBAction func afterTomorrowClick(_ sender: Any) {
        currentDay = CurrentDay.afterTomorrow
         getCurrentOrderByRegion()
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
        textForRegionButton() // set text (region and count order) into button
        let userNib = UINib(nibName: "MainTableViewCell", bundle: nil)
        self.tableView.register(userNib, forCellReuseIdentifier: "MainTableViewCell")
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
    }
    
    func textForRegionButton() {
        for button in regionButtonArray {
            var test = String(describing: countOrderIntoRegion[button.tag-1])
            var textButtonRegion = regionArray[button.tag-1] + "\n " + test
            button.setTitle(textButtonRegion, for: .normal)
            button.titleLabel?.textAlignment = NSTextAlignment.center
        }
    }
    
    func getCurrentOrderByRegion() {
        countOrderIntoRegion = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        orderCurrentArray.removeAll()
        var index = 0
        for order in orderArray {
            if order.region1 == currentRegion {

                var dateString = order.time
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
                var date = dateFormatter.date(from: dateString!)
                if checkDay(dateOrder: date!) {
                    orderCurrentArray.append(order)
                }
            }
            index = 0
            for region in regionArray {
                if region == order.region1 {
                    countOrderIntoRegion[index] += 1
                }
                index += 1
            }

        }
        textForRegionButton()
        self.tableView.reloadData()
    }

    
    func checkDay(dateOrder : Date )-> Bool {
        let date = Date()
        let calendar = Calendar.current
        var dayOrder = calendar.component(.day, from: dateOrder)
        switch currentDay {
        case .toDay:
            var toDayCalendar = calendar.component(.day, from: date)
            if toDayCalendar == dayOrder {
                return true
            } else {
                return false
            }
        case .tomorrow:
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)
            var toDayCalendar = calendar.component(.day, from: tomorrow!)
            if toDayCalendar == dayOrder {
                return true
            } else {
                return false
            }
        case .afterTomorrow:
            
            let tomorrow = Calendar.current.date(byAdding: .day, value: 2, to: date)
            var toDayCalendar = calendar.component(.day, from: tomorrow!)
            if toDayCalendar == dayOrder {
                return true
            } else {
                return false
            }
        }
        
        
        return true
    }
    
    func update() {
        
        let user: UserModel = UserModel.shared
        let avto: AvtoModel = AvtoModel.shared
        let url = BASEURL + "transfer.php"
        orderArray.removeAll()
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
                    self.getCurrentOrderByRegion()
                } else {
                    Toast.init(text: "На данный момент трансферов нет").show()
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
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderCurrentArray.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)  as! MainTableViewCell

         print(indexPath.row)
         var orderItem: OrderModel = OrderModel()
         orderItem = orderCurrentArray[indexPath.row]
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
