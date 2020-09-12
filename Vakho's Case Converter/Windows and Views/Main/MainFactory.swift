//
//  MainFactory.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/12/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Main Factory
final class MainFactory {
    // MARK: Properties
    static let shared: MainFactory = .init()
    
    private(set) var window: NSWindow!

    // MARK: Initializers
    private init() {}
}

// MARK:- Window
extension MainFactory {
    func createWindow(managedObjectContext: NSManagedObjectContext) {
        // If window exists, brings it to front
        guard window == nil else {
            window.makeKeyAndOrderFront(nil)
            return
        }

        // Creates window
        window = .init(
            contentRect: .init(origin: .zero, size: MainView.ViewModel.window),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.makeKeyAndOrderFront(nil)

        // Customizes title bar
        window.titlebarAppearsTransparent = true

        window.title = AppDelegate.appName

        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isEnabled = false

        window.standardWindowButton(.zoomButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isEnabled = false
        
        // Creates view
        window.contentView = NSHostingView(rootView:
            MainView()
                .environment(\.managedObjectContext, managedObjectContext)
        )
    }
}
