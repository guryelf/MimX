//
//  ContentView.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vM = ContentViewModel()
    @EnvironmentObject var sVM : SettingsViewModel
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
            }
            .navigationTitle(vM.index == 0 ?  "MimX - Ana Sayfa" : "MimX - Favoriler")
            .navigationBarTitleDisplayMode(.inline)
            //MARK: TAB VIEW
            CustomTabView(vM: vM)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        vM.isSettingsActive.toggle()
                        
                    }, label: {
                        Image(systemName: "gear.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                }
            }
            //MARK: Settings View
            .navigationDestination(isPresented: $vM.isSettingsActive) {
                SettingsView()
            }
            //MARK: Edit View
            .sheet(isPresented: $vM.editView) {
                if vM.selectedVideo != nil{
                    EditView(video: vM.selectedVideo!)
                        .presentationDetents([.fraction(0.9)])
                        .onDisappear(perform: {
                            vM.selectedVideo = nil
                        })
                }
            }
        }
        .preferredColorScheme(sVM.selectTheme())
    }
}

#Preview {
    ContentView()
}
