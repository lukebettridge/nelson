//
//  EntryList.swift
//  Nelson
//
//  Created by Luke Bettridge on 07/03/2021.
//

import SwiftUI

struct EntryList: View {
    let entries: [Entry]?
    @Binding var selection: NSManagedObjectID?
    @Binding var isPresented: Bool
    
    var body: some View {
        if let entries = entries, isPresented {
            VStack(spacing: 0) {
                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(entries.indices) { index in
                            if index != 0 {
                                Divider()
                            }
                            EntryRow(
                                entry: entries[index],
                                isSelected: selection == entries[index].objectID
                            )
                                .onTapGesture {
                                    selection = entries[index].objectID
                                }
                        }
                    }
                    .padding(12.5)
                }
            }
            .frame(height: 120)
            .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
            .transition(.move(edge: .bottom))
        }
    }
}

//struct EntryList_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryList()
//    }
//}
