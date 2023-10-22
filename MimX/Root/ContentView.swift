//
//  ContentView.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isSettingsActive = false
    @State private var index = 0
    @State private var isAddActive = false
    var body: some View {
        NavigationStack{
            Divider()
            Spacer()
            VStack{
                if index == 0 {
                    HomeView()
                        .blur(radius: isAddActive == true ? 2 : 0)
                }else if index == 1{
                    FavouriteView()
                        .blur(radius: isAddActive == true ? 2 : 0)
                }
                ContextMenuView(isAddActive: $isAddActive)
                    .disabled(isAddActive == true ? false : true)
                    .opacity(isAddActive == true ? 1 : 0)
                TabView(index: $index, isAddActive: $isAddActive)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isSettingsActive.toggle()
                        isAddActive = false
                    }, label: {
                        Image(systemName: "gear.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                }
            }
            .navigationDestination(isPresented: $isSettingsActive) {
                SettingsView()
            }
            .navigationTitle("MIMX")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
