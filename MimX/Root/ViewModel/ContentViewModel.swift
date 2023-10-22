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
    
}
