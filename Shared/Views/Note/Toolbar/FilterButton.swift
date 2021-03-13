//
//  FilterButton.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct FilterButton: View {
    var body: some View {
        Button(action: {
        }) {
            Label("Filter", systemImage: "line.horizontal.3.decrease.circle")
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
