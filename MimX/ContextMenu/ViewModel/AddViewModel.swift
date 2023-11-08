//
//  AddView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//
import Foundation
import SwiftUI
import PhotosUI
import CoreData

class AddViewModel : ObservableObject{
    @Published var picker : PhotosPickerItem?{
        didSet {
            Task{try await loadPhoto()}
        }
    }
    
    
    func loadPhoto() async throws{
        guard let item = picker else {return}
        guard let videoData = try await item.loadTransferable(type: Data.self) else {return}

    }
    
    
}
