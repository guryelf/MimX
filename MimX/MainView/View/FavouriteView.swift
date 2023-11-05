//
//  FavouriteView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct FavouriteView: View {
    @ObservedObject var vM = ContentViewModel()
    var body: some View {
        VStack(spacing:30){
            Text("Favori özelliğini kullanmak için \n kayıt olmanız gerekmektedir.")
                .font(.headline)
            AddButton(content: {
                Button(action: {
                    print("kayıt")
                }, label: {
                    Text("Şimdi kayıt olun")
                })
                .frame(width: 200,height: 40)
            }, bgColor: .blue, fgColor: .white)
        }
    }
}

#Preview {
    FavouriteView(vM: ContentViewModel())
}
