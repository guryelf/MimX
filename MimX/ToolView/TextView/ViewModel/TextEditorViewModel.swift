//
//  TextEditorViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 7.01.2024.
//

import Foundation

class TextEditorViewModel : ObservableObject{
    
    @Published var textBoxes : [TextBox] = []
    @Published var selectedBox : TextBox? = nil
    @Published var isSaved : Bool = false
    @Published var isNewText = false
    
    
    
}
