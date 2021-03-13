//
//  MarkdownStyles.swift
//  Nelson
//
//  Created by Luke Bettridge on 28/02/2021.
//

import AppKit

protocol MarkdownStyle {
    static var attributes: [NSAttributedString.Key: Any] { get }
    static var fontTraitMask: NSFontTraitMask? { get }
    static var fullMatchGroup: Int { get }
    static var patterns: [String] { get }
    static var syntaxAttributes: [NSAttributedString.Key: Any]? { get }
    static var syntaxMatchGroups: [Int]? { get }
}

extension Markdown {
    
    struct Bold: MarkdownStyle {
        static var attributes: [NSAttributedString.Key: Any] = defaultAttributes.merging([
            .font: NSFont(
                descriptor: NSFontDescriptor.preferredFontDescriptor(forTextStyle: .body)
                    .addingAttributes([.traits: [
                        NSFontDescriptor.TraitKey.weight: NSFont.Weight.heavy
                    ]])
                    .withSize(textSize(of: .body)),
                size: 0
            ) as Any
        ], uniquingKeysWith: { (_, last) in last })
        static var fontTraitMask: NSFontTraitMask? = .boldFontMask
        static var fullMatchGroup = 0
        static var patterns = [
            "(\\*\\*)(.*?)(\\*\\*)",
            "(__)(.*?)(__)"
        ]
        static var syntaxAttributes: [NSAttributedString.Key : Any]? = [
            .displayType: DisplayType.excluded,
            .foregroundColor: NSColor.tertiaryLabelColor
        ]
        static var syntaxMatchGroups: [Int]? = [1, 3]
    }
    
    struct Code: MarkdownStyle {
        static var attributes: [NSAttributedString.Key: Any] = defaultAttributes.merging([
            .font: NSFont(
                descriptor: NSFontDescriptor(fontAttributes: [.family: "SF Mono"])
                    .withSize(textSize(of: .body)),
                size: 0
            ) as Any
        ], uniquingKeysWith: { (_, last) in last })
        static var fontTraitMask: NSFontTraitMask? = nil
        static var fullMatchGroup = 0
        static var patterns = ["(`)(?!`)((?:.*?[^`])?)(`)(?!`)"]
        static var syntaxAttributes: [NSAttributedString.Key : Any]? = [
            .displayType: DisplayType.excluded,
            .foregroundColor: NSColor.tertiaryLabelColor
        ]
        static var syntaxMatchGroups: [Int]? = [1, 3]
    }
    
    struct Heading1: MarkdownStyle {
        static var attributes: [NSAttributedString.Key: Any] = defaultAttributes.merging([
            .font: NSFont(
                descriptor: NSFontDescriptor(fontAttributes: [.family: "New York", .face: "Semibold"])
                    .withSize(textSize(of: .title1)),
                size: 0
            ) as Any
        ], uniquingKeysWith: { (_, last) in last })
        static var fontTraitMask: NSFontTraitMask? = nil
        static var fullMatchGroup = 0
        static var patterns = ["^(#\\s*)(?!#)(.*)"]
        static var syntaxAttributes: [NSAttributedString.Key : Any]? = [
            .displayType: DisplayType.excluded,
            .foregroundColor: NSColor.tertiaryLabelColor
        ]
        static var syntaxMatchGroups: [Int]? = [1]
    }
    
    struct Heading2: MarkdownStyle {
        static var attributes: [NSAttributedString.Key: Any] = defaultAttributes.merging([
            .font: NSFont(
                descriptor: NSFontDescriptor(fontAttributes: [.family: "New York", .face: "Semibold"])
                    .withSize(textSize(of: .title2)),
                size: 0
            ) as Any
        ], uniquingKeysWith: { (_, last) in last })
        static var fontTraitMask: NSFontTraitMask? = nil
        static var fullMatchGroup = 0
        static var patterns = ["^(#{2}\\s*)(?!#)(.*)"]
        static var syntaxAttributes: [NSAttributedString.Key : Any]? = [
            .displayType: DisplayType.excluded,
            .foregroundColor: NSColor.tertiaryLabelColor
        ]
        static var syntaxMatchGroups: [Int]? = [1]
    }
    
    struct Heading3: MarkdownStyle {
        static var attributes: [NSAttributedString.Key: Any] = defaultAttributes.merging([
            .font: NSFont(
                descriptor: NSFontDescriptor(fontAttributes: [.family: "New York", .face: "Regular"])
                    .withSize(textSize(of: .title3)),
                size: 0
            ) as Any
        ], uniquingKeysWith: { (_, last) in last })
        static var fontTraitMask: NSFontTraitMask? = nil
        static var fullMatchGroup = 0
        static var patterns = ["^(#{3}\\s*)(?!#)(.*)"]
        static var syntaxAttributes: [NSAttributedString.Key : Any]? = [
            .displayType: DisplayType.excluded,
            .foregroundColor: NSColor.tertiaryLabelColor
        ]
        static var syntaxMatchGroups: [Int]? = [1]
    }
    
    struct Italic: MarkdownStyle {
        static var attributes: [NSAttributedString.Key: Any] = defaultAttributes.merging([
            .font: NSFont(
                descriptor: NSFontDescriptor.preferredFontDescriptor(forTextStyle: .body)
                    .withSize(textSize(of: .body))
                    .withSymbolicTraits(.italic),
                size: 0
            ) as Any
        ], uniquingKeysWith: { (_, last) in last })
        static var fontTraitMask: NSFontTraitMask? = .italicFontMask
        static var fullMatchGroup = 0
        static var patterns = [
            "(_)(?!_)((?:.*?[^_])?)(_)(?!_)",
            "(\\*)(?!\\*)((?:.*?[^\\*])?)(\\*)(?!\\*)"
        ]
        static var syntaxAttributes: [NSAttributedString.Key : Any]? = [
            .displayType: DisplayType.excluded,
            .foregroundColor: NSColor.tertiaryLabelColor
        ]
        static var syntaxMatchGroups: [Int]? = [1, 3]
    }
    
    struct Regular: MarkdownStyle {
        static var attributes: [NSAttributedString.Key: Any] = defaultAttributes.merging([
            .font: NSFont(
                descriptor: NSFontDescriptor.preferredFontDescriptor(forTextStyle: .body)
                    .withSize(textSize(of: .body)),
                size: 0
            ) as Any
        ], uniquingKeysWith: { (_, last) in last })
        static var fontTraitMask: NSFontTraitMask? = nil
        static var fullMatchGroup = 0
        static var patterns = ["[\\s\\S]*"]
        static var syntaxAttributes: [NSAttributedString.Key : Any]? = nil
        static var syntaxMatchGroups: [Int]? = nil
    }
    
}
