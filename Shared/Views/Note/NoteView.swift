//
//  NoteView.swift
//  Nelson
//
//  Created by Luke Bettridge on 15/02/2021.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var presentingVersionOverlay = false
    
    @State private var text: String
    @ObservedObject private var note: Note
    
    init(note: Note) {
        self.note = note
        self._text = State(initialValue: note.entry?.text ?? "")
    }

    var body: some View {
        MarkdownView(text: $text) {
            Entry.create(context: context, text: text, note: note)
        }
        .overlay(
            EntryList(
                entries: note.sortedEntries,
                isPresented: $presentingVersionOverlay
            ),
            alignment: .bottom
        )
        .background(Rectangle().fill(BackgroundStyle()).ignoresSafeArea())
        .navigationTitle(note.title ?? "")
        .toolbar {
            NewButton()
            EditButton()
            Spacer(minLength: 0)
            HistoryButton(isPresented: $presentingVersionOverlay)
            iCloudButton(hasChanged: text != note.entry?.text) {
                Entry.create(context: context, text: text, note: note)
            }
        }
        .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}
