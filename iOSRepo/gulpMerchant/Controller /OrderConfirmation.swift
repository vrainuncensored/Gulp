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
    @IBOutlet weak var rejectButton: UIButton!
    //Label Outlets
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var itemsOrderedLabel: UILabel!
    @IBOutlet weak var additionalCommentsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    //Views Outlets
    
    //Table Outlets
    @IBOutlet weak var orderTableView: UITableView!
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
        gettingItems()
        orderTableView.dataSource = self
        orderTableView.delegate = self
        orderTableView.register(UINib(nibName: "OrderBreakdownTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderBreakdownTableViewCell")
        if orderInformation!.status == "unaccepted" {
        setupRejectButton()
        }
    }
    @objc func orderCompletedAction() {
        cloudFunctions.orderCompletedDatabase(orderTicket: orderInformation!)
        cloudFunctions.orderAcceptedNotification()
        cloudFunctions.removeCompletedOrder(orderTicket: orderInformation!)
        //self.presentedViewController!.dismiss(animated: true, completion: nil)
    }

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
    func setupRejectButton() {
        rejectButton.setTitle("Reject", for: .normal)
        rejectButton.showsTouchWhenHighlighted = true
        rejectButton.layer.cornerRadius = 5
        rejectButton.layer.borderWidth = 1
        rejectButton.layer.borderColor = CG_Colors.darkPurple
        rejectButton.backgroundColor = UI_Colors.darkPurple
        rejectButton.addTarget(self, action: #selector(orderCompletedAction), for: .touchUpInside)
        rejectButton.setTitleColor(.white, for: .normal)
    }
    func settupLabels() {
        orderNumberLabel.text = "Order: " +  orderInformation!.orderNumber
        print(orderInformation!.toppings.count)
        print(orderInformation!.toppings)
//        itemsOrderedLabel.text = orderInformation?.items
//        if ((orderInformation?.additionalRequests?.isEmpty) == nil){
//            additionalCommentsLabel.text =  "Special Instructions: None"
//        } else {
//        additionalCommentsLabel.text =  "Special Instructions: " + orderInformation!.additionalRequests!
//        }
        let timeText = getTimeStamp(order: orderInformation!)
//        nameLabel.text = "Customer Name: " + orderInformation!.customerId
        timeLabel.text = "Time: " + timeText
//
    }
    func gettingItems() {
        var itemsText = ""
        for item in orderInformation!.items{
            itemsText = itemsText + item + ","
        }
       // itemsOrderedLabel.text = "Items ordered: " + itemsText
    }
    @objc func doNothing() {
        print("yay")
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

extension OrderConfirmation: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderInformation?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderBreakdownTableViewCell") as! OrderBreakdownTableViewCell
        cell.configureCell(order: orderInformation!)
        reloadInputViews()
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
                    headerView.backgroundColor = UIColor.white

                    let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width:
                        tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: fonts.righteous, size: 24)
                    headerLabel.textColor = UIColor.black
        let nameOfCustomer = "Items for " + orderInformation!.customerId + ":"
                    headerLabel.text = nameOfCustomer
                    headerLabel.sizeToFit()
                    headerView.addSubview(headerLabel)

                    return headerView
    }
    
    
}
