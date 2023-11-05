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
    
    // Video Volume to be set
    
    
    enum PrefScheme : Int,CaseIterable,Identifiable{
        var id : Self {
            return self
        }
        case system
        case dark
        case light
        
        var Image : String{
            switch self{
                
                
            case .dark: return "moon.circle.fill"
            case .system:
                return "gear"
            case .light:
                return "sun.max.fill"
            }
        }
        var ImageColor : Color{
            switch self{
                
            case .dark: return .black
            case .system:
                return .white
            case .light:
                return .yellow
            }
        }
        var title : String{
            switch self{
                
            case .dark: return "Dark Mode"
            case .system:
                return "System"
            case .light:
                return "Light Mode"
            }
            
        }
    }
    
    func selectTheme() -> ColorScheme{
        guard let theme = PrefScheme(rawValue: systemTheme) else {return colorScheme}
        
        switch theme {
        case .dark:
            return .dark
        case .light:
            return .light
        default:
            return colorScheme
        }
        
    }
    
    
}
