//
//  Day.swift
//  Week List
//
//  Created by Macbook Pro on 11/29/20.
//

import Foundation

struct Day: Codable {
    var appear: Bool
    var name, color: String
    var subjects: [Subject]
}

var days: [Day]!
var allSubjects: [String] = []
