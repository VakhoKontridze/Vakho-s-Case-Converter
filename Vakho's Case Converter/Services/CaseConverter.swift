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
    func toLowercase(_ sentence: String, fixSpacing: Bool) -> String {
        var sentence: String = sentence
        
        sentence = sentence.lowercased()
        
        if fixSpacing { sentence.fixSpacing() }
        
        return sentence
    }
}

// MARK:- Uppercase
extension CaseConverter {
    func toUppercase(_ sentence: String, fixSpacing: Bool) -> String {
        var sentence: String = sentence
        
        sentence = sentence.uppercased()
        
        if fixSpacing { sentence.fixSpacing() }
        
        return sentence
    }
}

// MARK:- Alterante Case
extension CaseConverter {
    func toAlternateCase(_ sentence: String, fixSpacing: Bool) -> String {
        var sentence: String = sentence
        
        for (i, char) in sentence.enumerated() {
            let shouldBeLowercased: Bool = i % 2 == 0
            sentence.replacing(at: i, with: shouldBeLowercased ? char.lowercased() : char.uppercased())
        }
        
        if fixSpacing { sentence.fixSpacing() }
        
        return sentence
    }
}

// MARK:- Toggle Case
extension CaseConverter {
    func toToggleCase(_ sentence: String, fixSpacing: Bool) -> String {
        var sentence: String = sentence
        
        for (i, char) in sentence.enumerated() {
            sentence.replacing(at: i, with: char.isLowercase ? char.uppercased() : char.lowercased())
        }
        
        if fixSpacing { sentence.fixSpacing() }
        
        return sentence
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
