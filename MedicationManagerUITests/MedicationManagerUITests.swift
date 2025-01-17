//
//  MedicationManagerUITests.swift
//  MedicationManagerUITests
//
//  Created by Olivia on 2025/1/12.
//

import XCTest

final class MedicationManagerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Tests the functionality of prescribing a medication to a patient
    @MainActor
    func testPrescribeMedication() throws {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        
        // Locate and tap the patient
        let patient = app.staticTexts["Benjamin, Jack"]
        XCTAssertTrue(patient.exists, "Patient not found in the list")
        patient.tap()
        
        // Locate and tap the Prescribe new Medication button
        let prescribeButton = app.buttons["prescribeMedicationButton"]
        XCTAssertTrue(prescribeButton.exists, "No Prescribe Medication button")
        prescribeButton.tap()
        
        // Fill out the test medication name
        let medicationNameField = app.textFields["Name"]
        XCTAssertTrue(medicationNameField.exists, "No Medication Name field")
        medicationNameField.tap()
        medicationNameField.typeText("Aspirin")
        
        // Fill out the tets dose
        let doseField = app.textFields["Dose"]
        XCTAssertTrue(doseField.exists, "No Dose field")
        doseField.tap()
        doseField.typeText("81 mg")
        
        // Fill out the test route
        let routeField = app.textFields["Route"]
        XCTAssertTrue(routeField.exists, "No Route field")
        routeField.tap()
        routeField.typeText("By Mouth")
        
        // Fill out the test frequency
        let frequencyField = app.textFields["Frequency"]
        XCTAssertTrue(frequencyField.exists, "No Frequency field")
        frequencyField.tap()
        frequencyField.typeText("Twice Daily")
        
        // Fill out the test duration
        let durationField = app.textFields["Duration"]
        XCTAssertTrue(durationField.exists, "No Duration field")
        durationField.tap()
        durationField.typeText("30")
        
        // Save the medication
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists, "No Save button")
        saveButton.tap()
        
        // Verify the medication has been added
        let newMedication = app.staticTexts["Aspirin"]
        XCTAssertTrue(newMedication.exists, "New medication was not added")
    }
}
