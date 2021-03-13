//
//  NelsonModel.swift
//  Nelson
//
//  Created by Luke Bettridge on 28/02/2021.
//

import AppKit
import Combine

class NelsonModel: ObservableObject {
    @Published var isReadingView: Bool = false
    @Published var selectedNoteID: NSManagedObjectID? = nil
}
