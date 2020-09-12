//
//  MainView.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/12/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Main View
struct MainView: View {}

// MARK:- Body
extension MainView {
    var body: some View {
        Text("???")
            .frame(
                minWidth: ViewModel.view.width,
                idealWidth: ViewModel.view.width,
                maxWidth: ViewModel.view.width,
                
                minHeight: ViewModel.view.height,
                idealHeight: ViewModel.view.height,
                maxHeight: ViewModel.view.height,
                
                alignment: .top
            )
            .padding(10)
    }
}
