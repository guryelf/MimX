//
//  CustomTabView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI
import PhotosUI

struct CustomTabView: View {
    @ObservedObject var vM = ContentViewModel()
    @StateObject var aVM = AddViewModel()
    var body: some View {
        VStack{
            Divider()
                .overlay(.blue)
            HStack(spacing:40){
                Group{
                    //HomeView
                    Button (action:{
                        withAnimation {
                            
                            vM.index = 0
                        }
                    } ,label: {
                        AddIcon(icon: "house",
                                fgColor: .cyan,
                                opacity: vM.index == 0 ? 1 : 0)
                    })
                    //ADD OR EDIT
                    PhotosPicker(selection: $aVM.picker, matching: .not(.images), label: {
                        AddIcon(icon: "plus.circle.fill",
                                fgColor: .white,
                                width:40,
                                height:40,
                                opacity: 1)
                    })
                    .padding(.bottom,50)
                    
                    Button(action: {
                        withAnimation {
                            
                            vM.index = 1
                        }
                    }, label: {
                        AddIcon(icon: "star",
                                fgColor: .cyan,
                                opacity: vM.index == 1 ? 1 : 0)
                    })
                    
                }
                .foregroundStyle(.blue)
            }
        }
        .onChange(of: aVM.picker, perform: { _ in
            vM.changes.toggle()
        })
    }
}

#Preview {
    CustomTabView(vM: ContentViewModel())
}
