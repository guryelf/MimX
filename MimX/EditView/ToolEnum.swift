//
//  ToolEnum.swift
//  MimX
//
//  Created by Furkan Güryel on 26.10.2023.
//

import Foundation

enum ToolEnum : Int , CaseIterable{
    case speed
    case pitch
    
    var title : String{
        switch self {
        case .speed:
            
            return "Speed"
        case .pitch:
            return "Pitch"
        }
    }
    
    var image : String{
        switch self {
        case .speed:
            return "forward.end.alt.fill"
        case .pitch:
            return "goforward"
        }
    }
    
    
}
