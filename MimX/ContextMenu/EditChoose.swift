//
//  EditChoose.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI

struct EditChoose: View {
    @State private var columns = Array(repeating: GridItem(.fixed(100),spacing: 20), count: 3)
    @State private var editPage = false
    var body: some View {
        NavigationStack{
            LazyVGrid(columns: columns,spacing: 10, content: {
                ForEach(0...3,id: \.self){text in
                    ZStack{
                        Circle()
                            .foregroundStyle(.windowBackground)
                            .border(.blue,width: 3)
                        Image(systemName: "gear.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .onTapGesture {
                        editPage = true
                    }
                }
            })
        }
        .navigationDestination(isPresented: $editPage) {
            EditView()
        }
    }
}

#Preview {
    EditChoose()
}
