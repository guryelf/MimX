//
//  PreferredScheme.swift
//  MimX
//
//  Created by Furkan Güryel on 6.12.2023.
//

import Foundation
import SwiftUI

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
            
        case .dark: return "Karanlık"
        case .system:
            return "Sistem"
        case .light:
            return "Aydınlık"
        }
        
    }
}
