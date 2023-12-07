//
//  VolumeView.swift
//  MimX
//
//  Created by Furkan Güryel on 7.12.2023.
//

import SwiftUI

struct VolumeView: View {
    @State private var maxSliderWidth = UIScreen.main.bounds.width/2.25
    @State private var sliderWidth : CGFloat = 50
    @State private var sliderProgress : CGFloat = 0
    @State private var lastDragged : CGFloat = 0
    @Binding var volume : Float
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: maxSliderWidth,height:40)
                .foregroundStyle(Color(uiColor: .systemGray4))
            Rectangle()
                .fill(.blue)
                .frame(width:sliderWidth + 10,height: 40)
                .gesture(DragGesture()
                    .onChanged({ value in
                        sliderWidth = value.translation.width + lastDragged
                        
                        sliderWidth = sliderWidth > maxSliderWidth ? maxSliderWidth : sliderWidth
                        sliderWidth = sliderWidth >= 0 ? sliderWidth : 0
                        
                    })
                        .onEnded({ value in
                            
                            sliderWidth = sliderWidth > maxSliderWidth ? maxSliderWidth : sliderWidth
                            
                            sliderWidth = sliderWidth >= 0 ? sliderWidth : 0
                            
                            lastDragged = sliderWidth
                            
                            let progress = (sliderWidth / maxSliderWidth)*3
                            sliderProgress = progress <= 3.0 && progress >= 0 ? progress : 3
                            
                            self.volume = Float(sliderProgress)
                           
                        }))
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(alignment: .center) {
            Image(systemName: "speaker.wave.2.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    VolumeView(volume: .constant(1))
}
