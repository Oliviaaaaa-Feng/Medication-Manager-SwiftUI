//
//  Medication.swift
//  Test
//
//  Created by Olivia on 2025/1/9.
//
import Foundation
@Observable

// Medication prescribed to a patient
class Medication {
    let datePrescribed: Date
    let name: String
    let dose: String
    let route: String
    let frequency: String
    let duration: Int
    
    // Initializes a new Medication instance
    init(datePrescribed: Date, name: String, dose: String, route: String, frequency: String, duration: Int) {
        self.datePrescribed = datePrescribed
        self.name = name
        self.dose = dose
        self.route = route
        self.frequency = frequency
        self.duration = duration
    }
    
    // Formats the prescription date as MM-dd-yyyy
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: datePrescribed)
    }
}

// A custom description of a medication
extension Medication: CustomStringConvertible {
    var description: String {
        return "\(name) \(dose) \(route) \(frequency) for \(duration) days"
    }
}
