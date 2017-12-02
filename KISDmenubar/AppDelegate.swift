//
//  AppDelegate.swift
//  KISDmenubar
//
//  Created by Donovan, Mike on 12/1/17.
//  Copyright © 2017 Donovan, Mike. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // Show Desktop icons
        let writeProcess = Process()
        writeProcess.launchPath = "/usr/bin/env"
        writeProcess.arguments = ["defaults", "write", "com.apple.finder", "CreateDesktop", "true"]
        
        writeProcess.launch()
        writeProcess.waitUntilExit()
        
        let dockProcess = Process()
        dockProcess.launchPath = "/usr/bin/env"
        dockProcess.arguments = ["killall", "Finder"]
        
        dockProcess.launch()
        dockProcess.waitUntilExit()
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

