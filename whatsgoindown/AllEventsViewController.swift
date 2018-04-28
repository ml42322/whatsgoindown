//
//  AllEventsViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/23/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit

class AllEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pastEventView: UITableView!
    @IBOutlet weak var upcomingEventView: UITableView!
    var pastEventsList = [Event]()
    var upcomingEventsList = [Event]()
    var eventsList = [Event]()
    let currentDate = Date()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = DataStore.shared.count()
        var i = 0
        while i < count {
            eventsList.append(DataStore.shared.getEvent(index: i))
            i += 1
        }

        for j in eventsList {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
            let startDate = dateFormatter.date(from: j.eventStartDate)
            let endDate = dateFormatter.date(from: j.eventEndDate)
            if endDate! <= currentDate {
                pastEventsList.append(j)
            }else{
                upcomingEventsList.append(j)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if tableView == upcomingEventView  {
            count = upcomingEventsList.count
        }
        else if tableView == pastEventView {
            count = pastEventsList.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if tableView == pastEventView{
            cell = tableView.dequeueReusableCell(withIdentifier: "pastid", for: indexPath)
            let event = pastEventsList[indexPath.row]
            cell.textLabel?.text = event.eventName
            cell.detailTextLabel?.text =  event.eventAddress
            print("Past \(event.eventName)")
        }
        if tableView == upcomingEventView{
             cell = tableView.dequeueReusableCell(withIdentifier: "allid", for: indexPath)
        
            let event = upcomingEventsList[indexPath.row]
            cell.textLabel?.text = event.eventName
            cell.detailTextLabel?.text =  event.eventAddress
            print("Upcoming \(event.eventName)")

        }

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

}
