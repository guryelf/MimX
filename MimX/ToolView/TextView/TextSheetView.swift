//
//  TextSheetView.swift
//  MimX
//
//  Created by Furkan Güryel on 29.11.2023.
//

import SwiftUI

struct TextSheetView: View {
    @ObservedObject var vM : TextEditorViewModel
    var body: some View {
        GeometryReader{proxy in
            if !vM.isNewText{
                ScrollView{
                    HStack(spacing:0){
                        AddButton(content: {
                            Button {
                                vM.isNewText.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding()
                            }
                        }, bgColor: .blue, fgColor: .gray)
                    }
                    .padding(.top,50)
                }
                .frame(width: proxy.size.width, height: proxy.size.height,alignment: .leading)
            }
            else {
                
                
            }
        }
        .ignoresSafeArea()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

#Preview {
    TextSheetView(vM: TextEditorViewModel())
}
