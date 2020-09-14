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
    
    @Published var principalWords: WordGroup = .init(capitalize: true, length: 4, range: 4...10)
    @Published var specialWords: WordGroup = .init(capitalize: true, length: 4, range: 1...10)
    
    @Published var fixSpacing: Bool = true
}
