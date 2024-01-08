//
//  TextEditorViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 7.01.2024.
//

import Foundation
import SwiftUI

class TextEditorViewModel : ObservableObject{
    
    @Published var text : String = ""
    @Published var textBoxes : [TextBox] = []
    @Published var selectedBox : TextBox? = nil
    @Published var fontSize : Int = 15
    @Published var selectedFontColor: Color = .black
    @Published var selectedBgColor : Color = .clear
    @Published var customFontSize : String = ""
    @Published var isNewText : Bool = false
    
    
    func updateBgColor(_ color : Color){
        self.selectedBgColor = color
    }
    
    func updateFontColor(_ color : Color){
        self.selectedFontColor = color
    }
    
    func updateFontSize(_ size : Int){
        self.fontSize = size
    }
    
    func discardChanges(){
        self.text = ""
        self.selectedFontColor = .black
        self.selectedBgColor = .clear
        self.fontSize = 15
        self.customFontSize = ""
    }
    
    func saveChanges(){
        let textBox = TextBox(id: UUID(), text: text, fontSize: CGFloat(fontSize),bgColor: selectedBgColor, fontColor: selectedFontColor)
        
        
        self.textBoxes.append(textBox)
        discardChanges()
        self.isNewText = false
    }
    
    func deleteBox(index ofSelectedBox : TextBox){
        for (index,box) in textBoxes.enumerated(){
            if box.id == ofSelectedBox.id{
                textBoxes.remove(at: index)
            }
        }
    }
}
