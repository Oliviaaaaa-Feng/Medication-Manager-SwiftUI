//
//  BloodType.swift
//  Test
//
//  Created by Olivia on 2025/1/9.
//

enum BloodType: String, CustomStringConvertible {
    case APositive = "A+"
    case ANegative = "A-"
    case BPositive = "B+"
    case BNegative = "B-"
    case OPositive = "O+"
    case ONegative = "O-"
    case ABPositive = "AB+"
    case ABNegative = "AB-"
    
    var description: String {
        return self.rawValue
    }
}
