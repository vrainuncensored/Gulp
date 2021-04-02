//
//  OrderConfirmation.swift
//  gulpMerchant
//
//  Created by vrain ahuja on 1/21/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class OrderConfirmation: UIViewController {
    //Button Outlets
    @IBOutlet weak var confirmationButton: UIButton!
    
    //Label Outlets
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var itemsOrderedLabel: UILabel!
    @IBOutlet weak var additionalCommentsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    //Views Outlets
    
    
    
    //Order
    var orderInformation: Order?
    
    var items = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfirmationButton()
        //setupRejectButton()
        //setupOrderNumberLabel()
        settupLabels()
        // Do any additional setup after loading the view.
        var time : Timestamp = orderInformation!.timestamp
       // print(time.seconds)
        //self.navigationItem.title = "Order: " + orderInformation!.orderNumber
        self.navigationItem.title = "some title"

//        let timeOfOrder = UIBarButtonItem(title: orderInformation!.status, style: .plain, target: self, action: #selector(doNothing))
//        navigationItem.rightBarButtonItem = timeOfOrder
        gettingItems()

    }
    @objc func orderCompletedAction() {
        cloudFunctions.orderCompletedDatabase(orderTicket: orderInformation!)
        cloudFunctions.orderAcceptedNotification()
        cloudFunctions.removeCompletedOrder(orderTicket: orderInformation!)
        //self.presentedViewController!.dismiss(animated: true, completion: nil)
    }
//    func setupOrderNumberLabel() {
//        orderNumberLabel.text = "Order Number  " + String(565)
//    }
    func setupConfirmationButton() {
        confirmationButton.setTitle("Accept", for: .normal)
        confirmationButton.showsTouchWhenHighlighted = true
        confirmationButton.layer.cornerRadius = 5
        confirmationButton.layer.borderWidth = 1
        confirmationButton.layer.borderColor = CG_Colors.red
        confirmationButton.backgroundColor = UI_Colors.red
        confirmationButton.addTarget(self, action: #selector(orderCompletedAction), for: .touchUpInside)
        confirmationButton.setTitleColor(.white, for: .normal)
    }
//    func setupRejectButton() {
//        rejectButton.setTitle("Reject", for: .normal)
//        rejectButton.showsTouchWhenHighlighted = true
//        rejectButton.layer.cornerRadius = 5
//        rejectButton.layer.borderWidth = 1
//        rejectButton.layer.borderColor = CG_Colors.darkPurple
//        rejectButton.backgroundColor = UI_Colors.darkPurple
//        rejectButton.addTarget(self, action: #selector(orderCompletedAction), for: .touchUpInside)
//        rejectButton.setTitleColor(.white, for: .normal)
//    }
    func settupLabels() {
        orderNumberLabel.text = "Order Number:  " +  orderInformation!.orderNumber
//        itemsOrderedLabel.text = orderInformation?.items
        if ((orderInformation?.additionalRequests?.isEmpty) == nil){
            additionalCommentsLabel.text =  "Special Instructions: None"
        } else {
        additionalCommentsLabel.text =  "Special Instructions: " + orderInformation!.additionalRequests!
        }
        
        nameLabel.text = "Customer Name: " + orderInformation!.customerId
//        timestampLabel.text = orderInformation?.timestamp.
//
    }
    func gettingItems() {
        var itemsText = ""
        for item in orderInformation!.items{
            itemsText = itemsText + item + ","
        }
        itemsOrderedLabel.text = "Items ordered: " + itemsText
    }
    @objc func doNothing() {
        print("yay")
    }
    
    func convertTimestamp(serverTimestamp: Double) -> String {
            let x = serverTimestamp / 1000
            let date = NSDate(timeIntervalSince1970: x)
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium

            return formatter.string(from: date as Date)
        }
    func getReadableDate(timeStamp: TimeInterval) -> String? {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
    }
    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    func secondsToHoursMinutesSeconds (seconds : Int64) -> (Int, Int, Int) {
      return (Int (seconds / 3600), Int (seconds % 3600) / 60, Int ((seconds % 3600) % 60))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
