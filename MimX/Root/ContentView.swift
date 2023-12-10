//
//  ContentView.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var vM = ContentViewModel()
    @EnvironmentObject var sVM : SettingsViewModel
    @State private var isLoading = false
    var body: some View {
        NavigationStack{
            ScrollView{
                Divider()
                ZStack(alignment:.center){
                    if vM.index == 0 {
                        HomeView()
                            .environmentObject(vM)
                            .transition(.move(edge: .leading))
                    }else if vM.index == 1{
                        FavouriteView()
                            .environmentObject(vM)
                            .transition(.move(edge: .trailing))
                    }
                    AnimatedImage(name: "Loading.gif", isAnimating: .constant(true))
                        .resizable()
                        .frame(width: vM.isLoading ? 200 : 0, height:  vM.isLoading ? 200 : 0)
                }
            }
            .shadow(radius: vM.isLoading ? 100 : 0)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    vM.isVolume = false
                }
            }
            .overlay(alignment: .top, content: {
                VolumeView(volume: $vM.volume)
                    .frame(height: vM.isVolume ? 40 : 0)
                    .opacity(vM.isVolume ? 1 : 0.15)
                    .onTapGesture(count:2) {
                        withAnimation(.easeInOut) {
                            vM.isVolume.toggle()
                        }
                    }
            })
            .onDisappear(perform: {
                vM.selectedVideo = nil
            })
            .onChange(of: vM.index, perform: { _ in
                vM.selectedVideo = nil
            })
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
                    if vM.selectedVideo != nil {
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
        .environmentObject(SettingsViewModel())
}
