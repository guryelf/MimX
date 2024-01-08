//
//  TextEditSheetView.swift
//  MimX
//
//  Created by Furkan Güryel on 8.01.2024.
//


import Foundation
import SwiftUI

struct TextEditSheetView: View {
    @State private var selectedTool: TextEditToolEnum = .bgColor
    @ObservedObject var tVM : TextEditorViewModel
    var body: some View {
        VStack {
            HStack{
                Button {
                    withAnimation {
                        tVM.fontSize = 0
                        tVM.selectedBgColor = .clear
                        tVM.selectedFontColor = .black
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 30)
                        .foregroundStyle(Color.gray)
                        .overlay(alignment: .center) {
                            Text("Tümünü Sıfırla")
                                .foregroundStyle(.white)
                        }
                }
                Button {
                    tVM.text = ""
                    tVM.isNewText = false
                    tVM.selectedBox = nil
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 30)
                        .foregroundStyle(Color.red)
                        .overlay(alignment: .center) {
                            Text("İptal et")
                                .foregroundStyle(.white)
                        }
                }
                
            }
            ScrollView(.horizontal){
                Picker(selectedTool.title, selection: $selectedTool) {
                    ForEach(TextEditToolEnum.allCases, id: \.self) { tool in
                        Text(tool.title)
                            .tag(tool)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            switch selectedTool {
            case .fontSize:
                FontSizeView(selectedTool: selectedTool, fontSize: $tVM.fontSize, customFontSize: $tVM.customFontSize)
                    .frame(width: 200, height: 150)
            case .bgColor:
                BackgroundColorView(selectedTool: selectedTool, selectedBgColor: $tVM.selectedBgColor)
            case .fontColor:
                FontColorView(selectedTool: selectedTool, selectedColor: $tVM.selectedFontColor)
            }
            
            
        }
        .onDisappear(perform: {
            tVM.selectedBox = nil
        })
        .padding(.top,20)
    }
}

#Preview {
    TextEditSheetView(tVM: TextEditorViewModel())
}

