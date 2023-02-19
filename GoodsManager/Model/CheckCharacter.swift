//
//  CheckCharacter.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/08.
//

import Foundation

/// チェックリスト用
struct CheckCharacter: Identifiable, Decodable {
    let id: String
    let character: Character
    var isChecked: Bool = false
    var name: String = ""
    
    init(_ character: Character) {
        id = character.id
        self.character = character
        if character.firstName != "" {
            name = character.firstName + " " + character.lastName
        } else {
            name = character.lastName
        }
    }
    
    init(character: Character, isCheck: Bool) {
        id = character.id
        self.character = character
        isChecked = isCheck
        if character.firstName != "" {
            name = character.firstName + " " + character.lastName
        } else {
            name = character.lastName
        }
    }
}

struct CheckTitle: Identifiable, Decodable {
    let id: String
    let title: Title
    var isChecked: Bool = false
    var name: String = ""
    
    init(_ title: Title) {
        id = title.id
        self.title = title
    }
}

struct TitleCharacters: Identifiable, Decodable {
    let id: String
    let title: String
    let shortName: String
    let characters: [Character]
}
