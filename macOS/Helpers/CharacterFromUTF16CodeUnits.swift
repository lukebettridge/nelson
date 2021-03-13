//
//  CharacterFromUTF16CodeUnits.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 20/02/2021.
//

func characterFromUTF16CodeUnits(_ utf16CodeUnits: String.UTF16View, at index: Int) -> Character? {
    let codeUnitIndex = utf16CodeUnits.index(utf16CodeUnits.startIndex, offsetBy: index)
    
    if !utf16CodeUnits.indices.contains(codeUnitIndex) {
        return nil
    }
    let codeUnit = utf16CodeUnits[codeUnitIndex]

    if UTF16.isLeadSurrogate(codeUnit) {
        let nextCodeUnit = utf16CodeUnits[utf16CodeUnits.index(after: codeUnitIndex)]
        let codeUnits = [codeUnit, nextCodeUnit]
        let str = String(utf16CodeUnits: codeUnits, count: 2)
        return Character(str)
    } else if UTF16.isTrailSurrogate(codeUnit) {
        let previousCodeUnit = utf16CodeUnits[utf16CodeUnits.index(before: codeUnitIndex)]
        let codeUnits = [previousCodeUnit, codeUnit]
        let str = String(utf16CodeUnits: codeUnits, count: 2)
        return Character(str)
    } else {
        let unicodeScalar = UnicodeScalar(codeUnit)!
        return Character(unicodeScalar)
    }
}
