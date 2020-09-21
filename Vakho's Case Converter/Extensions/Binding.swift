//
//  Binding.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/1/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: {
                self.wrappedValue
            },
            
            set: { value in
                self.wrappedValue = value
                handler()
            }
        )
    }
    
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: {
                self.wrappedValue
            },
            
            set: { value in
                self.wrappedValue = value
                handler(value)
            }
        )
    }
}
