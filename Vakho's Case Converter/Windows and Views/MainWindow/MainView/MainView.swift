//
//  MainView.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/12/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import SwiftUI

// MARK:- Main View
struct MainView: View {
    @ObservedObject private var settings: SettingsViewModel = .init()
}

// MARK:- Body
extension MainView {
    var body: some View {
        VStack(content: {
            general
        })
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
    
    private var general: some View {
        SectionView(title: "General", content: {
            CheckBoxView(isOn: self.$settings.capitalizeFirstAndLast, title: "Capitalize the first and last words")
                .padding(.bottom, 7)

            HStack(spacing: 0, content: {
                CheckBoxView(isOn: self.$settings.principalWords.capitalize, title: "Capitalize verbs, nouns, adjectives, adverbs, and pronouns of ")
                
                NumberPickerView(value: self.$settings.principalWords.length, range: self.settings.principalWords.range)
                    .padding(.horizontal, 5)
                    .disabled(!self.settings.principalWords.capitalize)
                
                Text(" letters or more")
                    .onTapGesture(count: 1, perform: { self.settings.principalWords.capitalize.toggle() })
            })
            
            HStack(spacing: 0, content: {
                CheckBoxView(isOn: self.$settings.specialWords.capitalize, title: "Capitalize articles, conjunctions, and pre-/post-positions of ")
                
                NumberPickerView(value: self.$settings.specialWords.length, range: self.settings.specialWords.range)
                    .padding(.horizontal, 5)
                    .disabled(!self.settings.specialWords.capitalize)
                
                Text(" letters or more")
                    .onTapGesture(count: 1, perform: { self.settings.specialWords.capitalize.toggle() })
            })
            
            CheckBoxView(isOn: self.$settings.fixSpacing, title: "Fix multiple spacing")
            
            Button(action: { WordsFactory.shared.createWindow(title: "Words") }, label: { Text("???") })
        })
    }
    
    
    
//    private var articlesConjunctionsPrePositions: some View {
//        VStack(content: {
//            SectionView(title: "Articles", content: {
//                WordsGridView(words: SpecialWords.articles, columns: 5)
//            })
//
//            SectionView(title: "Prepositions", content: {
//                WordsGridView(words: SpecialWords.Prepositions.Single.standard, columns: 5)
//            })
//        })
//    }
}

// MARK:- Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
