//
//  WordsWindow.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/13/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Words Widow
final class WordsWindow: WindowFactory, WindowFactoryable {
    // MARK: Properties
    static let shared: WordsWindow = .init()
    
    var rootView: some View {
        WordsView()
    }
    
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
extension WordsWindow {
    func createWindow() {
        super.createWindow(sender: self)
    }
}

// MARK:- Window Delegate
extension WordsWindow: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        super.saveFrame(notification)
    }
}
