//
//  EntryRow.swift
//  Nelson
//
//  Created by Luke Bettridge on 07/03/2021.
//

import SwiftUI

struct EntryRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    let entry: Entry
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(entry.text ?? "")
        }
            .foregroundColor(isSelected ? .white : nil)
            .frame(maxHeight: .infinity)
            .frame(width: 175)
            .padding(8)
            .background(
                isSelected
                    ? Color.accentColor
                    : colorScheme == .light
                        ? Color.white
                        : Color.black
            )
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .onHover { inside in
                if inside {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
    }
}

//struct EntryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryRow()
//    }
//}
