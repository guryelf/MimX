//
//  TabView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct TabView: View {
    @Binding var index : Int
    var body: some View {
        VStack{
            Divider()
                .overlay(.blue)
                .ignoresSafeArea()
                .padding(.top,20)
            
            HStack(spacing:25){
                //HomeView
                Button {
                    self.index = 0
                } label: {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .padding(.top,30)
                }
                //ADD OR EDIT
                Button(action: {
                    self.index = 2
                }, label: {
                    ZStack{
                        Circle()
                            .frame(width: 40,height: 40)
                            .foregroundStyle(.windowBackground)
                            .shadow(color:.blue,radius: 6)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .padding(.bottom,30)
                })
                Button(action: {
                    self.index = 1
                }, label: {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.top,30)
                })
            }
            .foregroundStyle(.blue)
        }
    }
}

#Preview {
    TabView(index: .constant(1))
}
