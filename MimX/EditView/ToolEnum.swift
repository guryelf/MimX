//
//  ToolEnum.swift
//  MimX
//
//  Created by Furkan Güryel on 26.10.2023.
//

import Foundation
import SwiftUI




enum ToolEnum : Int , CaseIterable{
    case speed
    case pitch
    case text
    
    var title : String{
        switch self {
        case .speed:
            
            return "Speed"
        case .pitch:
            return "Pitch"
        case .text:
            return "Text"
        }
    }
    
    var image : String{
        switch self {
        case .speed:
            return "forward.end.alt.fill"
        case .pitch:
            return "goforward"
        case .text:
            return "character"
        }
    }
    func toggleViewMode(vM : EditViewModel){
        switch self {
        case .speed:
            vM.isSpeed.toggle()
        case .pitch:
            vM.isPitch.toggle()
        case .text:
            vM.isText.toggle()
        }
    }
}



