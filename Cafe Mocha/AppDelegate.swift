//
//  AppDelegate.swift
//  Cafe Mocha
//
//  Created by ef on 12/08/20.
//  Copyright © 2020 ef. All rights reserved.
//

import Cocoa
import SwiftUI
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBarItem: NSStatusItem!
    var player: AVAudioPlayer!
    var murmurButton: NSMenuItem!
    var lunchButton: NSMenuItem!
    var univButton: NSMenuItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "Icon")
        }
        
        constructMenu()
    }
    
    func constructMenu() {
        let menu = NSMenu()
        murmurButton = NSMenuItem(title: "Morning Murmur", action: #selector(AppDelegate.murmur(_:)), keyEquivalent: "")
        lunchButton = NSMenuItem(title: "Lunchtime Lounge", action: #selector(AppDelegate.lunch(_:)), keyEquivalent: "")
        univButton = NSMenuItem(title: "University Undertones", action: #selector(AppDelegate.univ(_:)), keyEquivalent: "")
        
        
        menu.addItem(murmurButton)
        menu.addItem(lunchButton)
        menu.addItem(univButton)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        self.statusBarItem.menu = menu
    }
    
    @objc func playSound(file:String, ext:String) -> Void {
        let url = Bundle.main.path(forResource: file, ofType: ext)!
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } catch let error {
            print("error on playback, ",error.localizedDescription)
        }
    }
    
    @IBAction func murmur(_ sender: Any) {
        playSound(file: "murmur", ext: "mp3")
        murmurButton.state = .on
        lunchButton.state = .off
        univButton.state = .off
    }
    
    @IBAction func lunch(_ sender: Any) {
        playSound(file: "lunch", ext: "mp3")
        murmurButton.state = .off
        lunchButton.state = .on
        univButton.state = .off
    }
    
    @IBAction func univ(_ sender: Any) {
        playSound(file: "univ", ext: "mp3")
        murmurButton.state = .off
        lunchButton.state = .off
        univButton.state = .on
    }
    
}

