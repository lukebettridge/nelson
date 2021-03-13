//
//  KeyboardShortcut.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 24/02/2021.
//

import AppKit

extension NSMarkdownTextView {
    func keyboardShortcut(for event: NSEvent) -> Bool {
        guard let textStorage = textStorage as? MarkdownViewTextStorage else {
            return false
        }
        
        let range = selectedRange()
        let string = textStorage.string
        let selectedString = String(string[Range(range, in: string)!])
        
        let hasSelection = range.length > 0
        let withCommand = event.modifierFlags.intersection(.deviceIndependentFlagsMask) == .command
        let withinSingleLine = !selectedString.contains("\n")
        let withShift = event.modifierFlags.intersection(.deviceIndependentFlagsMask) == .shift
        
        func applyMarkdown(_ type: MarkdownType) {
            textStorage.beginEditing()
            textStorage.applyMarkdownToRange(range, type: type)
            textStorage.endEditing()
            didChangeText()
            
            undoManager?.registerUndo(withTarget: self) { target in
                target.string = string
                target.didChangeText()
                self.undoManager?.registerUndo(withTarget: self) { _ in
                    applyMarkdown(type)
                }
            }
        }
        
        switch event.keyCode {
            case 11:
                if withCommand && withinSingleLine {
                    applyMarkdown(.bold)
                    setSelectedRange(
                        NSRange(location: hasSelection ? range.location + range.length + 4 : range.location + 2, length: 0)
                    )
                    return true
                }
                break
            case 15:
                if withCommand {
                    return true
                }
                break
            case 27:
                if withShift && hasSelection && withinSingleLine {
                    applyMarkdown(.italic)
                    setSelectedRange(
                        NSRange(location: hasSelection ? range.location + range.length + 2 : range.location + 1, length: 0)
                    )
                    return true
                }
                break
            case 34:
                if withCommand && withinSingleLine {
                    applyMarkdown(.italic)
                    setSelectedRange(
                        NSRange(location: hasSelection ? range.location + range.length + 2 : range.location + 1, length: 0)
                    )
                    return true
                }
                break
            case 50:
                if hasSelection && withinSingleLine {
                    applyMarkdown(.code)
                    setSelectedRange(
                        NSRange(location: range.location + range.length + 2, length: 0)
                    )
                    return true
                }
                break
            default:
                break
        }
        return false
    }
}
