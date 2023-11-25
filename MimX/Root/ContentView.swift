//
//  ContentView.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vM = ContentViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack{
            ScrollView{
                Divider()
                ZStack{
                    if vM.index == 0 {
                        HomeView()
                            .environmentObject(vM)
                            .transition(.move(edge: .leading))
                    }else if vM.index == 1{
                        FavouriteView()
                            .environmentObject(vM)
                            .transition(.move(edge: .trailing))
                    }
                }
                .onDisappear(perform: {
                    vM.selectedVideo = nil
                })
            }
            .onChange(of: vM.index, perform: { _ in
                withAnimation(.default) {
                    vM.selectedVideo = nil
                }
            })
            .disabled(vM.isAddActive ? true : false)
            .blur(radius: vM.isAddActive ? 2 : 0)
            .navigationTitle(vM.index == 0 ?  "MimX - Ana Sayfa" : "MimX - Favoriler")
            .navigationBarTitleDisplayMode(.inline)
            
            //MARK: TAB VIEW
            CustomTabView(vM: vM)
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
            .sheet(isPresented: $vM.editView) {
                if vM.selectedVideo != nil{
                    EditView(video: vM.selectedVideo!)
                        .presentationDetents([.fraction(0.9)])
                        .onDisappear(perform: {
                            vM.selectedVideo = nil
                            vM.isEditActive = false
                        })
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
    
    
    
}
