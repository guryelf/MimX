//
//  TextEditSheetView.swift
//  MimX
//
//  Created by Furkan Güryel on 8.01.2024.
//


import Foundation
import SwiftUI

struct TextEditSheetView: View {
    @State private var selectedTool: TextEditToolEnum = .fontSize
    @State var fontSize: CGFloat = 0
    @State var selectedColor: Color = .black
    var body: some View {
        VStack {
            Picker(selectedTool.title, selection: $selectedTool) {
                ForEach(TextEditToolEnum.allCases, id: \.self) { tool in
                    Text(tool.title)
                        .tag(tool)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            switch selectedTool {
            case .fontSize:
                Picker("Font Size", selection: $fontSize) {
                    ForEach(selectedTool.options as! [Int], id: \.self) { size in
                        Text("\(size)")
                            .tag(size)
                    }
                }
                .pickerStyle(InlinePickerStyle())
                .frame(width: 200, height: 150)
                .padding()
            case .bgColor, .fontColor:
                LazyVGrid(columns: [GridItem](repeating: GridItem(), count: selectedTool.options.count)) {
                    ForEach(selectedTool.options as! [Color], id: \.self) { color in
                        Rectangle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .cornerRadius(15)
                            .padding(5)
                            .onTapGesture {
                                self.selectedColor = color
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    TextEditSheetView()
}

