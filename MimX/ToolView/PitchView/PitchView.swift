//
//  PitchView.swift
//  MimX
//
//  Created by Furkan Güryel on 29.11.2023.
//

import SwiftUI

struct PitchView: View {
    @Binding var pitch : Float
    var body: some View {
        GeometryReader{proxy in
            VStack(spacing:30){
                Button {
                    pitch = 0.0
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 30)
                        .foregroundStyle(Color.gray)
                        .overlay(alignment: .center) {
                            Text("Sıfırla")
                                .foregroundStyle(.white)
                        }
                }
                Slider(value: $pitch, in: -2400...2400,  step: 100) {
                    Text("Pitch")
                }onEditingChanged: { value in
                    print("onEditingChanged: \(pitch)")
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height,alignment: .center)
        }
        .ignoresSafeArea()
        .padding(.horizontal,40)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    PitchView(pitch: .constant(0))
}
