//
//  MainViewModel.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/12/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation

// MARK:- Main View Model
extension MainView {
    struct ViewModel {
        // MARK: Properties
        static let window: CGSize = .init(width: view.width, height: view.height + titleBar.height)
        static let titleBar: CGSize = .init(width: -1, height: 22)
        
        static let view: CGSize = .init(width: 670, height: 745)
        
        static let picker: CGSize = .init(width: 135, height: -1)

        // MARK: Initializers
        private init() {}
    }
}
