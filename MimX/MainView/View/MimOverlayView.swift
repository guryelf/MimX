//
//  MimOverlayView.swift
//  MimX
//
//  Created by Furkan Güryel on 6.11.2023.
//

import SwiftUI

struct MimOverlayView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 20)
            .foregroundStyle(Color(.systemGray6).opacity(0.2))
            .overlay {
                HStack(spacing:30){
                    Button(action: {
                        print("favourite")
                    }, label: {
                        Image(systemName: "star.circle.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    })
                    Button(action: {
                        print("favourite")
                    }, label: {
                        Image(systemName: "star.circle.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    })
                }
            }
    }
}

#Preview {
    MimOverlayView()
}
