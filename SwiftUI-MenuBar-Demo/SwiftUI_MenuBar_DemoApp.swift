//
//  SwiftUI_MenuBar_DemoApp.swift
//  SwiftUI-MenuBar-Demo
//
//  Created by TAISHIN MIYAMOTO on 2022/05/30.
//

import SwiftUI

@main
struct SwiftUI_MenuBar_DemoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        Settings { }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover = NSPopover()
    func applicationDidFinishLaunching(_ notification: Notification) {
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        guard let button = self.statusBarItem.button else { return }
        // アイコンの設定
        button.image = NSImage(systemSymbolName: "camera.macro", accessibilityDescription: nil)
        // アクションの設定
        button.action = #selector(menuButtonAction(sender:))
        // 右クリックの設定
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
    @objc func menuButtonAction(sender: AnyObject) {
        guard let event = NSApp.currentEvent else { return }
        if event.type == NSEvent.EventType.rightMouseUp {
            let menu = NSMenu()
            menu.addItem(
                withTitle: NSLocalizedString("ボタン1", comment: ""),
                action: #selector(button1),
                keyEquivalent: ""
            )
            menu.addItem(
                withTitle: NSLocalizedString("ボタン2", comment: ""),
                action: #selector(button2),
                keyEquivalent: ""
            )
            statusBarItem.menu = menu
            statusBarItem.button?.performClick(nil)
            statusBarItem.menu = nil
            return
        } else if event.type == NSEvent.EventType.leftMouseUp {
            guard let button = self.statusBarItem.button else { return }
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                // ポップアップを表示
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                // 他の位置をタップすると消える
                self.popover.contentViewController?.view.window?.makeKey()
            }
        }
    }

    @objc func button1() {
        print("ボタン1です")
    }

    @objc func button2() {
        print("ボタン2です")
    }

}
