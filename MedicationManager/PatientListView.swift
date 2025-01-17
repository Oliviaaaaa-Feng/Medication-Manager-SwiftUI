//
//  PatientListView.swift
//  MedicationManager
//
//  Created by Olivia on 2025/1/14.
//

import SwiftUI

// A view that displays a list of patients
struct PatientListView: View {
    // List of sample patients to display
    @State private var patients: [Patient] = {
        var patient1 = Patient(firstName: "Jack", lastName: "Benjamin", dateOfBirth: DateComponents(calendar: .current, year: 1992, month: 8, day: 13).date!, height: 1.78, weight: 75.0, bloodType: .ONegative)
        // Prescribes a sample medication to the first patient
        do {
            try patient1.prescribeNewMedication(
                Medication(datePrescribed: Date(), name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: "once daily", duration: 90))
        } catch {
            print("Failed to prescribe medication: \(error)")
        }
        
        var patient2 = Patient(firstName: "Curtis", lastName: "Evans", dateOfBirth: DateComponents(calendar: .current, year: 1981, month: 6, day: 1).date!, height: 1.84, weight: 60.0, bloodType: .ABPositive)
        var patient3 = Patient(firstName: "Olivia", lastName: "Feng", dateOfBirth: DateComponents(calendar: .current, year: 2002, month: 3, day: 19).date!, height: 1.61, weight: 50.0, bloodType: .BPositive)
        return [patient1, patient2, patient3]
    }()
    
    // Search query entered by the user
    @State private var searchText: String = ""
    
    // Controls the Add New Patient form
    @State private var isAddingNewPatient = false

    var body: some View {
        NavigationStack {
            // Displays the filtered list of patients
            List(filteredPatients) { patient in
                NavigationLink(destination: PatientDetailView(patient: patient).accessibilityIdentifier("PatientDetailView")) {
                    // Displays patient details
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(patient.lastName), \(patient.firstName)")
                            .font(.headline)
                        Text("Age: \(patient.age)")
                            .font(.subheadline)
                        Text("Medical Record Number: \(patient.medicalRecordNumber.uuidString)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Patients")
            // Search bar for filtering patients
            .searchable(text: $searchText, prompt: "Search by Last Name")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Button to add a new patient
                    Button(action: {
                        isAddingNewPatient = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("addNewPatientButton")
                }
            }
            .sheet(isPresented: $isAddingNewPatient) {
                NewPatientForm(patients: $patients)
            }
        }
    }
    
    // Filters the patients based on the search
    private var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return sortedPatients
        } else {
            return sortedPatients.filter { $0.lastName.contains(searchText) }
        }
    }

    // Sorts the patients alphabetically by last name
    private var sortedPatients: [Patient] {
        patients.sorted { $0.lastName < $1.lastName }
    }
}

#Preview {
    PatientListView()
}
