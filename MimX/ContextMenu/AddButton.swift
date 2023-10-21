//
//  AddButton.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct AddButton<Content:View>: View {
    let content : Content
    let bgColor : Color
    let fgColor : Color
    init(@ViewBuilder content:() -> Content, bgColor: Color, fgColor: Color) {
        self.content = content()
        self.bgColor = bgColor
        self.fgColor = fgColor
    }
    var body: some View {
        VStack{
            content
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(.blue))
        .frame(width: 150, height: 50)
        .foregroundStyle(.white)
        .shadow(radius: 10)
    }
}
