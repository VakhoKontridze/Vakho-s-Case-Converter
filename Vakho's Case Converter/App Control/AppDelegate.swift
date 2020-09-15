//
//  AppDelegate.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/11/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Cocoa
import SwiftUI

/*@NSApplicationMain*/ final class AppDelegate: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer = .init(name: "Vakho_s_Case_Converter")

        container.persistentStoreDescriptions.append({
            let description: NSPersistentStoreDescription = .init()
            description.shouldMigrateStoreAutomatically = true
            description.shouldInferMappingModelAutomatically = true
            return description
        }())
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in })
        
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext { persistentContainer.viewContext }
}

// MARK:- App Delegate
extension AppDelegate: NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MainFactory.shared.createWindow()
        
        _ = SpecialWords.shared        // Initializes instance
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

// MARK: App Name
extension AppDelegate {
    static var appName: String {
        ProcessInfo.processInfo.processName
    }
}

// MARK:- Core Data
extension AppDelegate {
    @IBAction func saveAction(_ sender: AnyObject?) -> Void {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSApp.presentError(error)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? { managedObjectContext.undoManager }
}

// MARK:- Exit
extension AppDelegate {
    static func terminateApp() {
        exit(0)
    }
}
