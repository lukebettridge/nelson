//
//  Markdown.swift
//  Nelson
//
//  Created by Luke Bettridge on 23/02/2021.
//

import AppKit

class Markdown {
    static var defaultAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: NSColor.textColor
    ]
    
    static func removeSyntax(from string: String?) -> String? {
        if var string = string {
            let styles: [MarkdownStyle.Type] = [Bold.self, Code.self, Heading1.self, Heading2.self, Heading3.self, Italic.self]
            styles.forEach { style in
                style.patterns.forEach { pattern in
                    var charactersRemoved = 0
                    if let regex = try? NSRegularExpression(pattern: pattern) {
                        let matches = regex.matches(in: string, range: NSMakeRange(0, string.count))
                        style.syntaxMatchGroups?.forEach { group in
                            string = matches.reduce(into: string) { current, result in
                                var nsRange = result.range(at: group)
                                nsRange = NSMakeRange(nsRange.location - charactersRemoved, nsRange.length)
                                if let range = Range(nsRange, in: current) {
                                    current.removeSubrange(range)
                                    charactersRemoved += nsRange.length
                                }
                            }
                        }
                    }
                }
            }
            return string
        }
        return nil
    }
    
    static func textSize(of style: NSFont.TextStyle) -> CGFloat {
        (style == .body ? 1.1 : 1.4) * CGFloat((NSFontDescriptor
            .preferredFontDescriptor(forTextStyle: style)
            .fontAttributes[.size] as! NSNumber).floatValue)
    }
}
