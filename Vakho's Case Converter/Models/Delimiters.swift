//
//  Delimiters.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/15/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation

// MARK:- Delimiters
struct Delimiters {
    // MARK: Properties
    static let noSpace: [String] = ["(", ")", "[", "]", "{", "}", ";", ":", "\u{2013}", "\u{2014}"]      // No whitespace
    static let spaceOnRight: [String] = [".", "?", "!", "..."]                                             // Whitespace on right
    static let spaceOnLeftAndRight: [String] = ["-"]
    
    static let allDelimiters: String = "( ) [ ] { } . ? ! ... ; : - \"\u{2013}\" \"\u{2014}\""
    
    // MARK: Initializers
    private init() {}
}
