//
//  ContentView.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var index = 0
    var body: some View {
        Spacer()
        VStack{
            if index == 0 {
                HomeView()
                    .blur(radius: index == 2 ? 3 : 0)
            }else if index == 1{
                FavouriteView()
                    .blur(radius: index == 2 ? 3 : 0)
            }else if index == 2{
                withAnimation(.spring) {
                    HStack(spacing:30){
                        AddButton(content: {
                            Button {
                                
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
                                
                            } label: {
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("Edit")
                                    .padding(.trailing,20)
                            }
                        }, bgColor: .blue, fgColor: .white)
                    }
                    .transition(.move(edge: .bottom))
                }
            }
            TabView(index: $index)
        }
    }
}

#Preview {
    ContentView()
}
