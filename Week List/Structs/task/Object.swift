//
//  Object.swift
//  Week List
//
//  Created by Macbook Pro on 12/5/20.
//

import Foundation

struct Object: Codable {
    var name: String
    var tasks: [Task]
}

var objects = [Object]()
