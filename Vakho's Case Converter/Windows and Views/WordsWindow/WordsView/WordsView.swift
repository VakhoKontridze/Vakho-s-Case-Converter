//
//  WordsView.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/13/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Words View
struct WordsView: View {}

// MARK:- Body
extension WordsView {
    var body: some View {
        Text("Hello, World!")
            .frame(width: ViewModel.window.width, height: ViewModel.window.height)
            .padding(10)
    }
}

// MARK:- Preview
struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        WordsView()
    }
}
