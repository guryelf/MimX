//
//  ContentView.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vM = ContentViewModel()
    var body: some View {
        NavigationStack{
            ScrollView{
                Divider()
                if vM.index == 0 {
                    HomeView()
                        .transition(.move(edge: .leading))
                }else if vM.index == 1{
                    FavouriteView()
                        .transition(.move(edge: .trailing))
                }
            }
            .disabled(vM.isAddActive ? true : false)
            .blur(radius: vM.isAddActive ? 2 : 0)
            ContextMenuView(cM: vM)
                .frame(maxHeight: vM.isAddActive ? 60 : 0)
                .disabled(vM.isAddActive ? false : true)
                .opacity(vM.isAddActive ? 1 : 0)
            TabView(index: $vM.index, isAddActive: $vM.isAddActive)
                .navigationTitle("MimX")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            vM.isSettingsActive.toggle()
                            vM.isAddActive = false
                        }, label: {
                            Image(systemName: "gear.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        })
                    }
                    if vM.isEditActive {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                withAnimation(.spring) {
                                    vM.isEditActive = false
                                    vM.isAddActive = false
                                }
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.red)
                            })
                        }
                    }
                }
                .navigationDestination(isPresented: $vM.isSettingsActive) {
                    SettingsView()
                }
        }
    }
}

#Preview {
    ContentView()
}
