//
//  PrescribeMedicationView.swift
//  MedicationManager
//
//  Created by Olivia on 2025/1/16.
//

import SwiftUI

// A view to prescribe a new medication for a patient
struct PrescribeMedicationView: View {
    // Dismisses the current view when called
    @Environment(\.dismiss) var dismiss
    
    // State variables to store input values
    @State private var name: String = ""
    @State private var dose: String = ""
    @State private var route: String = ""
    @State private var frequency: String = ""
    @State private var duration: String = ""
    
    // Patient object
    @ObservedObject var patient: Patient
    
    // Callback function when a new medication is saved
    let onSave: (Medication) -> Void

    // Error message if prescription fails
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            // Form to enter medication details
            Form {
                // Section for medication input
                Section(header: Text("Medication Details")) {
                    TextField("Name", text: $name)
                        .accessibilityIdentifier("medicationNameField")

                    TextField("Dose", text: $dose)
                        .accessibilityIdentifier("doseField")

                    TextField("Route", text: $route)
                        .accessibilityIdentifier("routeField")

                    TextField("Frequency", text: $frequency)
                        .accessibilityIdentifier("frequencyField")

                    TextField("Duration", text: $duration)
                        .accessibilityIdentifier("durationField")
                }
                // Display error message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .navigationTitle("Prescribe Medication")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // Cancel button
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Save button
                    Button("Save") {
                        saveMedication()
                    }
                    .disabled(!isValid)
                    .accessibilityIdentifier("saveButton")
                }
            }
        }
    }

    // Validates the form to ensure all fields are filled
    private var isValid: Bool {
        !name.isEmpty &&
        !dose.isEmpty &&
        !route.isEmpty &&
        !frequency.isEmpty &&
        !duration.isEmpty
    }

    // Saves the medication
    private func saveMedication() {
        // Check duration is an integer
        guard let durationValid = Int(duration) else {
            errorMessage = "Please enter a valid duration."
            return
        }
        
        // Create a new medication object with the entered details
        let medication = Medication(
            datePrescribed: Date(),
            name: name,
            dose: dose,
            route: route,
            frequency: frequency,
            duration: durationValid
        )

        do {
            // Attempt to add the medication to the patient
            try patient.prescribeNewMedication(medication)
            errorMessage = nil
            dismiss()
        } catch Patient.MedicationError.duplicateMedication {
            // Handle the case if the medication duplicate
            errorMessage = "This medication is already prescribed."
        } catch {
            // Handle other unexpected errors
            errorMessage = "An unexpected error occurred."
        }
    }
}
