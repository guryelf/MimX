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
    @Published var textBoxes : [TextBox] = [TextBox.mockText]
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
        self.text = selectedBox == nil ? "" : selectedBox?.text ?? ""
        self.selectedFontColor = selectedBox == nil ? .black : selectedBox!.fontColor
        self.selectedBgColor = selectedBox == nil ? .clear : selectedBox!.bgColor
        self.fontSize = Int(selectedBox == nil ? 15 : selectedBox!.fontSize)
        self.customFontSize = selectedBox == nil ? "" : selectedBox!.fontSize.description
    }
    
    func selectBox(box: TextBox) {
        self.selectedBox = box
        self.text = box.text
        self.fontSize = Int(box.fontSize)
        self.selectedBgColor = box.bgColor
        self.selectedFontColor = box.fontColor
        
    }

    func saveChanges(){
        let textBox = TextBox(id: UUID(), text: text, fontSize: CGFloat(fontSize),bgColor: selectedBgColor, fontColor: selectedFontColor)
        if selectedBox != nil{
            self.textBoxes = textBoxes.filter({ $0.id != selectedBox?.id })
        }
        self.textBoxes.append(textBox)
        discardChanges()
        self.isNewText = false
        self.selectedBox = nil
    }
    
    func deleteBox(index ofSelectedBox : TextBox){
        for (index,box) in textBoxes.enumerated(){
            if box.id == ofSelectedBox.id{
                textBoxes.remove(at: index)
            }
        }
    }
}
