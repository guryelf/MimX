//
//  SettingsView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI

struct SettingsView: View {
    @State var darkMode = MimXApp().darkMode
    var body: some View {
        List{
            ForEach(ProfileOptionsViewModel.allCases){option in
                Toggle(isOn: $darkMode, label: {
                    HStack{
                        Image(systemName: "\(option.Image)")
                            .imageScale(.large)
                            .foregroundStyle(option.ImageColor)
                        Text(option.title)
                    }
                })
            }
        }
    }
}

#Preview {
    SettingsView()
}
