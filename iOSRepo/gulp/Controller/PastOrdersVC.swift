//
//  PastOrdersVC.swift
//  gulp
//
//  Created by vrain ahuja on 2/3/21.
//  Copyright © 2021 Gulp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PastOrdersVC: UIViewController {


    @IBOutlet weak var PastOrdersTableView: UITableView!
    @IBOutlet weak var SignOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settupSignOutButton()
        settupTableView()
        settupNavigationBar()

        // Do any additional setup after loading the view.
    }
    func settupSignOutButton() {
        SignOutButton.addTarget(self, action: #selector(SignOutFunction), for: .touchUpInside)
        SignOutButton.setTitle("Sign Out", for: .normal)
        SignOutButton.showsTouchWhenHighlighted = true
        SignOutButton.layer.cornerRadius = 5
        SignOutButton.layer.borderWidth = 1
        SignOutButton.layer.borderColor = CG_Colors.red
        SignOutButton.layer.backgroundColor = CG_Colors.red
        SignOutButton.setTitleColor(.white, for: .normal)
    }
    func settupTableView() {
        PastOrdersTableView.delegate = self
        PastOrdersTableView.dataSource = self
        PastOrdersTableView.register(UINib(nibName: "PastOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "PastOrderTableViewCell")
        PastOrdersTableView.separatorStyle = .none
        PastOrdersTableView.rowHeight = 100
        PastOrdersTableView.backgroundColor = UI_Colors.white
    }
    func settupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UI_Colors.white
    }

    @objc func SignOutFunction(){
        let firebaseAuth = Auth.auth()
       do {
         userservice.logoutUser()
         try firebaseAuth.signOut()
       } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
       }
         
        
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
extension PastOrdersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastOrderTableViewCell") as! PastOrderTableViewCell
        return cell
    }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                let headerView = UIView()
                headerView.backgroundColor = UIColor.lightGray

                let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
                    tableView.bounds.size.width, height: tableView.bounds.size.height))
                headerLabel.font = UIFont(name: "Verdana", size: 20)
                headerLabel.textColor = UIColor.white
                headerLabel.text = "Testing THis ou"
                headerLabel.sizeToFit()
                headerView.addSubview(headerLabel)

                return headerView
            }

         func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
    
    
}
