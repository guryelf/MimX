//
//  TextBox.swift
//  MimX
//
//  Created by Furkan Güryel on 5.01.2024.
//

import Foundation
import SwiftUI

struct TextBox: Identifiable,Hashable{
    
    var id: UUID = UUID()
    var text: String = ""
    var fontSize: CGFloat = 20
    var bgColor: Color = .white
    var fontColor: Color = .black
    var timeRange: ClosedRange<Double> = 0...3
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    
    static func == (lhs: TextBox, rhs: TextBox) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }

}
