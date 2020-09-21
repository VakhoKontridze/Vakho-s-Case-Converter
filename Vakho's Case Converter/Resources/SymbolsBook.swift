//
//  SymbolsBook.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/21/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation
import SwiftUI

// MARK:- Symbols Book
struct SymbolsBook {
    // MARK: Properties
    static var navigateToWindow: some View {
        Text("→")
            .padding(3)
            .background(Circle().foregroundColor(.secondary))
    }
    
    // MARK: Initializers
    private init() {}
}
