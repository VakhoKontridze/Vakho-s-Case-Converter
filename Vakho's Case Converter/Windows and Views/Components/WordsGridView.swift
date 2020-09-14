//
//  WordsGridView.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/13/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Word Grid View
struct WordsGridView: View {
    // MARK: Properties
    private let words: [String]
    @State private var addedWords: Set<String> = []
    
    private let rows: Int
    private let width: CGFloat
    
    // MARK: Initializers
    init(words: [String], columns: Int) {
        self.rows = .init( (Double(words.count) / Double(columns)).rounded(.up) )
        self.width = {
            let container: CGFloat = MainView.ViewModel.view.width - 20
            let column: CGFloat = container / .init(columns) - .init((columns - 1) * 3)
            return column
        }()
        
        self.words = words
        self.addedWords = .init(words)
    }
}

// MARK:- Body
extension WordsGridView {
    var body: some View {
        // Row
        HStack(alignment: .top, spacing: 10, content: {
            ForEach(self.words.chunked(into: self.rows), id: \.self, content: { chunk in
                
                // Column
                VStack(spacing: 3, content: {
                    ForEach(chunk, id: \.self, content: { word in
                        
                        // Element
                        CheckBoxView(
                            isOn: .init(
                                get: {
                                    self.addedWords.contains(word)
                                },
                                set: { isIncluded in
                                    switch isIncluded {
                                    case false: self.addedWords.remove(word)
                                    case true: self.addedWords.insert(word)
                                    }
                                }
                            ),
                            title: word
                        )
                            .frame(width: self.width, alignment: .leading)
                    })
                })
            })
        })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
    }
}

// MARK: Previews
struct WordsGridView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(content: {
            WordsGridView(words: (1...10).map { "Element \($0)" }, columns: 5)
            
            WordsGridView(words: (1...9).map { "Element \($0)" }, columns: 5)
            
            WordsGridView(words: (1...3).map { "Element \($0)" }, columns: 5)
        })
            .frame(width: MainView.ViewModel.view.width)
    }
}
