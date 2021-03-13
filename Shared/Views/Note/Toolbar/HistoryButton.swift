//
//  ToggleVersionListButton.swift
//  Nelson
//
//  Created by Luke Bettridge on 07/03/2021.
//

import SwiftUI

struct HistoryButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isPresented.toggle()
            }
        }) {
            Label("Toggle Version List", systemImage: "clock.arrow.circlepath")
        }
    }
}

//struct HistoryButtonButton_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryButton()
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
