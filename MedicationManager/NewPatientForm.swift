//
//  NewPatientForm.swift
//  MedicationManager
//
//  Created by Olivia on 2025/1/15.
//

import SwiftUI

// SwiftUI view for creating a new patient
struct NewPatientForm: View {
    // Variable for closing the form
    @Environment(\.dismiss) var dismiss
    
    // Binding to the patients array to add the new patient
    @Binding var patients: [Patient]

    // State variables for the new patient form
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: BloodType? = nil
    
    // State variables to store error messages
    @State private var firstNameErrorMessage: String?
    @State private var lastNameErrorMessage: String?
    @State private var dateOfBirthErrorMessage: String?
    @State private var heightErrorMessage: String?
    @State private var weightErrorMessage: String?

    var body: some View {
        NavigationView {
            Form {
                // Required Fields Section
                Section(header: Text("Required Fields")) {
                    // First Name TextField
                    TextField("First Name", text: $firstName)
                        .onChange(of: firstName) {
                            validateFirstName()
                        }
                        .accessibilityIdentifier("firstNameField")
                    if let firstNameErrorMessage = firstNameErrorMessage {
                        Text(firstNameErrorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    // Last Name TextField
                    TextField("Last Name", text: $lastName)
                        .onChange(of: lastName) {
                            validateLastName()
                        }
                        .accessibilityIdentifier("lastNameField")
                    if let lastNameErrorMessage = lastNameErrorMessage {
                        Text(lastNameErrorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Date of Birth DatePicker
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .onChange(of: dateOfBirth) {
                            validateDateOfBirth()
                        }
                        .accessibilityIdentifier("dateOfBirthField")
                    if let dateOfBirthErrorMessage = dateOfBirthErrorMessage {
                        Text(dateOfBirthErrorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Height TextField
                    TextField("Height (m)", text: $height)
                        .onChange(of: height) {
                            validateHeight()
                        }
                        .accessibilityIdentifier("heightField")
                    if let heightErrorMessage = heightErrorMessage {
                        Text(heightErrorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Weight TextField
                    TextField("Weight (kg)", text: $weight)
                        .onChange(of: weight) {
                            validateWeight()
                        }
                        .accessibilityIdentifier("weightField")
                    if let weightErrorMessage = weightErrorMessage {
                        Text(weightErrorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                // Optional Fields Section
                Section(header: Text("Optional Fields")) {
                    Picker("Blood Type", selection: $bloodType) {
                        // Blood Type Picker
                        Text("None").tag(BloodType?.none)
                        ForEach(BloodType.allCases, id: \.self) { bloodType in
                            Text(bloodType.rawValue).tag(bloodType as BloodType?)
                        }
                    }
                }
            }
            .navigationTitle("New Patient")
            .toolbar {
                // Cancel Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                // Save Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        savePatient()
                    }
                    .accessibilityIdentifier("saveButton")
                    .disabled(!isInputValid())
                }
            }
        }
    }

    // Validates the first name
    private func validateFirstName() {
        let regex = "^[A-Za-z]+$"
        if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: firstName) {
            firstNameErrorMessage = "Please enter a valid name."
        } else {
            firstNameErrorMessage = nil
        }
    }

    // Validates the last name
    private func validateLastName() {
        let regex = "^[A-Za-z]+$"
        if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: lastName) {
            lastNameErrorMessage = "Please enter a valid name."
        } else {
            lastNameErrorMessage = nil
        }
    }
    
    // Validates the date of birth
    private func validateDateOfBirth() {
        if dateOfBirth > Date() {
            dateOfBirthErrorMessage = "Please enter a valid date."
        } else {
            dateOfBirthErrorMessage = nil
        }
    }

    // Validates the height
    private func validateHeight() {
        if let heightValue = Double(height), heightValue > 0 {
            heightErrorMessage = nil
        } else {
            heightErrorMessage = "Please enter a valid height."
        }
    }

    // Validates the weight
    private func validateWeight() {
        if let weightValue = Double(weight), weightValue > 0 {
            weightErrorMessage = nil
        } else {
            weightErrorMessage = "Please enter a valid weight."
        }
    }

    // Checks if all required inputs are valid
    private func isInputValid() -> Bool {
        validateFirstName()
        validateLastName()
        validateDateOfBirth()
        validateHeight()
        validateWeight()
        
        return firstNameErrorMessage == nil && lastNameErrorMessage == nil && dateOfBirthErrorMessage == nil && heightErrorMessage == nil && weightErrorMessage == nil && !firstName.isEmpty && !lastName.isEmpty && !height.isEmpty && !weight.isEmpty
    }

    // Saves the new patient if all inputs are valid
    private func savePatient() {
        guard let parsedHeight = Double(height), let parsedWeight = Double(weight) else {
            return
        }

        let newPatient = Patient(
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            height: parsedHeight,
            weight: parsedWeight,
            bloodType: bloodType
        )
        patients.append(newPatient)
        dismiss()
    }
}
