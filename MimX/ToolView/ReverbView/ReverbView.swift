//
//  ReverbView.swift
//  MimX
//
//  Created by Furkan Güryel on 2.01.2024.
//

import SwiftUI

struct ReverbView: View {
    @Binding var reverb: Float
    var body: some View {
        GeometryReader{proxy in
            VStack(spacing:30){
                Text("%\(reverb,specifier: "%.1f")")
                    .font(.title)
                Button {
                    reverb = 0.0
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 30)
                        .foregroundStyle(Color.gray)
                        .overlay(alignment: .center) {
                            Text("Sıfırla")
                                .foregroundStyle(.white)
                        }
                }
                Slider(value: $reverb, in: 0...100,  step: 1) {
                    Text("Reverb")
                } minimumValueLabel: {
                    Text("%0")
                } maximumValueLabel: {
                    Text("%100")
                }onEditingChanged: { value in
                    print("onEditingChanged: \(reverb)")
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height,alignment: .center)
        }
        .ignoresSafeArea()
        .padding(.horizontal)
        .padding(.bottom,40)
        .background(Color(.systemGray5))
    }
}

#Preview {
    ReverbView(reverb: .constant(1.0))
}
