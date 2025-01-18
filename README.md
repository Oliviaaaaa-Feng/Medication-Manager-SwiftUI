# Medication Manager - SwiftUI Version
This is an iOS application built using SwiftUI to manage patient data. It records the personal details and medications, and prescripts new medications. 
The app allows users to:
- View a list of patients.
- Search for patients by their last name.
- Add new patients to the system.
- View patient details information, and their current medications.
- Prescribe new medications to patients, and prevent adding duplicate medications.

## Features
### 1. Patient List View
- Displays a list of patients sorted alphabetically by last name.
- Shows the patient's full name, age, and medical record number.
- Includes a search bar to filter patients by last name.
- A button to add new patients via a form.

### 2. New Patient Form
- A form to add new patients to the system.
- Required fields: First Name, Last Name, Date of Birth, Height, and Weight.
- Optional field: Blood Type.
- Shows error messages when encountering invalid inputs.
- Save button: remains disabled until all required fields are filled and valid.

### 3. Patient Detail View
- Displays detail information about a patient.
- Shows basic information —— name, date of birth, age, height, weight, and blood type.
- Lists the patient's current medications.
- Provides a button to prescribe new medications.

### 4. Prescribe Medication View
- A form to prescribe medications to a patient.
- Required fields: Medication Name, Dose, Route, Frequency, and Duration.
- Checks for duplicate medications based on name and active period.
- Displays error messages for invalid inputs or duplicate medications.

### 5.Tests
- Includes accessibility identifier for testing UI features.
- Used accessibility inspector to test voice-over to ensure the app is user-friendly for everyone.

## Release Information
- **Version**: 0.1.0
- **GitHub Repository**: [Medication Manager](https://github.com/Oliviaaaaa-Feng/Medication-Manager-SwiftUI)
- **Release Tag**: [0.1.0](https://github.com/Oliviaaaaa-Feng/Medication-Manager-SwiftUI/releases/tag/0.1.0)

