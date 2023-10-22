//
//  TabView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct TabView: View {
    @Binding var index : Int
    @Binding var isAddActive : Bool
    var body: some View {
        VStack{
            Divider()
                .overlay(.blue)
            HStack(spacing:40){
                Group{
                    //HomeView
                    Button (action:{
                        withAnimation {
                            isAddActive = false
                            self.index = 0
                        }
                    } ,label: {
                        AddIcon(icon: "house",
                                fgColor: .cyan,
                                opacity: !isAddActive && index == 0 ? 1 : 0)
                    })
                    .padding(.bottom,index == 0 && !isAddActive ? 50 : 0)
                    
                    //ADD OR EDIT
                    Button(action: {
                        withAnimation {
                            isAddActive.toggle()
                        }
                    }, label: {
                        AddIcon(icon: "plus.circle.fill",
                                fgColor: .white,
                                width:40,
                                height:40,
                                opacity: 1)
                    })
                    .padding(.bottom,isAddActive ? 50 : 0)
                    Button(action: {
                        withAnimation {
                            isAddActive = false
                            self.index = 1
                        }
                    }, label: {
                        AddIcon(icon: "star",
                                fgColor: .cyan,
                                opacity: !isAddActive && index == 1 ? 1 : 0)
                    })
                    .padding(.bottom,index == 1 && !isAddActive ? 50 : 0)
                }
                .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    TabView(index: .constant(1),isAddActive: .constant(true))
}
