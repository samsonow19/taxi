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
    
 
    
    
    @IBOutlet var regionButtonArray: [UIButton]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hightMenuButton: NSLayoutConstraint!

    @IBOutlet weak var reytLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nikLabel: UILabel!
    @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var dateView: UIView!
    var classAvto: Bool!
    var countOrderIntoRegion = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var orderArray = [OrderModel]()
    var orderCurrentArray = [OrderModel]()
    var currentRegion: String!  = regionArray[0]
    var currentDay = CurrentDay.toDay
    var allOrderChoose : Bool = true
    var currentOptions : CurrentOptions = CurrentOptions.allOrder
    
    @IBOutlet weak var tabelConstr: NSLayoutConstraint! // 116
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

        currentOptions = .iLookFor
        let user: UserModel = UserModel.shared
        let avto: AvtoModel = AvtoModel.shared
        let url = BASEURL + "buy_main.php"
        orderCurrentArray.removeAll()
        let parameters: Parameters = [
            "code": CODE ,
            "token":  user.tokenUserTaxi ,
            "id_user":  user.idUser ,]
        Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
            var data = convertToDictionary(text: respons.result.value)
            let transfers =  data?["buy"] as? NSDictionary
            if transfers != nil {
                
                for (_, value) in transfers! {
                    print(value)
                    orderItem = OrderModel()
                    orderItem.loadBuyOrder(data: value as! NSDictionary)
                    self.orderCurrentArray.append(orderItem)
                }
                
                self.tableView.reloadData()
                
            } else {
            
            }
        }
        
    }
    
    @IBAction func soundClick(_ sender: Any) {
        
    }
    
    @IBAction func exitClick(_ sender: Any) {
        
    }

    @IBAction func allOrder(_ sender: Any) {
        allOrderChoose =  true
        testView.isHidden = false
        tabelConstr.constant = 116
        dateView.isHidden = false
        
        currentOptions = .allOrder
        
    }
    
    @IBAction func myOrderClick(_ sender: Any) {
        
        currentOptions = .myOrder
        
        let user: UserModel = UserModel.shared
        //let avto: AvtoModel = AvtoModel.shared
        let url = BASEURL + "transfer_active.php"
        orderArray.removeAll()
        let parameters: Parameters = [
            "code": CODE ,
            "token":  user.tokenUserTaxi ,
            "id_user":  user.idUser,
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
                    orderItem.loadLongOrder(data: value as! NSDictionary)
                    self.orderCurrentArray.append(orderItem)
                }
              
                self.tableView.reloadData()
              
            } else {
               // Toast.init(text: "На данный момент трансферов нет").show()
            }
            
        }

        allOrderChoose = false
        testView.isHidden = true
        tabelConstr.constant = 0
        dateView.isHidden = true
    }

    @IBAction func lookFor(_ sender: Any) {
        
    }

    @IBAction func findClick(_ sender: Any) {
        
    }
    
    
    
    
    enum CurrentDay {
        case toDay
        case tomorrow
        case afterTomorrow
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
    
    func getStrJSON(data: NSDictionary, key: String) -> String{
        //let info : AnyObject? = data[key]
        if let info = data[key] as? String{
            return info
        }
        return ""
        
    }
    
    var regionArray: [String] = ["Алушта большая", "Бахчисарай и районы", "Евпатория и районы" ,"Керчь и районы" ,"Красноперекопск и районы" ,"Николаевка и районы", "Севастополь и районы" , "Аэропорт Симферополя" , "Судак и районы", "Феодосия и районы", "Бахчисарай и районы", "Ялта большая"]
    
    
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
        
        let fullOrderNib = UINib(nibName: "LongTableViewCell", bundle: nil)
        self.tableView.register(fullOrderNib, forCellReuseIdentifier: "LongTableViewCell")
        
        
        let findOrderNib = UINib(nibName: "BuyTableViewCell", bundle: nil)
        self.tableView.register(findOrderNib, forCellReuseIdentifier: "BuyTableViewCell")
        
        
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
    }
    
    func textForRegionButton() {
        var test : String!
        var textButtonRegion : String!
        for button in regionButtonArray {
            test = String(describing: countOrderIntoRegion[button.tag-1])
            textButtonRegion = regionArray[button.tag-1] + "\n " + test
            button.setTitle(textButtonRegion, for: .normal)
            button.titleLabel?.textAlignment = NSTextAlignment.center
        }
    }
    
    func getCurrentOrderByRegion() {
        countOrderIntoRegion = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        orderCurrentArray.removeAll()
        var index = 0
        var dateString : String!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"

        for order in orderArray {
            if order.region1 == currentRegion {

                dateString = order.time
           
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
        let dayOrder = calendar.component(.day, from: dateOrder)
        switch currentDay {
        case .toDay:
            let toDayCalendar = calendar.component(.day, from: date)
            if toDayCalendar == dayOrder {
                return true
            } else {
                return false
            }
        case .tomorrow:
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)
            let toDayCalendar = calendar.component(.day, from: tomorrow!)
            if toDayCalendar == dayOrder {
                return true
            } else {
                return false
            }
        case .afterTomorrow:
            
            let tomorrow = Calendar.current.date(byAdding: .day, value: 2, to: date)
            let toDayCalendar = calendar.component(.day, from: tomorrow!)
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
            "token":  user.tokenUserTaxi ,
            "id_user":  user.idUser ,
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
                    if self.allOrderChoose { // if
                        self.getCurrentOrderByRegion()
                    }
                } else {
                  //  Toast.init(text: "На данный момент трансферов нет").show()
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
        
        if currentOptions == .allOrder {    
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)  as! MainTableViewCell
            var orderItem: OrderModel = OrderModel()
            orderItem = orderCurrentArray[indexPath.row]
            cell.whereLabel.text = orderItem.whence
            cell.whenceLabel.text = orderItem.whereOrder
            cell.dateLabel.text = orderItem.time
            cell.costLabel.text = orderItem.cost
        
         return cell
        }
        if currentOptions == .myOrder {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LongTableViewCell", for: indexPath)  as! LongTableViewCell
        
            var orderItem: OrderModel = OrderModel()
            orderItem = orderCurrentArray[indexPath.row]
            cell.whereLabel.text = orderItem.whence
            cell.whenceLabel.text = orderItem.whereOrder
            cell.dateLabel.text = orderItem.time
            cell.costLabel.text = orderItem.cost
            cell.commentLabel.text = orderItem.comment
            cell.plainLabel.text = orderItem.flight
            cell.numberLabel.text = orderItem.number
            cell.nameLabel.text = orderItem.name
            cell.contactLabel.text = orderItem.contact
            cell.infoLabel.text = orderItem.info
            cell.yourLabel.text = orderItem.your
            
            cell.buttonInfo.addTarget(self, action: #selector(self.displayToolTipDetails(_:)), for: .touchUpInside)
            
            return cell
        }
        
        
        if currentOptions == .iLookFor {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BuyTableViewCell", for: indexPath)  as! BuyTableViewCell
            
            var orderItem: OrderModel = OrderModel()
            orderItem = orderCurrentArray[indexPath.row]
            cell.whereTextFild.text = orderItem.region1
            cell.whenceTextFild.text = orderItem.region2
            cell.dateTextFild.text = orderItem.time
        
 
            return cell
        }
        
        
        
        
        return tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)  as! MainTableViewCell
 
    }

    
    func displayToolTipDetails(_ sender : UIButton) {
   
    
        UIView.setAnimationsEnabled(false)
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = "Взять заказ"
        let alertOrder = UIAlertController(title: "Взять", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertOrder.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            let user: UserModel = UserModel.shared
            //let avto: AvtoModel = AvtoModel.shared
            let url = BASEURL + "transfer_buy.php"
            let parameters: Parameters = [
                "code": CODE ,
                "token":  user.tokenUserTaxi ,
                "id_user":  user.idUser ,
                "id_zakaz":  self.orderCurrentArray[indexPath.row].id ,
                "classAuto": "1",
                ]
            var indexOrder = 0
            for oreder in self.orderArray {
                if oreder.id == self.orderCurrentArray[indexPath.row].id {
                    self.orderArray.remove(at: indexOrder)
                }
                indexOrder += 1
            }
            self.orderCurrentArray.remove(at: indexPath.row)
      
            Alamofire.request(url, method: .post, parameters: parameters).responseString{ respons in
                var data = self.convertToDictionary(text: respons.result.value)
                let transfers =  data?["success"] as? NSDictionary
                if transfers != nil {
                   Toast.init(text: "Трансфер перемещен в текущие заказы").show()
                } else {
                    Toast.init(text: "Скорее всего ваш трансфер забрали").show()
                }
                self.tableView.reloadData()
            }
            
        }))
        
        alertOrder.addAction(UIAlertAction(title: "Не беру", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertOrder, animated: true, completion: nil)
        
    }
    
    

    

}
