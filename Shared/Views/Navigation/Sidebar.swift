//
//  Sidebar.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct Sidebar: View {
    
    enum SidebarItem {
        case notes
        case today
    }
    
    @State private var selection: SidebarItem? = .notes
    
    var body: some View {
        List(selection: $selection) {
            NavigationLink(destination: TodayView(), tag: SidebarItem.today, selection: $selection) {
                Label("Today", systemImage: "calendar")
            }
            .tag(SidebarItem.today)
            
            NavigationLink(destination: NoteMenu(), tag: SidebarItem.notes, selection: $selection) {
                Label("All Notes", systemImage: "text.book.closed")
            }
            .tag(SidebarItem.notes)
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 200, idealWidth: 250)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
            .frame(width: 300)
    }
}
