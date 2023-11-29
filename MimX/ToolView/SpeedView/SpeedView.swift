//
//  SpeedView.swift
//  MimX
//
//  Created by Furkan Güryel on 29.11.2023.
//

import SwiftUI

struct SpeedView: View {
    @Binding var value : Float
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
            VStack(spacing:30){
                Text("\(value,specifier: "%.1f")x")
                    .font(.title)
                Slider(value: $value, in: 0...3,  step: 0.1) {
                    Text("Speed")
                } minimumValueLabel: {
                    Text("0.0x")
                } maximumValueLabel: {
                    Text("3.0x")
                }onEditingChanged: { value in
                    print("onEditingChanged: \(value)")
                }
            }
        .frame(height: 250)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SpeedView(value: .constant(1))
}
