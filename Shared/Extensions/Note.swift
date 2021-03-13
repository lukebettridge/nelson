//
//  Note.swift
//  Nelson
//
//  Created by Luke Bettridge on 27/02/2021.
//

import AppKit

extension Note {
    var entry: Entry? {
        sortedEntries?.first
    }
    
    var isEmpty: Bool {
        entries?.count == 0 || entry?.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0
    }
    
    var sortedEntries: [Entry]? {
        entries?.sortedArray(using: [NSSortDescriptor(keyPath: \Entry.timestamp, ascending: false)]) as? [Entry]
    }
    
    var subtitle: String? {
        Markdown.removeSyntax(from: entry?.text?.components(separatedBy: .newlines)[safe: 1])
    }
    
    var title: String? {
        Markdown.removeSyntax(from: entry?.text?.components(separatedBy: .newlines).first)
    }
    
    @discardableResult
    static func create(context: NSManagedObjectContext) -> Note {
        let note = Note(context: context)
        note.createdAt = Date()
        note.updatedAt = note.createdAt
        
        try? context.save()
        
        return note
    }
}
