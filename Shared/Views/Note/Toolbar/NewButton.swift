//
//  NewButton.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct NewButton: View {
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        Button(action: {
            Note.create(context: context)
        }) {
            Label("New", systemImage: "square.and.pencil")
        }
    }
}

struct NewButton_Previews: PreviewProvider {
    static var previews: some View {
        NewButton()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
