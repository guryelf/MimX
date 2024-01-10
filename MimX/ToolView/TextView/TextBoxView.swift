//
//  TextBoxVie.swift
//  MimX
//
//  Created by Furkan Güryel on 10.01.2024.
//

import SwiftUI

struct TextBoxView: View {
    var textBox : TextBox
    var body: some View {
        VStack{
            Text(textBox.text)
                .font(.system(size: textBox.fontSize))
                .foregroundStyle(textBox.fontColor)
        }
        .background(textBox.bgColor)
        .offset(x: textBox.offset.width,y: textBox.offset.height)
    }
}

#Preview {
    TextBoxView(textBox: TextBox.mockText)
}
