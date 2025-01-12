//
//  Medication.swift
//  Test
//
//  Created by Olivia on 2025/1/9.
//
import Foundation

struct Medication {
    let datePrescribed: Date
    let name: String
    let dose: String
    let route: String
    let frequency: String
    let duration: Int
}

extension Medication: CustomStringConvertible {
    var description: String {
        return "\(name) \(dose) \(route) \(frequency) for \(duration) days"
    }
}
