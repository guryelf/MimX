//
//  SpeedView.swift
//  MimX
//
//  Created by Furkan Güryel on 29.11.2023.
//

import SwiftUI

struct SpeedView: View {
    @Binding var rate : Float
    var body: some View {
        GeometryReader{proxy in
            VStack(spacing:30){
                Text("\(rate,specifier: "%.1f")x")
                    .font(.title)
                Button {
                    rate = 1.0
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 30)
                        .foregroundStyle(Color.gray)
                        .overlay(alignment: .center) {
                            Text("Reset")
                                .foregroundStyle(.white)
                        }
                }
                Slider(value: $rate, in: 0.5...3,  step: 0.1) {
                    Text("Speed")
                } minimumValueLabel: {
                    Text("0.5x")
                } maximumValueLabel: {
                    Text("3.0x")
                }onEditingChanged: { value in
                    print("onEditingChanged: \(rate)")
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height,alignment: .center)
        }
        .ignoresSafeArea()
        .background(Color(.systemGray5))
    }
}

#Preview {
    SpeedView(rate: .constant(1.0))
}
