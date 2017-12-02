//
//  StatusMenuController.swift
//  KISDmenubar
//
//  Created by Donovan, Mike on 12/1/17.
//  Copyright © 2017 Donovan, Mike. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {

    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon"))
        icon?.isTemplate = false // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        statusMenu?.item(withTitle: "Show Icons")?.isHidden = true
        
    }
    @IBAction func showIcons(_ sender: NSMenuItem) {
        
        //print("Show Desktop")
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
        
        //Alternate enabled menu items
        statusMenu?.item(withTitle: "Show Icons")?.isHidden = true
        statusMenu?.item(withTitle: "Hide Icons")?.isHidden = false
        
    }
    
    @IBAction func hideIcons(_ sender: NSMenuItem) {
        
        //print("Hide Desktop")
        // Hide Desktop icons
        let writeProcess = Process()
        writeProcess.launchPath = "/usr/bin/env"
        writeProcess.arguments = ["defaults", "write", "com.apple.finder", "CreateDesktop", "false"]
        
        writeProcess.launch()
        writeProcess.waitUntilExit()
        
        let dockProcess = Process()
        dockProcess.launchPath = "/usr/bin/env"
        dockProcess.arguments = ["killall", "Finder"]
        
        dockProcess.launch()
        dockProcess.waitUntilExit()
        
        //Alternate enabled menu items
        statusMenu?.item(withTitle: "Show Icons")?.isHidden = false
        statusMenu?.item(withTitle: "Hide Icons")?.isHidden = true
    }
    
    @IBAction func textDisplay(_ sender: NSMenuItem) {
        
        let bundle = Bundle.main
        let bhtPath = bundle.path(forResource: "BigHonkingText", ofType: "")
        
        let myString = getString(title: "BigHonkingText by John Kitzmiller", question: "Enter text to be displayed.\nClick OK\nClick text to dismiss.", defaultValue: "BigHonkingText")
        
        if (myString != "Cancel") {
            let myText = " " + myString + " "
            
            let writeProcess = Process()
            writeProcess.launchPath = bhtPath
            writeProcess.arguments = ["-p", "0",myText]
            
            writeProcess.launch()
            writeProcess.waitUntilExit()
        }
    }
    
    // This functions gets the users input and passes it to the calling function
    @objc func getString(title: String, question: String, defaultValue: String) -> String {
        let msg = NSAlert()
        msg.addButton(withTitle: "OK")      // 1st button
        msg.addButton(withTitle: "Cancel")  // 2nd button
        msg.messageText = title
        msg.informativeText = question
        
        let txt = NSTextField(frame: NSRect(x: 0, y: 0, width: 250, height: 24))
        txt.stringValue = defaultValue
        
        msg.accessoryView = txt
        let response: NSApplication.ModalResponse = msg.runModal()
        
        if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
            return txt.stringValue
        } else {
            return "Cancel"
        }
    }
    
    
    @IBAction func timerTool(_ sender: NSMenuItem) {
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
