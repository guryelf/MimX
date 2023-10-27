//
//  ContentViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 23.10.2023.
//

import Foundation
import SwiftUI
import Combine

class ContentViewModel : ObservableObject{
    @Published var isEditActive = false
    @Published var isSettingsActive = false
    @Published var index = 0
    @Published var isAddActive = false
    @Published var content : Int?
    @Published var editView = false
    
    init(isEditActive: Bool = false, isSettingsActive: Bool = false, index: Int = 0, isAddActive: Bool = false, content: Int? = nil, editView: Bool = false) {
        self.isEditActive = isEditActive
        self.isSettingsActive = isSettingsActive
        self.index = index
        self.isAddActive = isAddActive
        self.content = content
        self.editView = editView
    }

}
