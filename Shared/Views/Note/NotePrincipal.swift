//
//  NotePrincipal.swift
//  Nelson
//
//  Created by Luke Bettridge on 13/03/2021.
//

import SwiftUI

struct NotePrincipal: View {
    let isPresented: Bool
    
    var body: some View {
        if isPresented {
            Text("Previewing revision")
                .padding(.vertical)
        }
    }
}

struct NotePrincipal_Previews: PreviewProvider {
    static var previews: some View {
        NotePrincipal(isPresented: true)
    }
}
