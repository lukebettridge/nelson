//
//  EditButton.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct EditButton: View {
    @EnvironmentObject var model: NelsonModel
    
    var body: some View {
        Button(action: {
            model.isReadingView.toggle()
        }) {
            Label("Toggle Reading View", systemImage: "text.cursor")
                .foregroundColor(!model.isReadingView ? .accentColor : nil)
        }
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        EditButton()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
