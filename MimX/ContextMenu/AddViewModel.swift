//
//  AddView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//
import Foundation
import SwiftUI
import PhotosUI

class AddViewModel{
    @Published var picker : PhotosPickerItem?{
        didSet { Task{try await loadPhoto()}}
    }
    @Published var image : UIImage?
    
    func loadPhoto() async throws{
        
    }
    
    
}
