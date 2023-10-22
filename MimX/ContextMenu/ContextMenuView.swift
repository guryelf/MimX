//
//  ContextMenuView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI
import PhotosUI

struct ContextMenuView: View {
    @State var vM = AddViewModel()
    @Binding var isAddActive : Bool
    @State private var isEditTrue = false
    @State private var isAddTrue = false
    var body: some View {
        HStack(spacing:30){
            AddButton(content: {
                    PhotosPicker(selection: $vM.picker,matching: .videos) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Add")
                            .padding(.trailing,20)
                    }
                    
            }, bgColor: .blue, fgColor: .white)
            AddButton(content: {
                Button {
                    isEditTrue.toggle()
                    isAddActive = false
                } label: {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Edit")
                        .padding(.trailing,20)
                }
            }, bgColor: .blue, fgColor: .white)
        }
        .navigationDestination(isPresented: $isEditTrue) {
            EditChoose()
        }
    }
}

#Preview {
    ContextMenuView(isAddActive: .constant(true))
}
