//
//  iCloudButton.swift
//  Nelson
//
//  Created by Luke Bettridge on 08/03/2021.
//

import SwiftUI

struct iCloudButton: View {
    @Environment(\.managedObjectContext) var context
    
    let hasChanged: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            if hasChanged {
                action()
            }
        }) {
            
            Label("Save Note", systemImage: hasChanged ? "icloud" : "checkmark.icloud")
        }
        .disabled(!hasChanged)
    }
}

//struct iCloudButton_Previews: PreviewProvider {
//    static var previews: some View {
//        iCloudButton()
//    }
//}
