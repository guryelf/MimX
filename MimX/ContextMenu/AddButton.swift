//
//  AddButton.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct AddButton<T:View>: View {
    let content : T
    let bgColor : Color
    let fgColor : Color
    init(@ViewBuilder content:() -> T, bgColor: Color, fgColor: Color) {
        self.content = content()
        self.bgColor = bgColor
        self.fgColor = fgColor
    }
    var body: some View {
        VStack{
            content
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(bgColor))
        .frame(width: 100, height: 50)
        .foregroundStyle(fgColor)
        .shadow(radius: 10)
        .transition(.scale)
    }
}

struct AddIcon : View{
    // Waiting Dark Mode to set up
    let pref : ColorScheme = ColorScheme.light
    let icon : String
    let fgColor : Color
    var width : CGFloat = 30
    var height : CGFloat = 30
    let opacity : Double
    init(icon: String, fgColor: Color,opacity : Double) {
        self.icon = icon
        self.fgColor = fgColor
        self.opacity = opacity
    }
    init(icon: String, fgColor: Color,width:CGFloat,height:CGFloat,opacity:Double) {
        self.icon = icon
        self.fgColor = fgColor
        self.width = width
        self.height = height
        self.opacity = opacity
    }
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .frame(width: width,height: height)
                .foregroundStyle(pref != .light ? .white : fgColor)
                .shadow(color:.blue,radius: 6)
                .opacity(opacity)
            Image(systemName: icon)
                .resizable()
                .frame(width: width,height: height)
                .foregroundStyle(.blue)
        }
        
    }
}
