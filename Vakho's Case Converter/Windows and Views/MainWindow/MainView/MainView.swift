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
    
    @State private var title: String = ""
}

// MARK:- Body
extension MainView {
    var body: some View {
        VStack(content: {
            general
            principals
            specialWords
            compounds
            misc
            convert
        })
            .padding(10)
            .frame(size: ViewModel.view, alignment: .top)
    }
    
    private var general: some View {
        SectionView(content: {
            CheckBoxView(
                isOn: self.$settings.capitalizeFirstAndLast,
                title: "Capitalize first and last words"
            )
                .padding(.bottom, 7)
        })
    }
    
    private var principals: some View {
        SectionView(content: {
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
        })
    }
    
    private var specialWords: some View {
        SectionView(content: {
            VStack(alignment: .leading, spacing: 10, content: {
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
        })
    }
    
    private var compounds: some View {
        SectionView(content: {
            CheckBoxView(
                isOn: self.$settings.capitalizeDelimeteredCompounds,
                title: "Capitalize both words of delimetered compounds",
                details: Delimiters.allDelimiters
            )

            CheckBoxView(
                isOn: self.$settings.capitalizeHyphenatedCompounds,
                title: "Capitalize both words of hypenated compounds"
            )
        })
    }
    
    private var misc: some View {
        SectionView(content: {
            CheckBoxView(
                isOn: self.$settings.fixSpacing,
                title: "Fix multiple spacing"
            )
        })
    }
    
    private var convert: some View {
        SectionView(content: {
            HStack(spacing: 20, content: {
                TextField("", text: self.$title)
                
                Button(action: {}, label: { Text("Convert") })
                    .disabled(self.title.isEmpty)
            })
        })
    }
}

// MARK:- Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
