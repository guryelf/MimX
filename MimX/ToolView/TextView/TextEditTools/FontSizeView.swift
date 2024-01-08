//
//  FontSizeView.swift
//  MimX
//
//  Created by Furkan Güryel on 9.01.2024.
//

import SwiftUI

struct FontSizeView: View {
    var selectedTool : TextEditToolEnum
    @Binding var fontSize : Int
    @Binding var customFontSize : String
    var body: some View {
        HStack(spacing: 50){
            Picker("Font Size", selection: $fontSize) {
                ForEach(selectedTool.options as! [Int], id: \.self) { size in
                    Text("\(size)")
                        .tag(size)
                }
            }
            
            TextField("Özel", text: $customFontSize)
                .frame(height: 30)
                .keyboardType(.numberPad)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .pickerStyle(InlinePickerStyle())
    }
}

#Preview {
    FontSizeView(selectedTool: TextEditToolEnum.fontSize, fontSize: .constant(0), customFontSize: .constant(""))
}
