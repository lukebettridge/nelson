//
//  EntryRow.swift
//  Nelson
//
//  Created by Luke Bettridge on 07/03/2021.
//

import SwiftUI

struct EntryRow: View {
    let entry: Entry
    
    var body: some View {
        Text(entry.text ?? "")
            .frame(width: 175)
    }
}

//struct EntryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryRow()
//    }
//}
