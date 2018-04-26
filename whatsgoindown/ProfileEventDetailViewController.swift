//
//  ProfileEventDetailViewController.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/26/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit

class ProfileEventDetailViewController: UIViewController {

    var event: Event!
    var delegate: Any?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDescr: UILabel!
    @IBOutlet weak var lblHost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //format the dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let startDate = dateFormatter.date(from: (event?.eventStartDate)!)
        let endDate = dateFormatter.date(from: (event?.eventEndDate)!)
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        let start = dateFormatter.string(from: startDate!)
        let end = dateFormatter.string(from: endDate!)
        
        imageView.image = UIImage(named: "cake")
        lblName.text = event?.eventName
        lblHost.text = "Hosted by \(event.eventHost)"
        lblAddress.text = event?.eventAddress
        lblStart.text = start
        lblEnd.text = end
        lblType.text = event?.eventType
        lblDescr.text = event?.eventDescription
    }
    
    @IBAction func backBtn(_ sender: Any) {
        if ((delegate as? ProfileViewController) != nil){
            self.performSegue(withIdentifier: "backToProfile", sender: self)
        }
    }
    
    @IBAction func editBtn(_ sender: Any) {
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
