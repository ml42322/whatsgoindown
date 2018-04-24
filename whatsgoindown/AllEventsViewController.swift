//
//  AllEventsViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/23/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit

class AllEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventsList = [Event]()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = DataStore.shared.count()
        var i = 0
        while i < count {
            eventsList.append(DataStore.shared.getEvent(index: i))
            i += 1
        }
        print(count)
        print(eventsList)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(DataStore.shared.count())
        return DataStore.shared.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allid", for: indexPath)
        
        let event = DataStore.shared.getEvent(index: indexPath.row)
        cell.textLabel?.text = event.eventName
        cell.detailTextLabel?.text =  event.eventAddress
        print("cell.textLabel?.text!")
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
