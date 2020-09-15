//
//  SettingsViewModel.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/13/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation

// MARK:- Settings View Model
final class SettingsViewModel: ObservableObject {
    @Published var capitalizeFirstAndLast: Bool = true
    
    @Published var principalWord: WordGroup = .init(capitalize: true, length: 4, range: 4...10)
    
    @Published var specialWord: WordGroup = .init(capitalize: true, length: 4, range: 1...10)
    @Published var specialWords: Set<SpecialWord> = SpecialWord.defaultValue
    
    @Published var capitalizeDelimeteredCompounds: Bool = true
    @Published var capitalizeHyphenatedCompounds: Bool = true
    
    @Published var fixSpacing: Bool = true
}


// MARK:- Sync
extension SettingsViewModel {
    func syncSpecialWord() {
        switch specialWord.capitalize {
        case false: specialWords = []
        case true: specialWords = SpecialWord.defaultValue
        }
    }
    
    func syncSpecialWords() {
        switch specialWords.isEmpty {
        case false: specialWord.capitalize = true
        case true: specialWord.capitalize = false
        }
    }
}
