//
//  SettingsView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vM = SettingsViewModel()
    @State private var eNum = SettingsViewModel.ProfileOptionsViewModel.allCases
    @State private var colorScheme : ColorScheme?
    init() {
        self.colorScheme = vM.selectTheme()
    }
    var body: some View {
        List{
            Picker(selection: $vM.systemTheme) {
                ForEach(eNum){option in
                    HStack{
                        Image(systemName: option.Image)
                            .imageScale(.large)
                            .foregroundStyle(.blue)
                        Text(option.title)
                    }
                }
            }
            label: {
                HStack{
                    Image(systemName: "lightbulb.2.fill")
                        .foregroundStyle(.yellow)
                        .clipShape(Circle())
                        .imageScale(.large)
                    Text("System Theme")
                }
            }
        }
        .font(.footnote)
    }
}

#Preview {
    SettingsView()
}
