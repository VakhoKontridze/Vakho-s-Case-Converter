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
        VStack(spacing: 10, content: {
            convert
            if settings.conversion == .title {
                firstAndLast
                principals
                specialWords
                compounds
            }
            misc
        })
            .padding(10)
            .frame(size: ViewModel.view, alignment: .top)
    }
    
    private var convert: some View {
        SectionView(content: {
            VStack(spacing: 10, content: {
                TextField("", text: self.$title)
                
                HStack(spacing: 10, content: {
                    Picker(
                        selection: self.$settings.conversion,
                        label: EmptyView(),
                        content: {
                            ForEach(Conversion.allCases, id: \.self, content: { conversion in
                                Text(conversion.title)
                            })
                        }
                    )
                        .frame(width: ViewModel.picker.width)
                    
                    Spacer()
                    
                    Button(action: {}, label: { Text("Convert") })
                        .disabled(self.title.isEmpty)
                    
                    Spacer()
                    
                    Button(action: { self.title = "" }, label: { Text("Clear") })
                        .frame(width: ViewModel.picker.width, alignment: .trailing)
                })
            })
        })
    }
    
    private var firstAndLast: some View {
        SectionView(content: {
            CheckBoxView(
                isOn: self.$settings.capitalizeFirstAndLast,
                title: "Capitalize first and last words"
            )
        })
    }
    
    private var principals: some View {
        SectionView(content: {
            HStack(spacing: 0, content: {
                CheckBoxView(
                    isOn: self.$settings.principalWord.ticked,
                    title: "Capitalize verbs, nouns, adjectives, adverbs, and pronouns of "
                )
                
                NumberPickerView(value: self.$settings.principalWord.length, range: self.settings.principalWord.range)
                    .padding(.horizontal, 5)
                    .disabled(!self.settings.principalWord.ticked)
                
                Text(" letters or more")
                    .onTapGesture(count: 1, perform: { self.settings.principalWord.ticked.toggle() })
            })
        })
    }
    
    private var specialWords: some View {
        SectionView(content: {
            VStack(alignment: .leading, spacing: 10, content: {
                HStack(spacing: 0, content: {
                    CheckBoxView(
                        isOn: self.$settings.specialWord.ticked.onChange(self.settings.syncSpecialWord),
                        title: "Do not capitalize Articles, Prepositions, and Conjunctions of "
                    )
                    
                    NumberPickerView(value: self.$settings.specialWord.length, range: self.settings.specialWord.range)
                        .padding(.horizontal, 5)
                        .disabled(!self.settings.specialWord.ticked)
                    
                    Text(" letters or less")
                        .onTapGesture(count: 1, perform: { self.settings.specialWord.ticked.toggle() })
                    
                    Spacer()
                    
                    Button(action: { WordsFactory.shared.createWindow() }, label: {
                        Text("→")
                            .padding(3)
                            .background(Circle().foregroundColor(.secondary))
                    })
                        .buttonStyle(PlainButtonStyle())
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
}

// MARK:- Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
