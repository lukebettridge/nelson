//
//  NSTextField.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 19/02/2021.
//

import SwiftUI

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
