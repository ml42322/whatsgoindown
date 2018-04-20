//
//  EventDetailViewController.swift
//  whatsgoindown
//
//  Created by Hannah Lu on 4/12/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
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
    
    @IBAction func backBtn(_ sender: Any) {
        if ((delegate as? ProfileViewController) != nil){
                    self.performSegue(withIdentifier: "tohost", sender: self)
        }else{
                        self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
        //swipeUp.direction = UISwipeGestureRecognizerDirection.up
        //self.view.addGestureRecognizer(swipeUp)
        
        imageView.image = UIImage(named: "cake")
        lblName.text = event?.eventName
        lblHost.text = "Hosted by \(event.eventHost)"
        lblAddress.text = event?.eventAddress
        lblStart.text = event?.eventStartDate
        lblEnd.text = event.eventEndDate
        lblType.text = event?.eventType
        lblDescr.text = event?.eventDescription
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*@objc func handleSwipe(_ sender: UIGestureRecognizer) {
        print("up")
        self.performSegue(withIdentifier: "toHome", sender: self)
    }*/
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    print("preparing")
    //}
}
