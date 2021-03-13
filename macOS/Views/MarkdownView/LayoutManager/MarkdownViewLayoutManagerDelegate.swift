//
//  MarkdownViewLayoutManagerDelegate.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 20/02/2021.
//

import AppKit

extension MarkdownView.Coordinator: NSLayoutManagerDelegate {
    func layoutManager(_ layoutManager: NSLayoutManager, shouldGenerateGlyphs glyphs: UnsafePointer<CGGlyph>, properties props: UnsafePointer<NSLayoutManager.GlyphProperty>, characterIndexes charIndexes: UnsafePointer<Int>, font aFont: NSFont, forGlyphRange glyphRange: NSRange) -> Int {
        if !(layoutManager.firstTextView?.isEditable ?? true) {
            guard let textStorage = layoutManager.textStorage else {
                fatalError("No textStorage was associated to this layoutManager")
            }
            
            var mutableProperties: UnsafeMutablePointer<NSLayoutManager.GlyphProperty>? = nil
            for i in 0 ..< glyphRange.length {
                if let attribute = textStorage.attribute(.displayType, at: charIndexes[i], effectiveRange: nil) as? DisplayType, attribute == .excluded {
                    if mutableProperties == nil {
                        mutableProperties = .allocate(capacity: glyphRange.length)
                    }
                    mutableProperties?[i].insert(.null)
                }
            }
                
            if let mutableProperties = mutableProperties {
                layoutManager.setGlyphs(glyphs, properties: mutableProperties, characterIndexes: charIndexes, font: aFont, forGlyphRange: glyphRange)

                mutableProperties.deinitialize(count: glyphRange.length)
                mutableProperties.deallocate()
                return glyphRange.length
            }
        }
        return 0
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager, shouldSetLineFragmentRect lineFragmentRect: UnsafeMutablePointer<NSRect>, lineFragmentUsedRect: UnsafeMutablePointer<NSRect>, baselineOffset: UnsafeMutablePointer<CGFloat>, in textContainer: NSTextContainer, forGlyphRange glyphRange: NSRange) -> Bool {
        var rect = lineFragmentRect.pointee
        rect.size.height = rect.size.height * 1.75

        var usedRect = lineFragmentUsedRect.pointee
        usedRect.size.height = max(rect.size.height, usedRect.size.height)

        lineFragmentRect.pointee = rect
        lineFragmentUsedRect.pointee = usedRect
        baselineOffset.pointee = baselineOffset.pointee + (rect.size.height * 0.2)
        
        return true
    }
}
