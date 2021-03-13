//
//  NSMarkdownTextView.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 21/02/2021.
//

import AppKit
import SwiftUI

class NSMarkdownTextView: NSTextView {
    override init(frame: NSRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(viewFrameDidChange(_:)), name: NSView.frameDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInsertionPoint(in rect: NSRect, color: NSColor, turnedOn flag: Bool) {
        var rect = rect.offsetBy(dx: 0, dy: rect.size.height * 0.075)
        rect.size.height = (rect.size.height / 175) * 125
        super.drawInsertionPoint(in: rect, color: color, turnedOn: flag)
    }
    
    override func keyDown(with event: NSEvent) {
        if !keyboardShortcut(for: event) {
            super.keyDown(with: event)
        }
    }
    
    @objc func viewFrameDidChange(_ notification: Notification?) -> Void {
        if let superview = self.superview {
            self.textContainerInset.width = max(50, (superview.frame.width - 650) / 2)
        }
    }
    
    func applyMarkdownStyles() -> Void {
        if let textStorage = textStorage as? MarkdownViewTextStorage {
            textStorage.beginEditing()
            textStorage.applyStylesToRange(textStorage.extendedRange)
            textStorage.endEditing()
        }
    }
    
    func replaceLayoutManager() -> Void {
        if let textStorage = textStorage, let layoutManager = layoutManager {
            if let oldLayoutManager = textStorage.layoutManagers.first {
                textStorage.removeLayoutManager(oldLayoutManager)
            }
            textStorage.addLayoutManager(layoutManager)
        }
    }
}
