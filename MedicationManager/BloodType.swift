//
//  BloodType.swift
//  Test
//
//  Created by Olivia on 2025/1/9.
//

// An enumeration representing all possible blood types
enum BloodType: String, CaseIterable, CustomStringConvertible {
    case APositive = "A+"
    case ANegative = "A-"
    case BPositive = "B+"
    case BNegative = "B-"
    case OPositive = "O+"
    case ONegative = "O-"
    case ABPositive = "AB+"
    case ABNegative = "AB-"
    
    // Readable description for each blood type
    var description: String {
        switch self {
            case .APositive: return "A-positive"
            case .ANegative: return "A-negative"
            case .BPositive: return "B-positive"
            case .BNegative: return "B-negative"
            case .OPositive: return "O-positive"
            case .ONegative: return "O-negative"
            case .ABPositive: return "AB-positive"
            case .ABNegative: return "AB-negative"
        }
    }

}
