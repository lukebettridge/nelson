//
//  SidebarNavigation.swift
//  Nelson
//
//  Created by Luke Bettridge on 19/02/2021.
//

import SwiftUI

struct SidebarNavigation: View {
    var body: some View {
        NavigationView {
            Sidebar()
                .toolbar {
                    #if os(macOS)
                    ToolbarItem(placement: .navigation) {
                        SidebarButton()
                    }
                    #endif
                }
            
            EmptyView()
            
            NoteEmpty()
                .foregroundColor(.secondary)
                .toolbar {
                    NewButton()
                }
        }
    }
}
