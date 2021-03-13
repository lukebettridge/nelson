//
//  MarkdownView.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 19/02/2021.
//

import SwiftUI

struct MarkdownView: NSViewRepresentable {
    @EnvironmentObject var vm: NelsonModel
    @Binding var text: String
    let textDidEndEditing: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> NSMarkdownView {
        let view = NSMarkdownView(text)
        view.layoutManagerDelegate = context.coordinator
        view.textViewDelegate = context.coordinator
        return view
    }
    
    func updateNSView(_ nsView: NSMarkdownView, context: Context) {
        nsView.isEditable = !vm.isReadingView
        nsView.text = text
    }
    
}

extension MarkdownView {
    
    class Coordinator: NSObject, NSTextViewDelegate {
        let parent: MarkdownView
        
        init(_ parent: MarkdownView) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSMarkdownTextView else { return }
            textView.applyMarkdownStyles()
            parent.text = textView.string
        }
        
        func textDidEndEditing(_ notification: Notification) {
            parent.textDidEndEditing()
        }
    }
    
}
