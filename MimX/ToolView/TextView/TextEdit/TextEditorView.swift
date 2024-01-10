//
//  TextEditorView.swift
//  MimX
//
//  Created by Furkan Güryel on 7.01.2024.
//

import SwiftUI

struct TextEditorView: View {
    @ObservedObject var tVM : TextEditorViewModel
    var body: some View {
        VStack{
            TextField("", text: $tVM.text)
                .font(.system(size: CGFloat(tVM.fontSize)))
                .foregroundStyle(tVM.selectedFontColor)
                .background(tVM.selectedBgColor)
                .frame(width: 150,height: 30)
                .background(RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 2))
                .overlay(alignment: .topTrailing) {
                    Button {
                        if !tVM.text.isEmpty{
                            tVM.saveChanges()
                        }
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.blue)
                    }
                    .onChange(of: tVM.customFontSize, perform: { value in
                        tVM.updateFontSize(Int(value) ?? tVM.fontSize)
                    })
                }
        }
        .offset(x: tVM.selectedBox?.offset.width ?? 0, y: tVM.selectedBox?.offset.height ?? 0)
    }
}

#Preview {
    TextEditorView(tVM: TextEditorViewModel())
}

