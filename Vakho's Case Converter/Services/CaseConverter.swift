//
//  CaseConverter.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/18/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation

// MARK:- Case Converter
final class CaseConverter {
    // MARK: Proeprties
    static let shared: CaseConverter = .init()
    
    // MARK: Initializers
    private init() {}
}

// MARK:- Lowercase
extension CaseConverter {
    func toLowercase(_ phrase: String, fixSpacing: Bool) -> String {
        var phrase: String = phrase
        
        phrase = phrase.lowercased()
        
        if fixSpacing { phrase.fixSpacing() }
        
        return phrase
    }
}

// MARK:- Uppercase
extension CaseConverter {
    func toUppercase(_ phrase: String, fixSpacing: Bool) -> String {
        var phrase: String = phrase
        
        phrase = phrase.uppercased()
        
        if fixSpacing { phrase.fixSpacing() }
        
        return phrase
    }
}

// MARK:- Sentence Case
extension CaseConverter {
    func toSentenceCase(_ phrase: String, fixSpacing: Bool) -> String {
        var phrase: String = phrase
        
        var previousWasFullStop: Bool = false
        var previousWasWhiteSpace: Bool = false
        for (i, char) in phrase.enumerated() {
            if char == "." {
                previousWasFullStop = true
            } else if previousWasFullStop && char.isWhitespace {
                previousWasWhiteSpace = true
            } else if previousWasWhiteSpace {
                previousWasFullStop = false
                previousWasWhiteSpace = false
                phrase.replacing(at: i, with: char.uppercased())
            } else {
                phrase.replacing(at: i, with: char.lowercased())
            }
        }
        
        if fixSpacing { phrase.fixSpacing() }
        
        return phrase
    }
}

// MARK:- Capital Case
extension CaseConverter {
    func toCapitalCase(_ phrase: String, fixSpacing: Bool) -> String {
        var phrase: String = phrase
        
        var previousWasWhiteSpace: Bool = false
        for (i, char) in phrase.enumerated() {
            if char.isWhitespace {
                previousWasWhiteSpace = true
            } else if previousWasWhiteSpace {
                previousWasWhiteSpace = false
                phrase.replacing(at: i, with: char.uppercased())
            }
        }
        
        if fixSpacing { phrase.fixSpacing() }
        
        return phrase
    }
}

// MARK:- Alterante Case
extension CaseConverter {
    func toAlternateCase(_ phrase: String, fixSpacing: Bool) -> String {
        var phrase: String = phrase
        
        for (i, char) in phrase.enumerated() {
            let shouldBeLowercased: Bool = i % 2 == 0
            phrase.replacing(at: i, with: shouldBeLowercased ? char.lowercased() : char.uppercased())
        }
        
        if fixSpacing { phrase.fixSpacing() }
        
        return phrase
    }
}

// MARK:- Toggle Case
extension CaseConverter {
    func toToggleCase(_ phrase: String, fixSpacing: Bool) -> String {
        var phrase: String = phrase
        
        for (i, char) in phrase.enumerated() {
            phrase.replacing(at: i, with: char.isLowercase ? char.uppercased() : char.lowercased())
        }
        
        if fixSpacing { phrase.fixSpacing() }
        
        return phrase
    }
}

// MARK:- Helpers - Subscript
extension String {
    subscript(_ i: Int) -> Character {
        assert(i >= 0 && i < self.count, "Index Out of Range")
        return self[.init(utf16Offset: i, in: self)]
    }

    func replaced(at i: Int, with char: String) -> String {
        assert(i >= 0 && i < self.count, "Index Out of Range")
        return .init(self.prefix(i)) + char + String(self.dropFirst(i + 1))
    }
    
    mutating func replacing(at i: Int, with char: String) -> Void {
        self = replaced(at: i, with: char)
    }
}

// MARK:- Helpers - Spacing
private extension String {
    func fixedSpacing() -> String {
        self
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
    
    mutating func fixSpacing() {
        self = self.fixedSpacing()
    }
}
