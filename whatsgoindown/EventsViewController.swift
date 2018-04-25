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
    var eventsToShow = [Event]()
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
        eventsToShow.removeAll()
        for j in eventsList {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.short
            let startDate = dateFormatter.date(from: j.eventStartDate)
            let endDate = dateFormatter.date(from: j.eventEndDate)
            //if startDate! <= currentDate && endDate! >= currentDate {
            //    eventsToShow.append(j)
            //}
            eventsToShow.append(j)

        }
        print(count)
        print(eventsList)
        print(eventsToShow.count)
        print(eventsToShow)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let event = self.eventsToShow[indexPath.row]
        
        cell.textLabel?.text = event.eventName
        cell.detailTextLabel?.text =  event.eventAddress
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EventDetailViewController,
            let selectedIndexPath = self.tableview.indexPathForSelectedRow {
            destinationVC.event = self.eventsToShow[selectedIndexPath.row]
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

