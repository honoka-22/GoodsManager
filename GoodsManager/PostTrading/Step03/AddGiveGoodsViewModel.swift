//
//  AddGiveGoodsViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/19.
//

import Firebase

struct GiveCharacter: Identifiable, Decodable {
    let id: String
    let name: String
    var countNum: Int = 0
}

struct GiveItem: Identifiable, Decodable {
    let id: String
    let goodsData: GoodsBase
    var characters = [GiveCharacter]()
}

class AddGiveGoodsViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    @Published var giveCharacters = [GiveCharacter]()
    
    @Published var titles = [Title]()
    @Published var products = [Product]()
    @Published var firstCategorys = [Category]()
    @Published var secondCategorys = [Category]()
    
    @Published var title = ""
    @Published var product = ""
    @Published var category1 = ""
    @Published var category2 = ""

    @Published var selectData = GoodsBase()
    @Published var newDataType = NewDataType.product
    var selectGoodsID = ""

    
    init() {
        firebase.getTitles() { titles in
            self.titles = titles
        }
    }
    
    func setTitle(title: Title) {
        if let select = selectData.title {
            if select.id == title.id {
                return
            }
        }
        selectData.title = title
        self.title = title.name
        getProducts(titleID: title.id)
        resetProduct()
    }
    
    
    func setProduct(product: Product) {
        if let select = selectData.product {
            if select.id == product.id {
                return
            }
        }
        selectData.product = product
        self.product = product.name
        get1stCategorys(productID: product.id)
        resetCategory1()
    }
    
    func setCategory1(category: Category) {
        guard let product = selectData.product else { return }
        if let select = selectData.category1 {
            if select.id == category.id {
                return
            }
        }
        selectData.category1 = category
        self.category1 = category.name
        get2ndCategorys(productID: product.id, categoryID: category.id)
        resetCategory2()
    }
    
    func setCategory2(category: Category) {
        if let select = selectData.category2 {
            if select.id == category.id {
                return
            }
        }
        self.selectData.category2 = category
        self.category2 = category.name
    }

    
    
    func getProducts(titleID: String) {
        firebase.getProducts(titleID: titleID) { products in
            guard let products = products else { return }
            self.products = products
            if self.products.count == 1 {
                self.setProduct(product: self.products[0])
            }
        }
    }
    
    func get1stCategorys(productID: String) {
        firebase.get1stCategorys(productID: productID) { categorys in
            self.firstCategorys = categorys
            if self.firstCategorys.count == 1 {
                self.setCategory1(category: self.firstCategorys[0])
            }
        }
    }
    
    func get2ndCategorys(productID: String, categoryID: String) {
        firebase.get2ndCategorys(productID: productID, categoryID: categoryID) { categorys in
            self.secondCategorys = categorys
            if self.secondCategorys.count == 1 {
                self.setCategory2(category: self.secondCategorys[0])
            }
        }
    }
    
    func resetProduct() {
        selectData.product = nil
        product = ""
        resetCategory1()
        firstCategorys.removeAll()
    }
    
    func resetCategory1() {
        selectData.category1 = nil
        category1 = ""
        resetCategory2()
        secondCategorys.removeAll()
    }
    
    func resetCategory2() {
        selectData.category2 = nil
        category2 = ""
    }
    
    func nextStep() -> Bool {
        // titleとproductは必須
        guard let _ = selectData.title else { return false }
        guard let _ = selectData.product else { return false }
        // category1,2はあれば必須
        if 0 < firstCategorys.count {
            guard let _ = selectData.category1 else { return false }
        }
        if 0 < secondCategorys.count {
            guard let _ = selectData.category2 else { return false }
        }
        return true
    }
    
    func makeCharacterList() {
        guard let title = selectData.title else { return }
        
        giveCharacters.removeAll()
        
        firebase.checkGoods(baseData: selectData) { goods in
            guard let goods = goods else { return }
            self.selectGoodsID = goods.id

        }
        firebase.getCharacters(titleID: title.id) { characters in
            guard let characters = characters else { return }
            for character in characters {
                let name = character.firstName + " " + character.lastName
                self.giveCharacters.append(GiveCharacter(id: character.id, name: name))
            }
        }
    }
    
    
    func checkCharacterList() -> GiveItem {
        var giveItems = [GiveCharacter]()
        for giveCharacter in giveCharacters {
            if 0 < giveCharacter.countNum{
                giveItems.append(giveCharacter)
            }
        }
        
        let item = GiveItem(id: selectGoodsID, goodsData: selectData, characters: giveItems)
        
        return item
    }
    
    
}
