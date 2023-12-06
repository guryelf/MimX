//
//  SettingsView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vM = SettingsViewModel()
    @AppStorage("systemTheme")private var systemTheme : Int = PrefScheme.allCases.first!.rawValue
    @State private var volume = 0.0
    var body: some View {
        List{
            Section("Tema") {
                Picker(selection: $vM.systemTheme) {
                    ForEach(PrefScheme.allCases){option in
                        HStack{
                            Image(systemName: option.Image)
                                .imageScale(.large)
                                .foregroundStyle(.blue)
                            Text(option.title)
                        }
                        .tag(option.rawValue)
                    }
                }
                label: {
                    HStack{
                        Image(systemName: "lightbulb.2.fill")
                            .foregroundStyle(.yellow)
                            .clipShape(Circle())
                            .imageScale(.large)
                        Text("Tema")
                    }
                }
            }
            Section("Oynatıcı") {
                
            }
        }
        .font(.footnote)
    }
}

#Preview {
    SettingsView()
}
