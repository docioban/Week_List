//
//  Time.swift
//  Week List
//
//  Created by Macbook Pro on 11/29/20.
//

import Foundation

struct Time: Codable, Hashable {
    let hour, minutes: Int
    
    func adaugaTimp(hour: Int, minute: Int) -> (Int, Int) {
        var m = minute + self.minutes
        let h = hour + self.hour + m/60
        m %= 60
        return (h, m)
    }
    
    func timeToString() -> String {
        var s = hour < 10 ? "0\(hour):" : "\(hour):"
        s += minutes < 10 ? "0\(minutes)" : "\(minutes)"
        return s
    }
}
