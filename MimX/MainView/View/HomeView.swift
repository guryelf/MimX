//
//  HomeView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var columns = Array(repeating: GridItem(.fixed(200)), count: 3)
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns,spacing: 20, content: {
                Text("sa")
            })
        }
    }
}

#Preview {
    HomeView()
}
