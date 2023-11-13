//
//  ContextMenuView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI
import PhotosUI
import AlertKit

struct ContextMenuView: View {
    @ObservedObject var vM = AddViewModel()
    @StateObject var cM = ContentViewModel()
    var body: some View {
        HStack(spacing:30){
            AddButton(content: {
                PhotosPicker(selection: $vM.picker,matching: .videos) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Ekle")
                        .padding(.trailing,20)
                }
            }, bgColor: .blue, fgColor: .white)
            Button(action: {
                withAnimation(.spring) {
                    
                    cM.isAddActive.toggle()
                    cM.isEditActive = false
                }
            }, label: {
                Image(systemName: "multiply.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.red)
            })
            .padding(.bottom,50)
            AddButton(content: {
                Button(action: {
                    withAnimation(.spring) {
                        cM.isEditActive = true
                        cM.isAddActive = false
                    }
                }, label: {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Düzenle")
                        .padding(.trailing,20)
                })
                .frame(width: 130)
            }, bgColor: .blue, fgColor: .white)
        }
    }
}
#Preview {
    ContextMenuView(cM: ContentViewModel())
}
