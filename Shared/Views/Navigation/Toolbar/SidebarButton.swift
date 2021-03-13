//
//  SidebarButton.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct SidebarButton: View {
    var body: some View {
        Button(action: {
            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        }) {
            Label("Toggle Sidebar", systemImage: "sidebar.left")
        }
    }
}

struct SidebarButton_Previews: PreviewProvider {
    static var previews: some View {
        SidebarButton()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
