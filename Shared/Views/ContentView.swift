//
//  ContentView.swift
//  Nelson
//
//  Created by Luke Bettridge on 19/02/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: NelsonModel
    
    var body: some View {
        SidebarNavigation()
    }
}
