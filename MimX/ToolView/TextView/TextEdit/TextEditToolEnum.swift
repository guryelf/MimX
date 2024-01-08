//
//  TextEditToolEnum.swift
//  MimX
//
//  Created by Furkan Güryel on 8.01.2024.
//

import Foundation
import SwiftUI

enum TextEditToolEnum : Int, CaseIterable{
    case fontSize
    case bgColor
    case fontColor
    
    var title : String{
        switch self {
        case .fontSize:
            return "Karakter Büyüklüğü"
        case .bgColor:
            return "Arka Plan "
        case .fontColor:
            return "Font Rengi"
        }
    }
    var image : String{
        switch self {
        case .fontSize:
            return "textformat.size"
        case .bgColor:
            return "paintbrush.pointed.fill"
        case .fontColor:
            return "paintpalette.fill"
        }
    }
   
    var options : Array<Any> {
        switch self {
        case .fontSize:
            return [5,10,15,20,25,30,35,40,45,50,55,60,65,70]
        case .bgColor:
            return [.black,.white,.pink,.blue,.red,.green] as [Color]
        case .fontColor:
            return [.black,.white,.pink,.blue,.red,.green] as [Color]
        }
    }
    

}
