//
//  MyGoodsPostViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import Foundation
import UIKit

struct GoodsBase: Decodable {
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
    private var goodsID: String?
    var goodsCharactersID = [String]()
    
    init() {}
    
    init(baseData: GoodsBase, images: [UIImage], counts: [Count]) {
        self.baseData = baseData
        self.images = images
        self.counts = counts
    }
    
    
    func get() {
        guard let id = goodsID else { return }
        
        firebase.getGoodsCharacters(id: id) { characters in
            guard let characters = characters else { return }
            self.goodsCharactersID = characters
        }
    }
    /// チェックリスト用の配列を作成
    func makeCheckList() {
        
        checkList.removeAll()
        
        guard let title = baseData.title else { return }
        
        firebase.getCharacters(titleID: title.id) { characters in
            guard let characters = characters else { return }
            for character in characters {
                var check = false
                
                if self.selectCharacters.count == 0 {
                    for checkCharacter in self.goodsCharactersID {
                        if checkCharacter == character.id {
                            self.checkList.append(
                                CheckCharacter(character: character, isCheck: true))
                            check = true
                            continue
                        }
                    }
                } else {
                    for item in self.selectCharacters {
                        if character.id == item.id {
                            self.checkList.append(
                                CheckCharacter(character: character, isCheck: true))
                            check = true
                            continue
                        }
                    }
                }
                if check { continue }
                self.checkList.append(CheckCharacter(character))
                
            }
            print("ここ?4")
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
        road = true
        firebase.checkGoods(baseData: baseData) { goods in
            guard let goods = goods else {
                self.postNewGoods()
                return
            }
            self.goodsID = goods.id
            self.makeCheckList()
            self.get()
        }
    }
 
    func postGoodsCharacters() {
        firebase.checkGoods(baseData: baseData) { goods in
            guard let goods = goods else { return }
            
            var characters = [String]()
            for character in self.selectCharacters {
                characters.append(character.id)
            }
            
            let data = ["characters" : characters]
            self.firebase
                .addData(collectionID: "goods/" + goods.id + "/characters", data: data)
        }
    }
    
    /// グッズを登録する
    func postNewGoods() {
        guard let title = baseData.title else { return }
        guard let product = baseData.product else { return }
        var category1ID = ""
        var category2ID = ""
        if let category1 = baseData.category1 { category1ID = category1.id }
        if let category2 = baseData.category2 { category2ID = category2.id }
        
        let data = ["title" : title.id,
                    "product" : product.id,
                    "category1" : category1ID,
                    "category2" : category2ID] as [String: Any]
        firebase.addData(collectionID: "goods", data: data)
        makeCheckList()
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
        
        firebase.checkGoods(baseData: baseData) { goods in
            guard let goods = goods else { return }
            let documentID = goods.id
            
            let userID = user.uid
           
            self.storage.uploadImages(images: self.images, uid: userID, id: documentID) { urlStrings in
                var imageStrings = [String]()
                if let urlStrings = urlStrings { imageStrings = urlStrings }
                

                let data = ["title" : title.id,
                            "product" : product.id,
                            "category1" : category1ID,
                            "category2" : category2ID,
                            "images" : imageStrings] as [String: Any]
                
                let collectionID = "users/" + userID + "/myGoods"

                
                if self.goodsCharactersID.count == 0 {
                    let collectionID = "goods/" + documentID + "/characters"
                    
                    for counts in self.self.counts {
                        
                        self.firebase.setData(collectionID: collectionID,
                                              documentID: counts.character.id,
                                              data: [:])
                        
                    }
                }
                
                self.firebase.setData(collectionID: collectionID,
                                      documentID: documentID, data: data) {
                    
                    let collectionID = collectionID + "/" + documentID + "/characters"
                    
                    for count in self.counts {
                        let data = ["possesion": count.possession,
                                    "strayChild" : count.reservation.strayChild,
                                    "trading" : count.reservation.trading,
                                    "target" : count.target] as [String: Any]
                        
                        self.firebase.setData(collectionID: collectionID,
                                              documentID: count.character.id,
                                              data: data)
                    }
                    
                }
            }
        }
        
    }

}
