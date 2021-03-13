//
//  EnvironmentValues.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 21/02/2021.
//

import SwiftUI

struct IsEditableEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = true
}

extension EnvironmentValues {
    var isEditable: Bool {
        get { return self[IsEditableEnvironmentKey] }
        set { self[IsEditableEnvironmentKey] = newValue }
    }
}
