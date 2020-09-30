//
//  Struct.swift
//  Demo
//
//  Created by Apple on 9/23/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import Foundation

// MARK: - Datum
struct EventDay: Codable {
    let date: Date
    let event: [Event]
    
    init(date: Date,event: [Event]) {
        self.date = date
        self.event = event
    }
}

// MARK: - Event
struct Event: Codable {
    let hours : String
    let activiti: String
    
    init(hours : String, activiti: String) {
        self.hours = hours
        self.activiti = activiti
    }
}
