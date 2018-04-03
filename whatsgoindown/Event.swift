//
//  Event.swift
//  whatsgoindown
//
//  Created by Wilshire Liu on 4/2/18.
//  Copyright © 2018 Wilshire Liu. All rights reserved.
//

import Foundation

class Event {
    
    var id: String
    var eventName: String
    var eventHost: String
    var eventAddress: String
    var eventTime: String
    var eventType: String
    var eventDescription: String
    
    init(id: String, eventName: String, eventHost: String, eventAddress: String, eventTime: String, eventType: String, eventDescription: String) {
        self.id = id
        self.eventName = eventName
        self.eventHost = eventHost
        self.eventAddress = eventAddress
        self.eventTime = eventTime
        self.eventType = eventType
        self.eventDescription = eventDescription
    }
}
