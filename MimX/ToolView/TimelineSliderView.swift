//
//  TimelineSliderView.swift
//  MimX
//
//  Created by Furkan Güryel on 14.11.2023.
//

import SwiftUI
import Kingfisher

struct TimelineSliderView: View {
    @State private var offset : CGSize = .zero
    @State private var position : CGSize = .zero
    var body: some View {
        GeometryReader{ proxy in
            Rectangle()
                .frame(width: UIScreen.main.bounds.width-50,height: 80)
                .foregroundStyle(Color(uiColor: .systemGray5))
                .overlay(alignment: .center){
                    HStack{
                        // left thumb
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 15)
                            .foregroundStyle(.blue)
                            .overlay {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.white)
                            }
                        
                        Spacer()
                        //right thumb
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 15)
                            .foregroundStyle(.blue)
                            .overlay {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                            }
                            .offset(x: offset.width + position.width )
                            .gesture(DragGesture()
                                .onChanged({ value in
                                    self.offset.width = value.location.x
                                })
                                    .onEnded({ newValue in
                                        self.position.width += newValue.location.x
                                        self.offset = .zero
                                    })
                            )
                        
                        
                    }
                }
        }
        .frame(width: UIScreen.main.bounds.width-50, height: 100, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}


#Preview {
    TimelineSliderView()
}

extension TimelineSliderView{
    @ViewBuilder func thumb(imageName:String) -> some View{
    }
}
