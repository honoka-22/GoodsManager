//
//  MyGoodsPostViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import Foundation
import UIKit

struct GoodsBase {
    var title: Title?
    var product: Product?
    var category1: Category?
    var category2: Category?
}

class MyGoodsPostViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    private let storage = FirebaseStorageFunction()
    
    @Published var baseData = GoodsBase()

    /// 画像
    @Published var images = [UIImage]()
    /// 個数
    @Published var counts = [Count]()
    @Published var countIndex = 0
    
    @Published var road = false
    ///  キャラクター
    @Published var checkList = [CheckCharacter]()
    @Published var selectCharacters = [Character]()
    
    /// チェックリスト用の配列を作成
    func makeCheckList() {
        road = true
        checkList.removeAll()
        guard let title = baseData.title else { return }
        firebase.getCharacters(titleID: title.id) { characters in
            if 0 < self.selectCharacters.count {
                for character in characters {
                    var check = false
                    for item in self.selectCharacters {
                        if character.id == item.id {
                            self.checkList.append(
                                CheckCharacter(character: character, isCheck: true))
                            check = true
                            continue
                        }
                    }
                    if check { continue }
                    self.checkList.append(CheckCharacter(character))
                    
                }
            } else {
                for character in characters {
                    self.checkList.append(CheckCharacter(character))
                }
            }
            self.road = false
        }
    }
    
    /// 選択された項目を取得
    func getCheckItem() {
        selectCharacters.removeAll()
        for character in checkList {
            if !character.isChecked { continue }
            selectCharacters.append(character.character)
        }
    }

    func checkGoods() {
        firebase.checkGoods(baseData: baseData) { goodsID in
            guard let goodsID = goodsID else { return }
            if goodsID.count == 0 {
                self.postNewGoods()
            }
        }
    }
    
    func postGoodsCharacters() {
        firebase.checkGoods(baseData: baseData) { goodsID in
            guard let goodsID = goodsID else { return }
            
            var characters = [String]()
            for character in self.selectCharacters {
                characters.append(character.id)
            }
            
            let data = ["characters" : characters]
            self.firebase
                .addData(collectionID: "goods/" + goodsID[0] + "/characters", data: data)
        }
    }
    
    /// グッズを登録する
    func postNewGoods() {
        guard let title = baseData.title else { return }
        guard let product = baseData.product else { return }
        
        var category1ID = ""
        var category2ID = ""
        if let category1 = baseData.category1 { category1ID = category1.id}
        if let category2 = baseData.category2 { category2ID = category2.id}

        
        let data = ["title" : title.id,
                    "product" : product.id,
                    "category1" : category1ID,
                    "category2" : category2ID] as [String: Any]
        
        firebase.addData(collectionID: "goods", data: data)
        
    }
    
    func makeCountsList() {
        getCheckItem()
        counts.removeAll()
        for character in selectCharacters {
            counts.append(Count(character: character))
        }
    }
    
    func getCountName() -> String {
        let character = counts[countIndex].character
        let delimiter = character.firstName == "" ? "" : " "
        return character.firstName + delimiter + character.lastName
    }
    
    func saveCount(possession: Int, reservation: Int) {
        counts[countIndex].possession = possession
        counts[countIndex].reservation.strayChild = reservation
    }
    
    

    /// グッズ登録
    func postMyGoods() {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let title = baseData.title else { return }
        guard let product = baseData.product else { return }
        
        var category1ID = ""
        var category2ID = ""
        if let category1 = baseData.category1 { category1ID = category1.id}
        if let category2 = baseData.category2 { category2ID = category2.id}
        
        firebase.checkGoods(baseData: baseData) { goodsID in
            guard let goodsID = goodsID else { return }
            if goodsID.count == 0 { return }
            let documentID = goodsID[0]
            
            let userID = user.uid
            
            self.storage.uploadImages(images: self.images, uid: userID, id: documentID) { urlStrings in
                var imageStrings = [String]()
                if let urlStrings = urlStrings { imageStrings = urlStrings }
                
                print(imageStrings)
                

                let data = ["title" : title.id,
                            "product" : product.id,
                            "category1" : category1ID,
                            "category2" : category2ID,
                            "images" : imageStrings] as [String: Any]
                
                let collectionID = "users/" + userID + "/myGoods"

                self.firebase.setData(collectionID: collectionID,
                                      documentID: documentID, data: data) {
                    
                    
                    var characterCounts = [[String: Any]]()
                    for count in self.counts {
                        let data = ["character" : count.character.id,
                                    "possesion": count.possession,
                                    "strayChild" : count.reservation.strayChild,
                                    "trading" : count.reservation.trading,
                                    "target" : count.target] as [String: Any]
                        characterCounts.append(data)
                    }
                    self.firebase.addData(collectionID: collectionID + "/" + documentID + "/characters", data: characterCounts)
                }
                

                
                
            }
        }
        
    }
    
    func postMyGoods(titleID: String, productID: String, images: String) {

    }
}
