//
//  TextEditorView.swift
//  MimX
//
//  Created by Furkan Güryel on 7.01.2024.
//

import SwiftUI

struct TextEditorView: View {
    @State private var text = ""
    @ObservedObject var tVM : TextEditorViewModel
    var body: some View {
        TextField("", text: $text)
            .frame(width: 150,height: 30)
            .background(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 2))
            .overlay(alignment: .topTrailing) {
                Button {
                    if !text.isEmpty{
                       
                    }
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.blue)
                }
            }
    }
}

#Preview {
    TextEditorView(tVM: TextEditorViewModel())
}

