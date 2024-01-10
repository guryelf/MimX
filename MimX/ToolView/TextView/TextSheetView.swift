//
//  TextSheetView.swift
//  MimX
//
//  Created by Furkan Güryel on 29.11.2023.
//

import SwiftUI

struct TextSheetView: View {
    @ObservedObject var vM : TextEditorViewModel
    var columns = Array(repeating: GridItem(.fixed(125),spacing: 0), count: 3)
    var body: some View {
        GeometryReader{proxy in
            if !vM.isNewText && vM.selectedBox == nil{
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 15) {
                        AddButton(content: {
                            Button {
                                vM.isNewText = true
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding()
                            }
                        }, bgColor: .blue, fgColor: .gray)
                        ForEach(vM.textBoxes,id: \.self) { box in
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 60, height: 60)
                                .foregroundStyle(box.bgColor)
                                .onTapGesture {
                                    vM.selectBox(box: box)
                                }
                                .overlay {
                                    Text(box.text.first?.description ?? "")
                                        .foregroundStyle(box.fontColor)
                                }
                                .overlay(alignment: .topLeading) {
                                    Button {
                                        withAnimation {
                                            vM.deleteBox(index: box)
                                        }
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundStyle(.red)
                                    }
                                    
                                }
                        }
                    }
                    .padding(.top,50)
                }
                .frame(width: proxy.size.width, height: proxy.size.height,alignment: .leading)
                
            }
            else {
                TextEditSheetView(tVM: vM)
            }
        }
        .onDisappear(perform: {
            vM.isNewText = false
        })
        .ignoresSafeArea()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

#Preview {
    TextSheetView(vM: TextEditorViewModel())
}
