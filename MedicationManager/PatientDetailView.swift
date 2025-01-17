//
//  PatientDetailView.swift
//  MedicationManager
//
//  Created by Olivia on 2025/1/15.
//

import SwiftUI

// Displays the detailed information of a patient
struct PatientDetailView: View {
    
    // The patient object being observed
    @ObservedObject var patient: Patient
    
    // Controls the Prescribe Medication sheet
    @State private var isPrescrib = false
    
    // The error message for duplicate medications
    @State private var duplicateError: String? = nil

    var body: some View {
        List {
            // Section displays the patient's information
            Section(header: Text("Basic Information").font(.headline)) {
                HStack {
                    Text("Name")
                        .bold()
                        .accessibilityLabel("Patient's name")
                    Spacer()
                    Text("\(patient.firstName) \(patient.lastName)")
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Date of Birth")
                        .bold()
                        .accessibilityLabel("Date of birth")
                    Spacer()
                    Text(patient.formattedDateOfBirth())
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Age")
                        .bold()
                        .accessibilityLabel("Age")
                    Spacer()
                    Text("\(patient.age)")
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Height")
                        .bold()
                        .accessibilityLabel("Height")
                    Spacer()
                    Text("\(patient.height, specifier: "%.2f") m")
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Weight")
                        .bold()
                        .accessibilityLabel("Weight")
                    Spacer()
                    Text("\(patient.weight, specifier: "%.2f") kg")
                        .multilineTextAlignment(.trailing)
                }
                // Optional blood type displayed only if available
                if let bloodType = patient.bloodType {
                    HStack {
                        Text("Blood Type")
                            .bold()
                            .accessibilityLabel("Blood type")
                        Spacer()
                        Text(bloodType.rawValue)
                            .multilineTextAlignment(.trailing)
                            .accessibilityLabel(bloodType.description)
                    }
                }
            }
            
            // Section displays the patient's current medications
            Section(header: Text("Medications").font(.headline)) {
                if patient.medications.isEmpty {
                    Text("No medications prescribed.")
                        .foregroundColor(.gray)
                        .accessibilityLabel("Medications")
                        .accessibilityValue("None prescribed")
                } else {
                    ForEach(patient.medications, id: \.name) { medication in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(medication.name)
                                    .font(.headline)
                                    .accessibilityLabel("Medications")
                                    .accessibilityValue(medication.name)
                                Spacer()
                                Text(medication.formatDate())
                                    .font(.subheadline)
                                    .accessibilityLabel("Date")
                                    .accessibilityValue(medication.formatDate())
                            }
                            Text("\(medication.dose) \(medication.route) \(medication.frequency) for \(medication.duration) days")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .accessibilityLabel("Usage")
                                .accessibilityValue("\(medication.dose) \(medication.route) \(medication.frequency) for \(medication.duration) days")
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            // Section prescribes new medications
            Section {
                Button(action: {
                    isPrescrib = true
                }) {
                    Text("Prescribe New Medication")
                        .font(.body)
                        .foregroundColor(.blue)
                }
                .accessibilityIdentifier("prescribeMedicationButton")
                .accessibilityLabel("Prescribe new medication")
            }

        }
        .navigationTitle("Patient Details")
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Patient Details")
        .sheet(isPresented: $isPrescrib) {
            // Presents the Prescribe Medication as a sheet
            PrescribeMedicationView(
                patient: patient,
                onSave: { medication in
                    try? patient.prescribeNewMedication(medication)
                }
            )
        }

    }
}
