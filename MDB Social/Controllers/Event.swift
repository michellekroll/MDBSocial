//
//  Event.swift
//  MDB Social
//
//  Created by Michelle Kroll on 11/4/20.
//

import Foundation

struct Event: Codable {
    
    var name = String()
    var date = Date()
    var desc = String()
    var creator = String()
    var numInterested = 0
    var imgURL = String()
    
    
}
