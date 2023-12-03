//
//  ToolSheetView.swift
//  MimX
//
//  Created by Furkan Güryel on 29.11.2023.
//

import SwiftUI

struct ToolSheetView<Content:View>: View {
    let content : Content
    @Binding var isPresented : Bool
    init(isPresented: Binding<Bool> , @ViewBuilder content:() -> Content) {
        self.content = content()
        self._isPresented = isPresented
    }
    var body: some View {
        GeometryReader{ proxy in
            if isPresented{
                content
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .background(.white)
                    .transition(.move(edge: .bottom))
                    .overlay(alignment:.topLeading){
                        Button(action: {
                            withAnimation{
                                isPresented = false
                            }
                        }, label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color(.systemGray4))
                                .overlay(
                                    Image(systemName: "arrow.down")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                )
                        })
                    }
            }
        }
    }
}

#Preview {
    ToolSheetView(isPresented: .constant(true)) {
        SpeedView(value: .constant(1))
    }
}
