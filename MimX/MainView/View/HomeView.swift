//
//  HomeView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var columns = Array(repeating: GridItem(), count: 3)
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns,spacing: 10, content: {
                ForEach(0...3,id: \.self){text in
                    Text("sa")
                }
            })
        }
    }
}

#Preview {
    HomeView()
}
