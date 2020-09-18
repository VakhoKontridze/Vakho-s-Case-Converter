//
//  MainFactory.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/12/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Main Factory
final class MainFactory: WindowFactory, WindowFactoryable {
    // MARK: Properties
    static let shared: MainFactory = .init()
    
    let rootView: some View = MainView()
    
    let rect: WindowRectParameters = .init(
        savesOrigin: false,
        savesSize: false, defaultSize: MainView.ViewModel.window
    )
    
    let titleBar: WindowFactoryTitleBarSettings = .init(
        title: AppDelegate.appName,
        isTransparent: true,
        titleButtons: [.close]
    )
    
    // MARK: Initialize
    private override init() {
        super.init()
    }
}

// MARK:- Create
extension MainFactory {
    func createWindow() {
        super.createWindow(sender: self)
    }
}

// MARK:- Window Delegate
extension MainFactory: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        super.saveFrame(notification)
        AppDelegate.terminateApp()
    }
}
