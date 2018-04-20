//
//  EventsViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/10/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var eventsList = [Event]()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = DataStore.shared.count()
        for i in 0...(count-1) {
            eventsList.append(DataStore.shared.getEvent(index: i))
        }
        print(eventsList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.shared.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let event = DataStore.shared.getEvent(index: indexPath.row)
        
        cell.textLabel?.text = event.eventName
        cell.detailTextLabel?.text =  event.eventAddress
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EventDetailViewController,
            let selectedIndexPath = self.tableview.indexPathForSelectedRow {
            destinationVC.event = DataStore.shared.getEvent(index: selectedIndexPath.row)
            // Set the delegate (self = this object).
            destinationVC.delegate = self
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
