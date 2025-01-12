//
//  TestTests.swift
//  TestTests
//
//  Created by Olivia on 2025/1/9.
//

import Testing
import Foundation
@testable import MedicationManager

struct TestTests {
    var patient: Patient!
    
    // Initialize
    init() {
        patient = Patient(
            firstName: "Olivia",
            lastName: "Feng",
            dateOfBirth: DateComponents(calendar: .current, year: 2002, month: 3, day: 19).date!,
            height: 1.61,
            weight: 50.0,
            bloodType: .BNegative
        )
        
        let medication1 = Medication(
            datePrescribed: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
            name: "Aspirin",
            dose: "300 mg",
            route: "by mouth",
            frequency: "every 4 to 6 hours",
            duration: 10
        )
        
        let medication2 = Medication(
            datePrescribed: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            name: "Isotretunoin",
            dose: "1 mg",
            route: "by mouth",
            frequency: "once daily",
            duration: 90
        )
        
        let medication3 = Medication(
            datePrescribed: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
            name: "Losartan",
            dose: "12.5 mg",
            route: "by mouth",
            frequency: "once daily",
            duration: 90
        )
        
        patient.medications = [medication1, medication2, medication3]
    }

    // name and age test
    @Test func testNameAndAge() async throws {
        let result = patient.nameAndAge()
        #expect(result == "Feng, Olivia (22 years old)")
    }
    
    // current medications test
    @Test func testCurrentMedications() async throws {
        let result = patient.currentMedications()
        
        let expected = [
            Medication(
                datePrescribed: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                name: "Isotretunoin",
                dose: "1 mg",
                route: "by mouth",
                frequency: "once daily",
                duration: 90
            ),
            Medication(
                datePrescribed: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
                name: "Losartan",
                dose: "12.5 mg",
                route: "by mouth",
                frequency: "once daily",
                duration: 90
            )
        ]
        
        let resultNames = result.map { $0.name }
        let expectedNames = expected.map { $0.name }
        
        #expect(resultNames == expectedNames)
    }
    
    // prescribe new medecation test
    @Test mutating func testPrescribeNewMedication() throws {
        //Add a new medication
        let newMedication = Medication(
            datePrescribed: Date(),
            name: "Metoprolol",
            dose: "25 mg",
            route: "by mouth",
            frequency: "twice daily",
            duration: 30
        )
        
        try patient.prescribeNewMedication(newMedication)
        let result = patient.medications.map { $0.name }
        #expect(result.contains("Metoprolol"))
        
        // add a duplicate medication
        let duplicateMedication = Medication(
            datePrescribed: Date(),
            name: "Isotretunoin",
            dose: "1 mg",
            route: "by mouth",
            frequency: "once daily",
            duration: 90
        )
        
        do {
            try patient.prescribeNewMedication(duplicateMedication)
        } catch let error as Patient.MedicationError {
            #expect(error == .duplicateMedication)
        }
    }
    
    // donor blood types test
    @Test mutating func testDonorBloodTypes() throws {
        // test O-
        patient.bloodType = .ONegative
        let resultONegative = patient.donorBloodTypes()
        let expectedONegative: [BloodType] = [.ONegative]
        #expect(resultONegative == expectedONegative)

        // test B-
        patient.bloodType = .BNegative
        let resultBNegative = patient.donorBloodTypes()
        let expectedBNegative: [BloodType] = [.ONegative, .BNegative]
        #expect(resultBNegative == expectedBNegative)
        
        //test AB+
        patient.bloodType = .ABPositive
        let resultABPositive = patient.donorBloodTypes()
        let expectedABPositive: [BloodType] = [.ONegative, .OPositive, .BNegative, .BPositive, .ANegative, .APositive, .ABNegative, .ABPositive]
        #expect(resultABPositive == expectedABPositive)
        
        // test A+
        patient.bloodType = .APositive
        let resultAPositive = patient.donorBloodTypes()
        let expectedAPositive: [BloodType] = [.ONegative, .OPositive, .ANegative, .APositive]
        #expect(resultAPositive == expectedAPositive)

        // test when no blood type assigned
        patient.bloodType = nil
        let resultNoBloodType = patient.donorBloodTypes()
        let expectedNoBloodType: [BloodType] = []
        #expect(resultNoBloodType == expectedNoBloodType)
    }
    
    // test medication history
    @Test func testMedicationHistory() throws {
        let expectedHistory = [
            "Aspirin (300 mg): Completed",
            "Isotretunoin (1 mg): Active",
            "Losartan (12.5 mg): Active"
        ]
        
        let result = patient.medicationHistory()
        #expect(result == expectedHistory)
    }
    
    // test if the patient has a specific medication
    @Test func testHasMedication() throws {
        let result1 = patient.hasMedication(named: "Aspirin")
        #expect(result1 == "The patient is taking Aspirin.")

        let result3 = patient.hasMedication(named: "Isotretunoin")
        #expect(result3 == "The patient is taking Isotretunoin.")
        
        let result2 = patient.hasMedication(named: "Metoprolol")
        #expect(result2 == "The patient is not taking Metoprolol.")
    }

    // test age group
    @Test mutating func testAgeGroup() throws {
        patient.dateOfBirth = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
        let resultChild = patient.ageGroup()
        #expect(resultChild == "Child")

        patient.dateOfBirth = Calendar.current.date(byAdding: .year, value: -15, to: Date())!
        let resultTeenager = patient.ageGroup()
        #expect(resultTeenager == "Teenager")

        patient.dateOfBirth = Calendar.current.date(byAdding: .year, value: -30, to: Date())!
        let resultAdult = patient.ageGroup()
        #expect(resultAdult == "Adult")

        patient.dateOfBirth = Calendar.current.date(byAdding: .year, value: -70, to: Date())!
        let resultSenior = patient.ageGroup()
        #expect(resultSenior == "Senior")
    }


}
