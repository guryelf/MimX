//
//  SettingsViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 25.10.2023.
//

import Foundation
import SwiftUI




class SettingsViewModel : ObservableObject{
    @AppStorage("systemTheme") var systemTheme : Int = PrefScheme.allCases.first!.rawValue
    @Environment(\.colorScheme) var colorScheme
    
    
    func selectTheme() -> ColorScheme?{
        guard let theme = PrefScheme(rawValue: systemTheme) else {return nil}
        switch theme {
        case .dark:
            return .dark
        case .light:
            return .light
        default:
            return nil
        }
    }
    
    func deleteCache(){
        if let caches = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first{
            do{
                try FileManager.default.removeItem(at: caches)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
