//
//  MarkdownViewTextStorage.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 20/02/2021.
//

import AppKit

enum MarkdownType { case bold, code, italic }

class MarkdownViewTextStorage: NSTextStorage {
    let backingStore = NSMutableAttributedString()
    var extendedRange = NSRange()
    
    override var string: String {
      return backingStore.string
    }
    
    override func attributes(
        at location: Int,
        effectiveRange range: NSRangePointer?
    ) -> [NSAttributedString.Key: Any] {
        return backingStore.attributes(at: location, effectiveRange: range)
    }
    
    override func setAttributes(_ attrs: [NSAttributedString.Key: Any]?, range: NSRange) {
        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    override func replaceCharacters(in range: NSRange, with str: String) {
        beginEditing()
        backingStore.replaceCharacters(in: range, with:str)
        edited(.editedCharacters, range: range,
             changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    override func processEditing() {
        extendedRange = NSUnionRange(editedRange, NSString(string: backingStore.string).lineRange(for: NSMakeRange(editedRange.location, 0)))
        extendedRange = NSUnionRange(editedRange, NSString(string: backingStore.string).lineRange(for: NSMakeRange(NSMaxRange(editedRange), 0)))
        super.processEditing()
    }
    
    func applyMarkdownToRange(_ range: NSRange, type: MarkdownType) -> Void {
        let unwrappedString = String(string[Range(range, in: string)!])
        if type == .bold {
            replaceCharacters(in: range, with: "**\(unwrappedString)**")
        } else if type == .italic {
            replaceCharacters(in: range, with: "_\(unwrappedString)_")
        } else if type == .code {
            replaceCharacters(in: range, with: "`\(unwrappedString)`")
        } else { return }
    }
}
