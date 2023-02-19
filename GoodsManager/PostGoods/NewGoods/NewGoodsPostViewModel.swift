//
//  NewGoodsPostViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import Foundation
import Firebase

class NewGoodsPostViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    @Published var road = false
    
    let defaultLabel = "未選択"
    
    @Published var titleLabel = "未選択"
    @Published var productLabel = "未選択"
    @Published var Category1Lagel = "未選択"
    @Published var Category2Lagel = "未選択"
    
    /// 作品名
    @Published var titles = [Title]()
    @Published var selectTitle: Title?
    /// 商品名
    @Published var products = [Product]()
    @Published var selectProduct: Product?
    /// カテゴリー１
    @Published var firstCategorys = [Category]()
    @Published var selectCategory1: Category?
    /// カテゴリー2
    @Published var secondCategorys = [Category]()
    @Published var selectCategory2: Category?
    
    ///  キャラクター
    @Published var checkList = [CheckCharacter]()
    @Published var selectCharacters = [Character]()
    @Published var jancode: String?
    @Published var price: Int?
    
    init() {
        firebase.getTitles() { titles in
            self.titles = titles
        }
    }
    
    func getProducts() {
        guard let title = selectTitle else { return }
        firebase.getProduct(titleID: title.id) { products, error in
            if let _ = error { return }
            guard let products = products else { return }
            self.products = products
        }
    }
    
    func get1stCategorys() {
        guard let product = selectProduct else { return }
        firebase.get1stCategorys(productID: product.id) { categorys, error in
            if let _ = error { return }
            guard let categorys = categorys else { return }
            self.firstCategorys = categorys
            
        }
    }
    
    func get2ndCategorys() {
        guard let product = selectProduct else { return }
        guard let category = selectCategory1 else { return }
        firebase.get2ndCategorys(productID: product.id, categoryID: category.id) { categorys, error in
            if let _ = error { return }
            guard let categorys = categorys else { return }
            self.secondCategorys = categorys
        }
    }
    
    func resetProduct() {
        productLabel = defaultLabel
        selectProduct = nil
        resetCategory1()
        firstCategorys.removeAll()
    }
    
    func resetCategory1() {
        Category1Lagel = defaultLabel
        selectCategory1 = nil
        resetCategory2()
        secondCategorys.removeAll()
    }
    
    func resetCategory2() {
        Category2Lagel = defaultLabel
        selectCategory2 = nil
    }
    
    func addProduct(name: String) {
        guard let title = selectTitle else { return }
        let data = ["name" : name,
                    "title" : title.id] as [String : Any]
        firebase.addData(collectionID: "products", data: data)
    }
    
    func add1stCategory(name: String) {
        guard let product = selectProduct else { return }
        let data = ["name" : name] as [String: Any]
        let id = "products/" + product.id + "/categorys"
        firebase.addData(collectionID: id, data: data)
    }
    
    func add2ndCategory(name: String) {
        guard let category = selectCategory1 else { return }
        let data = ["name" : name] as [String: Any]
        let id = category.id + "/categorys"
        firebase.addData(collectionID: id, data: data)
    }
    
    
    
    
    
    /// 次のページに行けるか
    func judgeSecondStep() -> Bool {
        if titleLabel == defaultLabel || productLabel == defaultLabel {
            return false
        } else if Category2Lagel != defaultLabel {
            return true
        } else if firstCategorys.count == 0 {
            return true
        } else if Category1Lagel == defaultLabel {
            return false
        } else if secondCategorys.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    // ------------------- step2 -------------------

    /// チェックリスト用の配列を作成
    func makeCheckList() {
        road = true
        checkList.removeAll()
        guard let title = selectTitle else { return }
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
    /// グッズを登録する
    func postNewGoods() {
        guard let title = selectTitle else { return }
        guard let product = selectProduct else { return }
        
        var characters = [String]()
        for character in selectCharacters {
            characters.append(character.id)
        }
        
        
        
        guard let category1 = selectCategory1 else {
            let data = ["title" : title.id,
                        "product" : product.id,
                        "characters" : characters] as [String: Any]
            
            firebase.addData(collectionID: "goods", data: data)
            return
        }
        guard let category2 = selectCategory2 else {
            let data = ["title" : title.id,
                        "product" : product.id,
                        "category1" : category1.id,
                        "characters" : characters] as [String: Any]
            
            firebase.addData(collectionID: "goods", data: data)
            return
        }
//      code: ,price: <#T##Int#>
        
        let data = ["title" : title.id,
                    "product" : product.id,
                    "category1" : category1.id,
                    "category2" : category2.id,
                    "characters" : characters] as [String: Any]
        
        firebase.addData(collectionID: "goods", data: data)
        
    }
    
}
