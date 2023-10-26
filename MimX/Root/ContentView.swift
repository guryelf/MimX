//
//  ContentView.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vM : ContentViewModel
    @Environment(\.colorScheme) var colorScheme
    init() {
        self._vM = ObservedObject(wrappedValue: ContentViewModel())
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                Divider()
                if vM.index == 0 {
                    HomeView(vM: vM)
                        .transition(.move(edge: .leading))
                }else if vM.index == 1{
                    FavouriteView(vM: vM)
                        .transition(.move(edge: .trailing))
                }
            }
            .disabled(vM.isAddActive ? true : false)
            .blur(radius: vM.isAddActive ? 2 : 0)
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
            .navigationDestination(isPresented: $vM.editView) {
                if vM.content != nil{
                    EditView()
                }
            }
            TabView(vM: vM)
        }
    }
}

#Preview {
    ContentView()
    
    
    
}
