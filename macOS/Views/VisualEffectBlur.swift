//
//  VisualEffectBlur.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 07/03/2021.
//

import SwiftUI

// MARK: - VisualEffectBlur

struct VisualEffectBlur: View {
    var material: NSVisualEffectView.Material
    
    init(material: NSVisualEffectView.Material = .headerView) {
        self.material = material
    }
    
    var body: some View {
        Representable(material: material)
            .accessibility(hidden: true)
    }
}

// MARK: - Representable

extension VisualEffectBlur {
    struct Representable: NSViewRepresentable {
        var material: NSVisualEffectView.Material
        
        func makeNSView(context: Context) -> NSVisualEffectView {
            context.coordinator.visualEffectView
        }
        
        func updateNSView(_ view: NSVisualEffectView, context: Context) {
            context.coordinator.update(material: material)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
    }
    
    class Coordinator {
        let visualEffectView = NSVisualEffectView()
        
        init() {
            visualEffectView.blendingMode = .withinWindow
        }
        
        func update(material: NSVisualEffectView.Material) {
            visualEffectView.material = material
        }
    }
}

// MARK: - Previews

struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VisualEffectBlur()
                .padding()
            
            Text("Hello World!")
        }
        .frame(width: 200, height: 100)
        .previewLayout(.sizeThatFits)
    }
}

