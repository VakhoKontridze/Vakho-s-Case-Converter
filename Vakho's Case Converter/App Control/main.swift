//
//  main.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/12/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Cocoa

private let appDelegate: AppDelegate = .init()
NSApplication.shared.delegate = appDelegate

//private let menuBar: NSMenu = AppMenu(settings: appDelegate.passwordSettings)
//NSApplication.shared.mainMenu = menuBar

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
