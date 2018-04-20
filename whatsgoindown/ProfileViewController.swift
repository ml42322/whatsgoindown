//
//  ProfileViewController.swift
//  whatsgoindown
//
//  Created by Michell Li on 4/18/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let user = Auth.auth().currentUser
    @IBOutlet weak var tblAttendEvent: UITableView!
    @IBOutlet weak var tblHostEvent: UITableView!
    @IBOutlet weak var lblEmail: UILabel!
    var hostEvents = [Event]()
    var index = [Int]()
    var hostcount = 0
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            let email = user.email
            lblEmail.text = email!.description
        }

        while i < DataStore.shared.count(){
            print(DataStore.shared.getEvent(index: i).eventHost)
            if DataStore.shared.getEvent(index: i).eventHost == (user?.email)!{
                hostEvents.append(DataStore.shared.getEvent(index:i))
                hostcount += 1
                index.append(i)
            }
            i += 1
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hostcount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hostid", for: indexPath)
        //let hostEvents = DataStore.shared.getEvent(index: indexPath.row)
        cell.textLabel?.text = hostEvents[indexPath.row].eventName
        cell.detailTextLabel?.text =  hostEvents[indexPath.row].eventAddress
 
        return cell

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EventDetailViewController,
            let selectedIndexPath = self.tblHostEvent.indexPathForSelectedRow {
            destinationVC.event = DataStore.shared.getEvent(index: index[selectedIndexPath.row])
            // Set the delegate (self = this object).
            destinationVC.delegate = self
        }
    }

}
