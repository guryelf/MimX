//
//  TabView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct TabView: View {
    @ObservedObject var vM = ContentViewModel()
    var body: some View {
        VStack{
            ContextMenuView(cM: vM)
                .frame(maxHeight: vM.isAddActive ? 60 : 0)
                .disabled(vM.isAddActive ? false : true)
                .opacity(vM.isAddActive ? 1 : 0)
            Divider()
                .overlay(.blue)
            HStack(spacing:40){
                Group{
                    //HomeView
                    Button (action:{
                        withAnimation {
                            vM.isAddActive = false
                            vM.index = 0
                        }
                    } ,label: {
                        AddIcon(icon: "house",
                                fgColor: .cyan,
                                opacity: !vM.isAddActive && vM.index == 0 ? 1 : 0)
                    })
                    .padding(.bottom,vM.index == 0 && !vM.isAddActive ? 50 : 0)
                    
                    //ADD OR EDIT
                    Button(action: {
                        withAnimation {
                            vM.isAddActive.toggle()
                        }
                    }, label: {
                        AddIcon(icon: "plus.circle.fill",
                                fgColor: .white,
                                width:40,
                                height:40,
                                opacity: 1)
                    })
                    .padding(.bottom,vM.isAddActive ? 50 : 0)
                    Button(action: {
                        withAnimation {
                            vM.isAddActive = false
                            vM.index = 1
                        }
                    }, label: {
                        AddIcon(icon: "star",
                                fgColor: .cyan,
                                opacity: !vM.isAddActive && vM.index == 1 ? 1 : 0)
                    })
                    .padding(.bottom,vM.index == 1 && !vM.isAddActive ? 50 : 0)
                }
                .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    TabView(vM: ContentViewModel())
}
