//
//  SettingsViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 25.10.2023.
//

import Foundation
import SwiftUI
enum ProfileOptionsViewModel : Int, CaseIterable , Identifiable{
    var id: Int{return self.rawValue}
    
    case darkMode
    
    var Image : String{
        switch self{
            
        case .darkMode: return "moon.circle.fill"
        }
    }
    var ImageColor : Color{
        switch self{
            
        case .darkMode: return .black
        }
    }
    var title : String{
        switch self{
            
        case .darkMode: return "Dark Mode"
        }
        
    }

}
