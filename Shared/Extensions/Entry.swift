//
//  Entry.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import AppKit

extension Entry {
    @discardableResult
    static func create(
        context: NSManagedObjectContext,
        text: String,
        note: Note? = nil
    ) -> Entry {
        let entry = Entry(context: context)
        entry.timestamp = Date()
        entry.text = text
        
        if let note = note {
            note.addToEntries(entry)
            note.updatedAt = entry.timestamp
            try? context.save()
        }
        return entry
    }
}
