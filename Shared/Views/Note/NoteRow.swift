//
//  NoteRow.swift
//  Nelson
//
//  Created by Luke Bettridge on 06/03/2021.
//

import SwiftUI

struct NoteRow: View {
    @State var relativeDate: String?
    @ObservedObject var note: Note
    
    var metrics: Metrics {
        #if os(iOS)
        return Metrics(thumbnailSize: 96, cornerRadius: 16, containerPadding: 0, textPadding: 8)
        #else
        return Metrics(thumbnailSize: 60, cornerRadius: 4, containerPadding: 8, textPadding: 0)
        #endif
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Group {
            if note.isEmpty {
                Text("Empty note")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(note.title ?? "")
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text(note.subtitle ?? "")
                            .lineLimit(2)
                        
                        Spacer(minLength: 0)
                        
                        if let updatedAt = note.updatedAt {
                            Text("Updated \(relativeDate ?? updatedAt.relative())")
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .onReceive(timer) { _ in
                                    relativeDate = updatedAt.relative()
                                }
                        }
                    }
                    .padding(.vertical, metrics.textPadding)
                    
                    Spacer(minLength: 0)
                }
            }
        }
        .font(.subheadline)
        .frame(minHeight: 75, alignment: .top)
        .padding(metrics.containerPadding)
        .accessibilityElement(children: .combine)
    }
    
    struct Metrics {
        var thumbnailSize: CGFloat
        var cornerRadius: CGFloat
        var containerPadding: CGFloat
        var textPadding: CGFloat
    }
}

//struct NoteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteRow()
//    }
//}
