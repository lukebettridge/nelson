//
//  ApplyStylesToRange.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 24/02/2021.
//

import AppKit

extension MarkdownViewTextStorage {
    func applyStylesToRange(_ range: NSRange) {
        // Regular
        Markdown.Regular.patterns.forEach {
            if let regex = try? NSRegularExpression(pattern: $0) {
                regex.enumerateMatches(in: string, range: range) { result, flags, stop in
                    if let matchRange = result?.range(at: Markdown.Regular.fullMatchGroup) {
                        setAttributes(Markdown.Regular.attributes, range: matchRange)
                    }
                }
            }
        }
        // Bold
        Markdown.Bold.patterns.forEach {
            if let regex = try? NSRegularExpression(pattern: $0) {
                regex.enumerateMatches(in: string, range: range) { result, flags, stop in
                    if let matchRange = result?.range(at: Markdown.Bold.fullMatchGroup) {
                        if let currentFont = attribute(.font, at: matchRange.location, effectiveRange: nil) as? NSFont,
                           let font = Markdown.Bold.attributes[.font] as? NSFont {
                            addAttributes([
                                .font: NSFont(
                                    descriptor: currentFont.fontDescriptor.addingAttributes(font.fontDescriptor.fontAttributes),
                                    size: 0
                                ) as Any
                            ], range: matchRange)
                        } else {
                            addAttributes(Markdown.Bold.attributes, range: matchRange)
                        }
                    }

                    Markdown.Bold.syntaxMatchGroups?.forEach {
                        if let syntaxRange = result?.range(at: $0) {
                            addAttributes(Markdown.Bold.syntaxAttributes ?? [:], range: syntaxRange)
                        }
                    }
                }
            }
        }
        // Italic
        Markdown.Italic.patterns.forEach {
            if let regex = try? NSRegularExpression(pattern: $0) {
                regex.enumerateMatches(in: string, range: range) { result, flags, stop in
                    if let matchRange = result?.range(at: Markdown.Italic.fullMatchGroup) {
                        if let currentFont = attribute(.font, at: matchRange.location, effectiveRange: nil) as? NSFont,
                           let font = Markdown.Italic.attributes[.font] as? NSFont {
                            addAttributes([
                                .font: NSFont(
                                    descriptor: currentFont.fontDescriptor.addingAttributes(font.fontDescriptor.fontAttributes),
                                    size: 0
                                ) as Any
                            ], range: matchRange)
                        } else {
                            addAttributes(Markdown.Italic.attributes, range: matchRange)
                        }
                    }

                    Markdown.Italic.syntaxMatchGroups?.forEach {
                        if let syntaxRange = result?.range(at: $0) {
                            addAttributes(Markdown.Italic.syntaxAttributes ?? [:], range: syntaxRange)
                        }
                    }
                }
            }
        }
        // Heading 1
        Markdown.Heading1.patterns.forEach {
            if let regex = try? NSRegularExpression(pattern: $0) {
                regex.enumerateMatches(in: string, range: range) { result, flags, stop in
                    if let matchRange = result?.range(at: Markdown.Heading1.fullMatchGroup) {
                        setAttributes(Markdown.Heading1.attributes, range: matchRange)
                    }

                    Markdown.Heading1.syntaxMatchGroups?.forEach {
                        if let syntaxRange = result?.range(at: $0) {
                            addAttributes(Markdown.Heading1.syntaxAttributes ?? [:], range: syntaxRange)
                        }
                    }
                }
            }
        }
        // Heading 2
        Markdown.Heading2.patterns.forEach {
            if let regex = try? NSRegularExpression(pattern: $0) {
                regex.enumerateMatches(in: string, range: range) { result, flags, stop in
                    if let matchRange = result?.range(at: Markdown.Heading2.fullMatchGroup) {
                        setAttributes(Markdown.Heading2.attributes, range: matchRange)
                    }

                    Markdown.Heading2.syntaxMatchGroups?.forEach {
                        if let syntaxRange = result?.range(at: $0) {
                            addAttributes(Markdown.Heading2.syntaxAttributes ?? [:], range: syntaxRange)
                        }
                    }
                }
            }
        }
        // Heading 3
        Markdown.Heading3.patterns.forEach {
            if let regex = try? NSRegularExpression(pattern: $0) {
                regex.enumerateMatches(in: string, range: range) { result, flags, stop in
                    if let matchRange = result?.range(at: Markdown.Heading3.fullMatchGroup) {
                        setAttributes(Markdown.Heading3.attributes, range: matchRange)
                    }

                    Markdown.Heading3.syntaxMatchGroups?.forEach {
                        if let syntaxRange = result?.range(at: $0) {
                            addAttributes(Markdown.Heading3.syntaxAttributes ?? [:], range: syntaxRange)
                        }
                    }
                }
            }
        }
        // Code
        Markdown.Code.patterns.forEach {
            if let regex = try? NSRegularExpression(pattern: $0) {
                regex.enumerateMatches(in: string, range: range) { result, flags, stop in
                    if let matchRange = result?.range(at: Markdown.Code.fullMatchGroup) {
                        setAttributes(Markdown.Code.attributes, range: matchRange)
                    }

                    Markdown.Code.syntaxMatchGroups?.forEach {
                        if let syntaxRange = result?.range(at: $0) {
                            addAttributes(Markdown.Code.syntaxAttributes ?? [:], range: syntaxRange)
                        }
                    }
                }
            }
        }
    }
}
