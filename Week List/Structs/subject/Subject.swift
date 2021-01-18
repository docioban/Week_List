//
//  Subject.swift
//  Week List
//
//  Created by Macbook Pro on 11/29/20.
//

import Foundation

struct Subject: Codable, Hashable {
    
    let subject: String
    var info: String?
    let timeBegin, timeEnd: Time
    
    func timeToString() -> String {
        return timeBegin.timeToString() + " -> " + timeEnd.timeToString()
    }
    
    static func == (lhs: Subject, rhs: Subject) -> Bool {
        return lhs.subject == rhs.subject
    }
}
