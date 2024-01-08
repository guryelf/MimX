//
//  BackgroundColorView.swift
//  MimX
//
//  Created by Furkan Güryel on 9.01.2024.
//

import SwiftUI

struct BackgroundColorView: View {
    var selectedTool : TextEditToolEnum
    @Binding var selectedBgColor : Color
    var body: some View {
        VStack(spacing: 15){
            LazyVGrid(columns: [GridItem](repeating: GridItem(), count: selectedTool.options.count)) {
                ForEach(selectedTool.options as! [Color], id: \.self) { color in
                    Rectangle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .cornerRadius(15)
                        .padding(5)
                        .onTapGesture {
                            withAnimation {
                                self.selectedBgColor = color
                            }
                        }
                }
            }
            HStack{
                Text("Seçili Renk")
                Rectangle()
                    .fill(selectedBgColor)
                    .frame(width: 50, height: 50)
                    .cornerRadius(15)
                    .padding(5)
                ColorPicker(selection: $selectedBgColor){
                    Button {
                        selectedBgColor = .clear
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 100, height: 30)
                            .foregroundStyle(Color.gray)
                            .overlay(alignment: .center) {
                                Text("Sıfırla")
                                    .foregroundStyle(.white)
                            }
                    }
                }
                .frame(width: 150)
            }
        }
    }
}

#Preview {
    BackgroundColorView(selectedTool: TextEditToolEnum.bgColor, selectedBgColor: .constant(.black))
}
