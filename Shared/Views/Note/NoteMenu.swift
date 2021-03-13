//
//  NoteMenu.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct NoteMenu: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.updatedAt, ascending: false)],
        animation: .default
    ) var notes: FetchedResults<Note>
    
    var body: some View {
        NoteList(notes: Array(notes))
            .frame(minWidth: 275)
            .navigationTitle("All Notes")
            .toolbar {
                ToolbarItem {
                    FilterButton()
                }
            }
    }
}

//struct NoteMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteMenu()
//    }
//}
