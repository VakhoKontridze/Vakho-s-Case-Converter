//
//  Conversion.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/15/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation

// MARK:- Conversion
enum Conversion: Int, CaseIterable, Identifiable {
    case lower, upper
    case title, sentence, capital
    case alternate, toggle
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .lower: return "Lowercase"
        case .upper: return "Uppercase"
        case .title: return "Title Case"
        case .sentence: return "Sentence Case"
        case .capital: return "Capital Case"
        case .alternate: return "Alternate Case"
        case .toggle: return "Toggle Case"
        }
    }
}
