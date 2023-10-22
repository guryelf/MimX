//
//  ContextMenuView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI

struct ContextMenuView: View {
    @Binding var isAddActive : Bool
    @State private var isEditTrue = false
    @State private var isAddTrue = false
    var body: some View {
        HStack(spacing:30){
            AddButton(content: {
                Button {
                    isAddTrue.toggle()
                    isAddActive = false
                } label: {
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
            EditView()
        }
        .navigationDestination(isPresented: $isAddTrue) {
            AddView()
        }
    }
}

#Preview {
    ContextMenuView(isAddActive: .constant(true))
}
