//
//  Patient.swift
//  Test
//
//  Created by Olivia on 2025/1/9.
//
import Foundation
@Observable

// Represents a patient with detailed information
class Patient: ObservableObject, Identifiable{
    var id: UUID { medicalRecordNumber }
    let medicalRecordNumber: UUID
    let firstName: String
    let lastName: String
    var dateOfBirth: Date
    var height: Double
    var weight: Double
    var bloodType: BloodType?
    var medications: [Medication]
    var age: Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYear = Calendar.current.component(.year, from: dateOfBirth)
        return currentYear - birthYear
    }
    
    // Initializer
    init(firstName: String, lastName: String, dateOfBirth: Date, height: Double, weight: Double, bloodType: BloodType? = nil, medications: [Medication] = []) {
        self.medicalRecordNumber = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
    }
    
    // Patient’s full name and age
    func nameAndAge() -> String {
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
        return "\(lastName), \(firstName) (\(age) years old)"
    }
    
    // Formatted date of birth
    func formattedDateOfBirth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: dateOfBirth)
    }
    
    // A list of Medications the Patient is currently taking
    func currentMedications() -> [Medication] {
        let activeMedications = medications.filter { medication in
            let endDate = Calendar.current.date(byAdding: .day, value: medication.duration, to: medication.datePrescribed)!
            return endDate > Date()
        }
        
        return activeMedications.sorted { $0.datePrescribed > $1.datePrescribed }
    }
    
    // Duplicating medications error check
    enum MedicationError: Error {
        case duplicateMedication
    }
    
    // Prescribe a new Medication
    func prescribeNewMedication(_ newMedication: Medication) throws {
        let isDuplicate = medications.contains { medication in
            let endDate = Calendar.current.date(byAdding: .day, value: medication.duration, to: medication.datePrescribed)!
            return medication.name == newMedication.name && endDate > Date()
        }
                
        if isDuplicate {
            throw MedicationError.duplicateMedication
        }
                
        medications.append(newMedication)
    }
    
    // Donor blood types a Patient can receive
    func donorBloodTypes() -> [BloodType] {
        guard let bloodType = bloodType else {
            return []
        }
        
        switch bloodType {
            case .ONegative:
                return [.ONegative]
            case .OPositive:
                return [.ONegative, .OPositive]
            case .BNegative:
                return [.ONegative, .BNegative]
            case .BPositive:
                return [.ONegative, .OPositive, .BNegative, .BPositive]
            case .ANegative:
                return [.ONegative, .ANegative]
            case .APositive:
                return [.ONegative, .OPositive, .ANegative, .APositive]
            case .ABNegative:
                return [.ONegative, .BNegative, .ANegative, .ABNegative]
            case .ABPositive:
                return [.ONegative, .OPositive, .BNegative, .BPositive, .ANegative, .APositive, .ABNegative, .ABPositive]
        }
    }
    
    // Patient's medication history with status
    func medicationHistory() -> [String] {
        return medications.map { medication in
            let endDate = Calendar.current.date(byAdding: .day, value: medication.duration, to: medication.datePrescribed)!
            let status = endDate > Date() ? "Active" : "Completed"
            return "\(medication.name) (\(medication.dose)): \(status)"
        }
    }
    
    // Checking if the patient is taking a specific medication
    func hasMedication(named name: String) -> String {
        if medications.contains(where: { $0.name.lowercased() == name.lowercased() }) {
            return "The patient is taking \(name)."
        } else {
            return "The patient is not taking \(name)."
        }
    }
    
    // Categorizes the patient into an age group
    func ageGroup() -> String {
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
        switch age {
        case ..<13:
            return "Child"
        case 13..<18:
            return "Teenager"
        case 18..<65:
            return "Adult"
        default:
            return "Senior"
        }
    }
    
    
    
}
