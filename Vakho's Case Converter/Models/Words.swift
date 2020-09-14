//
//  Words.swift
//  Vakho's Case Converter
//
//  Created by Vakhtang Kontridze on 9/13/20.
//  Copyright © 2020 Vakhtang Kontridze. All rights reserved.
//

import Foundation

// MARK:- Words
final class Words {
    // MARK: Properties
    static let shared: Words = .init()
    
    let articles: [String]
    let prepositions: Prepositions
    let conjunctions: Conjunctions
    
    // MARK: Initializers
    private init() {
        let dictionary: [String: Any] = Words.decode()

        articles = dictionary["Articles"] as? [String] ?? []
        prepositions = .init(from: dictionary["Prepositions"] as? [String: Any] ?? [:])
        conjunctions = .init(from: dictionary["Conjunctions"] as? [String: Any] ?? [:])
    }
}

// MARK:- Prepositions
extension Words {
    struct Prepositions {
        // MARK: Properties
        let prototypical: Prototypical
        let intransitive: Intransitive
        let postpositions: Postpositions
        let complex: Complex
        
        // MARK: Initializers
        init(from dictionary: [String: Any]) {
            prototypical = .init(from: dictionary["Prototypical"] as? [String: Any] ?? [:])
            intransitive = .init(from: dictionary["Intransitive"] as? [String: Any] ?? [:])
            postpositions = .init(from: dictionary["Postpositions"] as? [String: Any] ?? [:])
            complex = .init(from: dictionary["Complex"] as? [String: Any] ?? [:])
        }
    }
}

extension Words.Prepositions {
    // MARK:- Prototypical Prepositions
    struct Prototypical {
        // MARK: Properties
        let standard: [String]
        let alternative: [String]
        let contextual: StandardAndAlt
        
        // MARK: Initializers
        init(from dictionary: [String: Any]) {
            standard = dictionary["Standard"] as? [String] ?? []
            alternative = dictionary["Alternative"] as? [String] ?? []
            contextual = .init(from: dictionary["Contextual"] as? [String: Any] ?? [:])
        }
    }
    
    // MARK:- Intransitive Prepositions
    struct Intransitive {
        // MARK: Proprties
        let standard: [String]
        let alternative: [String]
        let contextual: StandardAndAlt
        
        // MARK: Initializers
        init(from dictionary: [String: Any]) {
            standard = dictionary["Standard"] as? [String] ?? []
            alternative = dictionary["Alternative"] as? [String] ?? []
            contextual = .init(from: dictionary["Contextual"] as? [String: Any] ?? [:])
        }
    }
    
    // MARK:- Postpositions Prepositions
    struct Postpositions {
        // MARK: Proprties
        let standard: [String]
        let alternative: [String]
        let contextual: [String]
        
        // MARK: Initializers
        init(from dictionary: [String: Any]) {
            standard = dictionary["Standard"] as? [String] ?? []
            alternative = dictionary["Alternative"] as? [String] ?? []
            contextual = dictionary["Contextual"] as? [String] ?? []
        }
    }
    
    // MARK:- Complex Prepositions
    struct Complex {
        // MARK: Properties
        let prepositionPreposition: StandardAndAlt
        let prepositionNounPreposition: [String]
        let prepositionArticleNounPreposition: [String]
        let misc: [String]
        
        // MARK: Initializers
        init(from dictionary: [String: Any]) {
            prepositionPreposition = .init(from: dictionary["Preposition + Preposition"] as? [String: Any] ?? [:])
            prepositionNounPreposition = dictionary["Preposition + Noun + Preposition"] as? [String] ?? []
            prepositionArticleNounPreposition = dictionary["Preposition + Article + Noun + Preposition"] as? [String] ?? []
            misc = dictionary["Misc"] as? [String] ?? []
        }
    }
}

// MARK:- Conjunctions
extension Words {
    struct Conjunctions {
        // MARK: Properties
        let coordinating: [String]
        let subordinating: Subordinating
        
        // MARK: Initializers
        init(from dictionary: [String: Any]) {
            coordinating = dictionary["Coordinating"] as? [String] ?? []
            subordinating = .init(from: dictionary["Subordinating"] as? [String: Any] ?? [:])
        }
    }
}

extension Words.Conjunctions {
    // MARK:- Subordinating Conjunctions
    struct Subordinating {
        let one: StandardAndContextual
        let two: [String]
        let three: [String]
        
        // MARK: Initializers
        init(from dictionary: [String: Any]) {
            one = .init(from: dictionary["1"] as? [String: Any] ?? [:])
            two = dictionary["2"] as? [String] ?? []
            three = dictionary["3"] as? [String] ?? []
        }
    }
}

// MARK:- General
struct StandardAndAlt {
    // MARK: Proprties
    let standard: [String]
    let alternative: [String]
    
    // MARK: Initializers
    init(from dictionary: [String: Any]) {
        standard = dictionary["Standard"] as? [String] ?? []
        alternative = dictionary["Alternative"] as? [String] ?? []
    }
}

struct StandardAndContextual {
    // MARK: Proprties
    let standard: [String]
    let contextual: [String]
    
    // MARK: Initializers
    init(from dictionary: [String: Any]) {
        standard = dictionary["Standard"] as? [String] ?? []
        contextual = dictionary["Contextual"] as? [String] ?? []
    }
}

// MARK:- Decode
private extension Words {
    static func decode() -> [String: Any] {
        guard
            let url = Bundle.main.url(forResource: "Words", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let dictionary = json as? [String: Any]
        else {
            return [:]
        }

        return dictionary
    }
}

// MARK:- Retrieve
extension Words {
    func retriveAllWords() -> Set<String> {
        var words: Set<String> = []

        words.insert(articles)

        words.insert(prepositions.prototypical.standard)
        words.insert(prepositions.prototypical.alternative)
        words.insert(prepositions.prototypical.contextual.standard)
        words.insert(prepositions.prototypical.contextual.alternative)

        words.insert(prepositions.intransitive.standard)
        words.insert(prepositions.intransitive.alternative)
        words.insert(prepositions.intransitive.contextual.standard)
        words.insert(prepositions.intransitive.contextual.alternative)

        words.insert(prepositions.postpositions.standard)
        words.insert(prepositions.postpositions.alternative)
        words.insert(prepositions.postpositions.contextual)

        words.insert(prepositions.complex.prepositionPreposition.standard)
        words.insert(prepositions.complex.prepositionPreposition.alternative)
        words.insert(prepositions.complex.prepositionNounPreposition)
        words.insert(prepositions.complex.prepositionArticleNounPreposition)
        words.insert(prepositions.complex.misc)

        words.insert(conjunctions.coordinating)
        words.insert(conjunctions.subordinating.one.standard)
        words.insert(conjunctions.subordinating.one.contextual)
        words.insert(conjunctions.subordinating.two)
        words.insert(conjunctions.subordinating.three)

        return words
    }
}

// MARK:- Set Insert
private extension Set {
    mutating func insert(_ array: Array<Element>) {
        array.forEach { insert($0) }
    }
}
