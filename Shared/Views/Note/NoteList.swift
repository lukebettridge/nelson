//
//  NoteList.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct NoteList: View {
    var notes: [Note]
    
    @State private var selection: NSManagedObjectID?
    @EnvironmentObject private var model: NelsonModel
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        ScrollViewReader { proxy in
            List(selection: $selection) {
                ForEach(notes.indices) { index in
                    NavigationLink(
                        destination: NoteView(note: notes[index]),
                        tag: notes[index].objectID,
                        selection: $selection
                    ) {
                        VStack {
                            NoteRow(note: notes[index])
                                .overlay(
                                    Divider()
                                        .offset(x: 0, y: 4)
                                        .opacity(index != notes.count - 1 ? 1 : 0),
                                    alignment: .bottom
                                )
                        }
                    }
                    .tag(notes[index].objectID)
                    .onReceive(model.$selectedNoteID) { newValue in
                        guard let noteID = newValue, let note = context.object(with: noteID) as? Note else { return }
                        proxy.scrollTo(note.objectID)
                        selection = note.objectID
                    }
                }
            }
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList(notes: [])
    }
}
