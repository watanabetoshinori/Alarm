//
//  AppDelegate.swift
//  Alarm
//
//  Created by Watanabe Toshinori on 2021/04/08.
//  Copyright © 2021 Watanabe Toshinori. All rights reserved.
//

import Cocoa
import Combine
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!

    private var cancellables = [AnyCancellable]()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        let icon = NSImage(named: "StatusIcon")
        icon?.size = NSSize(width: 19, height: 19)

        statusItem.button?.image = icon

        initializeMenu()
    }

    // MARK: - Managing Menu

    func initializeMenu() {
        // Create custom SwiftUI view
        let contentSizeController = ContentSizeController()
        let alarmController = AlarmController()
        let view = ContentView(contentSizeController: contentSizeController,
                               alarmController: alarmController)

        let hostingView = HostingView(rootView: view)

        contentSizeController.$contentSize.sink { size in
            // Dynamically change the height of the HostingView to match the height of the ContentView
            hostingView.frame = NSRect(origin: .zero,
                                       size: CGSize(width: 240, height: size.height))
        }
        .store(in: &cancellables)

        let customViewItem = NSMenuItem()
        customViewItem.view = hostingView

        // Initialize menu items
        let menu = NSMenu()
        menu.delegate = self
        menu.addItem(customViewItem)
        statusItem.menu = menu
    }
}

// MARK: - NSMenuDelegate

extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        NotificationCenter.default.post(name: .menuWillOpenNotification, object: nil)
    }

    func menuDidClose(_ menu: NSMenu) {
        NotificationCenter.default.post(name: .menudDidCloseNotification, object: nil)
    }
}

