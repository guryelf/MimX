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
        VStack{
            if index == 0 {
                HomeView()
            }else if index == 1{
                FavouriteView()
            }
            TabView(index: $index)
            
        }
    }
}

#Preview {
    ContentView()
}
