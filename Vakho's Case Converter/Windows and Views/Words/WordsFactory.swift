//
//  WordsFactory.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/13/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Words Factory
final class WordsFactory: WindowFactory, WindowFactoryable {
    // MARK: Properties
    static let shared: WordsFactory = .init()
    
    let rootView: some View = WordsView()
    
    let rect: WindowRectParameters = .init(
        defaultSize: WordsView.ViewModel.window
    )
    
    let titleBar: WindowFactoryTitleBarSettings = .init(
        title: "Articles, Prepositions, and Conjunctions",
        isTransparent: true,
        titleButtons: [.close, .miniaturize, .zoom]
    )
    
    // MARK: Initialize
    private override init() {
        super.init()
    }
}

// MARK:- Create
extension WordsFactory {
    func createWindow() {
        super.createWindow(sender: self)
    }
}

// MARK:- Window Delegate
extension WordsFactory: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        super.saveFrame(notification)
    }
}
