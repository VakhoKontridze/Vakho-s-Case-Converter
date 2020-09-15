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
            .frame(size: ViewModel.window, alignment: .top)
            .padding(10)
    }
    
    private var general: some View {
        SectionView(title: "General", content: {
            CheckBoxView(
                isOn: self.$settings.capitalizeFirstAndLast,
                title: "Capitalize the first and last words"
            )
                .padding(.bottom, 7)

            HStack(spacing: 0, content: {
                CheckBoxView(
                    isOn: self.$settings.principalWord.capitalize,
                    title: "Capitalize verbs, nouns, adjectives, adverbs, and pronouns of "
                )
                
                NumberPickerView(value: self.$settings.principalWord.length, range: self.settings.principalWord.range)
                    .padding(.horizontal, 5)
                    .disabled(!self.settings.principalWord.capitalize)
                
                Text(" letters or more")
                    .onTapGesture(count: 1, perform: { self.settings.principalWord.capitalize.toggle() })
            })
            
            VStack(alignment: .leading, spacing: 5, content: {
                HStack(spacing: 0, content: {
                    CheckBoxView(
                        isOn: self.$settings.specialWord.capitalize.onChange(self.settings.syncSpecialWord),
                        title: "Capitalize articles, prepositions, and conjunctions of "
                    )
                    
                    NumberPickerView(value: self.$settings.specialWord.length, range: self.settings.specialWord.range)
                        .padding(.horizontal, 5)
                        .disabled(!self.settings.specialWord.capitalize)
                    
                    Text(" letters or more")
                        .onTapGesture(count: 1, perform: { self.settings.specialWord.capitalize.toggle() })
                    
                    Spacer()
                    
                    Button(action: { WordsFactory.shared.createWindow() }, label: { Text("Words") })
                })
                
                Group(content: {
                    ForEach(SpecialWord.allCases, content: { specialWord in
                        CheckBoxView(
                            isOn: Binding<Bool>(
                                get: {
                                    self.settings.specialWords.contains(specialWord)
                                },
                                set: { isIncluded in
                                    switch isIncluded {
                                    case false: self.settings.specialWords.remove(specialWord)
                                    case true: self.settings.specialWords.insert(specialWord)
                                    }
                                }
                            )
                                .onChange(self.settings.syncSpecialWords)
                            ,
                            
                            specialWord: specialWord
                        )
                    })
                })
                    .padding(.leading, 23)
            })
            
            CheckBoxView(isOn: self.$settings.fixSpacing, title: "Fix multiple spacing")
                .padding(.top, 5)
        })
    }
//    Capitalize both words of hyphenated compounds
//    Capitalize the first word after a colon or dash
}

// MARK:- Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
