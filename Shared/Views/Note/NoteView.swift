//
//  NoteView.swift
//  Nelson
//
//  Created by Luke Bettridge on 15/02/2021.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject private var model: NelsonModel
    @Environment(\.managedObjectContext) var context
    
    @State private var presentingVersionOverlay: Bool = false
    @State private var selectedEntryID: NSManagedObjectID? = nil
    
    @State private var text: String = ""
    @ObservedObject private var note: Note
    
    init(note: Note) {
        self.note = note
        
        if let entry = note.entry {
            self._selectedEntryID = State(initialValue: entry.objectID)
            self._text = State(initialValue: entry.text ?? "")
        }
    }
    
    var isPreviewingPastEntry: Bool {
        selectedEntryID == nil || selectedEntryID != note.entry?.objectID
    }
    
    func createEntry() {
        Entry.create(context: context, text: text, note: note)
    }

    var body: some View {
        MarkdownView(text: $text, textDidEndEditing: createEntry)
            .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
            .background(Rectangle().fill(BackgroundStyle()).ignoresSafeArea())
            .overlay(
                EntryList(
                    entries: note.sortedEntries,
                    selection: $selectedEntryID,
                    isPresented: $presentingVersionOverlay
                ),
                alignment: .bottom
            )
            .overlay(
                NotePrincipal(isPresented: isPreviewingPastEntry),
                alignment: .top
            )
            .navigationTitle(note.title ?? "")
            .toolbar {
                NewButton()
                EditButton()
                Spacer(minLength: 0)
                HistoryButton(isPresented: $presentingVersionOverlay)
                iCloudButton(hasChanged: text != note.entry?.text, action: createEntry)
            }
            .onChange(of: selectedEntryID) { _ in
                model.isReadingView = isPreviewingPastEntry
            }
    }
}
