//
//  GoodsRegistrationViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/07.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit
import SwiftUI

class GoodsRegistrationViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    private let storage = FirebaseStorageFunction()
    
    @Published var titles = [Title]()
    @Published var selectTitle: Title?
    
    /// チェックリスト用のキャラクター配列
    @Published var checkList = [CheckCharacter]()
    /// 選択されたキャラクターたち
    @Published var selectCharacters = [Character]()
    
    @Published var images = [UIImage]()
    
    init() {
        getTitles()
    }
    
    /// タイトル一覧を取得
    func getTitles() {
        firebase.getTitles() { titles in
            self.titles = titles
        }
    }
    
    /// 商品を取得
    func getProducts() {
        
    }
    
    /// チェックリスト用の配列を作成
    func makeCheckList() {
        print("実行")
        guard let title = selectTitle else { return }
        firebase.getCharacters(titleID: title.id) { characters in
            for character in characters {
                self.checkList.append(CheckCharacter(character))
            }
        }
    }
    
    /// チェックされたキャラクターを取得
    func getCheckCharacters() {
        for character in checkList {
            if !character.isChecked { continue }
            selectCharacters.append(character.character)
        }
    }
    
    /// グッズ登録
    func registrationGoods() {
        storage.uploadImages(images: images, id: "animal") { urlStrings in
            
        }
    }
    

    
}
