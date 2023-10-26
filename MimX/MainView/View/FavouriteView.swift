//
//  FavouriteView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct FavouriteView: View {
    @ObservedObject var vM : ContentViewModel
    var body: some View {
        ScrollView{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    FavouriteView(vM: ContentViewModel())
}
