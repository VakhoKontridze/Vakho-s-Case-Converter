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
    
    @State private var title: String = "How to m(a)ke Text-View in Sw(i)zz - zftUI for macOS. How to make Te(xt)View in SwiftUI for ma!cOS."
}

// MARK:- Body
extension MainView {
    var body: some View {
        VStack(spacing: 10, content: {
            convert
            if settings.conversionCase == .title {
                principals
                specialWords
                delimiters
            }
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
                        selection: self.$settings.conversionCase,
                        label: EmptyView(),
                        content: {
                            ForEach(ConversionCase.allCases, id: \.self, content: { conversion in
                                Text(conversion.title)
                            })
                        }
                    )
                        .frame(width: ViewModel.picker.width)
                    
                    Spacer()
                    
                    Button(action: { self.convertCase() }, label: { Text("Convert") })
                        .disabled(self.title.isEmpty)
                    
                    Spacer()
                    
                    Button(action: { self.title = "" }, label: { Text("Clear") })
                        .frame(width: ViewModel.picker.width, alignment: .trailing)
                })
            })
        })
    }
    
    private var principals: some View {
        SectionView(content: {
            HStack(spacing: 0, content: {
                CheckBoxView(
                    isOn: self.$settings.principalWords.ticked,
                    title: "Capitalize verbs, nouns, adjectives, adverbs, and pronouns of "
                )
                
                NumberPickerView(value: self.$settings.principalWords.length, range: self.settings.principalWords.range)
                    .padding(.horizontal, 5)
                    .disabled(!self.settings.principalWords.ticked)
                
                Text(" letters or more")
                    .onTapGesture(count: 1, perform: { self.settings.principalWords.ticked.toggle() })
            })
        })
    }
    
    private var specialWords: some View {
        SectionView(content: {
            VStack(alignment: .leading, spacing: 10, content: {
                HStack(spacing: 0, content: {
                    CheckBoxView(
                        isOn: self.$settings.specialWords.ticked.onChange(self.settings.syncSpecialWord),
                        title: "Do not capitalize Articles, Prepositions, and Conjunctions of "
                    )
                    
                    NumberPickerView(value: self.$settings.specialWords.length, range: self.settings.specialWords.range)
                        .padding(.horizontal, 5)
                        .disabled(!self.settings.specialWords.ticked)
                    
                    Text(" letters or less")
                        .onTapGesture(count: 1, perform: { self.settings.specialWords.ticked.toggle() })
                    
                    Spacer()
                    
                    Button(action: { WordsWindow.shared.createWindow() }, label: {
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
                                    self.settings.specialWordsPool.contains(specialWord)
                                },
                                set: { isIncluded in
                                    switch isIncluded {
                                    case false: self.settings.specialWordsPool.remove(specialWord)
                                    case true: self.settings.specialWordsPool.insert(specialWord)
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
    
    private var delimiters: some View {
        SectionView(content: {
            CheckBoxView(
                isOn: self.$settings.capitalizeDelimetered,
                title: "Capitalize words before and after delimiters",
                details: Characters.Delimiters.list
            )
        })
    }
}

// MARK:- Convert
private extension MainView {
    func convertCase() {
        title = {
            switch settings.conversionCase {
            case .lower: return CaseConverter.toLowercase(title)
            case .upper: return CaseConverter.toUppercase(title)
            case .title: return CaseConverter.toTitleCase(title, settings: settings.asTitleCaseSettings)
            case .sentence: return CaseConverter.toSentenceCase(title)
            case .capital: return CaseConverter.toCapitalCase(title)
            case .alternate: return CaseConverter.toAlternateCase(title)
            case .toggle: return CaseConverter.toToggleCase(title)
            }
        }()
    }
}

// MARK:- View Model
extension MainView {
    struct ViewModel {
        // MARK: Properties
        static let window: CGSize = .init(width: view.width, height: view.height + titleBar.height)
        static let titleBar: CGSize = .init(width: -1, height: 22)
        
        static let view: CGSize = .init(width: 670, height: 590)
        
        static let picker: CGSize = .init(width: 135, height: -1)

        // MARK: Initializers
        private init() {}
    }
}

// MARK:- Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
