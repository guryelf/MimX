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
    
    //MARK: Video Volume to be set
    
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
        VideoCacheManager.shared.videoCache.removeAllObjects()
    }
    
    
    
}
