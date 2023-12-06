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
                Text("\(pitch,specifier: "%.1f")x")
                    .font(.title)
                Slider(value: $pitch, in: -2400...2400,  step: 100) {
                    Text("Speed")
                }onEditingChanged: { value in
                    print("onEditingChanged: \(pitch)")
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height,alignment: .center)
        }
        .ignoresSafeArea()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    PitchView(pitch: .constant(0))
}
