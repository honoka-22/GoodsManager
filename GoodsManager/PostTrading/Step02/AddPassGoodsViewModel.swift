//
//  AddPassGoodsViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/22.
//

import Foundation

class AddPassGoodsViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    @Published var passCharacters = [PassCharacter]()
    
    @Published var titles = [Title]()
    @Published var products = [Product]()
    @Published var firstCategorys = [Category]()
    @Published var secondCategorys = [Category]()
    
    @Published var title = ""
    @Published var product = ""
    @Published var category1 = ""
    @Published var category2 = ""
    
    var titleGoodsList = [MyGoods]()
    var productGoodsList = [MyGoods]()
    var categoryGoodsList = [MyGoods]()
    var goodsList = [MyGoods]()
    
    @Published var selectItem = GoodsBase()
    var selectGoodsID = ""
    
    init() {
        firebase.getTitles() { titles in
            for title in titles {
                self.firebase.getMyGoods(titleID: title.id) { goodsList in
                    guard let _ = goodsList else { return }
                    self.titles.append(title)
                }
            }
        }
    }
    
    func getProducts(title: Title) {
        products.removeAll()
        self.firebase.getMyGoods(titleID: title.id) { goodsList in
            guard let goodsList = goodsList else { return }
            self.titleGoodsList = goodsList
            
            for goods in goodsList {
                if let product = goods.base.product {
                    if !self.products.contains(where: {$0.id == product.id}) {
                        self.products.append(product)
                    }
                }
            }
            self.goodsList = goodsList
        }
    }
    
    
    func getCategory1(product: Product) {
        firstCategorys.removeAll()
        
        var tmpList = [MyGoods]()
        
        for goods in goodsList {
            guard let goodsProduct = goods.base.product else { continue }
            if goodsProduct.id == product.id {
                tmpList.append(goods)
            }
        }
        productGoodsList = tmpList
        goodsList = tmpList
        
        for goods in self.productGoodsList {
            if let category1 = goods.base.category1 {
                if !self.firstCategorys.contains(where: {$0.id == category1.id}) {
                    self.firstCategorys.append(category1)
                }
            }
        }
    }
    
    func getCategory2(category1: Category) {
        secondCategorys.removeAll()
        
        var tmpList = [MyGoods]()
        for goods in productGoodsList {
            guard let goodsCategory1 = goods.base.category1 else { continue }
            if goodsCategory1.id == category1.id {
                tmpList.append(goods)
            }
        }
        categoryGoodsList = tmpList
        goodsList = tmpList
        
        for goods in categoryGoodsList {
            if let category2 = goods.base.category2 {
                if !self.secondCategorys.contains(where: {$0.id == category2.id}) {
                    self.secondCategorys.append(category2)
                }
            }
        }
    }
    

    
    func setTitle(title: Title) {
        if let select = selectItem.title {
            if select.id == title.id {
                return
            }
        }
        resetProduct()
        getProducts(title: title)
        selectItem.title = title
        self.title = title.name
        
    }
   
    func setProduct(product: Product) {
        if let select = selectItem.product {
            if select.id == product.id {
                return
            }
        }
        resetCategory1()
        getCategory1(product: product)
        selectItem.product = product
        self.product = product.name
        
    }
    
    func setCategory1(category: Category) {
        if let select = selectItem.category1 {
            if select.id == category.id {
                return
            }
        }
        resetCategory2()
        getCategory2(category1: category)
        selectItem.category1 = category
        self.category1 = category.name
        
    }
    
    func setCategory2(category: Category) {
        if let select = selectItem.category2 {
            if select.id == category.id {
                return
            }
        }
        var tmpList = [MyGoods]()

        for goods in categoryGoodsList {
            guard let goodsCategory2 = goods.base.category2 else { continue }
            guard let selectCategory2 = selectItem.category2 else { continue }
            if goodsCategory2.id == selectCategory2.id {
                tmpList.append(goods)
            }
        }
        
        goodsList = tmpList
        
        self.selectItem.category2 = category
        self.category2 = category.name
    }

    func resetProduct() {
        selectItem.product = nil
        product = ""
        resetCategory1()
    }
    
    func resetCategory1() {
        selectItem.category1 = nil
        category1 = ""
        resetCategory2()
    }
    
    func resetCategory2() {
        selectItem.category2 = nil
        category2 = ""
    }
    
    
    func postNewGoods() {
        guard let title = selectItem.title else { return }
        guard let product = selectItem.product else { return }
        
        var category1ID = ""
        var category2ID = ""
        if let category1 = selectItem.category1 { category1ID = category1.id}
        if let category2 = selectItem.category2 { category2ID = category2.id}

        
        let data = ["title" : title.id,
                    "product" : product.id,
                    "category1" : category1ID,
                    "category2" : category2ID] as [String: Any]
        
        firebase.addData(collectionID: "goods", data: data)
        
    }
    
    func nextStep() -> Bool {
        if goodsList.count == 1 {
            firebase.checkGoods(baseData: selectItem) { goods in
                guard let _ = goods else {
                    self.postNewGoods()
                    return
                }
            }
            return true
        } else {
            return false
        }
    }
    
    func makeCharacterList() {
        passCharacters.removeAll()
        
        self.firebase.getMyGoodsInfo2(goods: goodsList[0]) { goods in
            
            guard let counts = goods.counts else { return }
            self.selectGoodsID = goods.id
            for count in counts {
                if count.possession == 0 && count.reservation.strayChild == 0 {
                    continue
                }
                let firstName = count.character.firstName
                let lastName = count.character.lastName
                var name = firstName
                if lastName != "" {
                    name += (" " + lastName)
                    self.passCharacters.append(PassCharacter(id: count.character.id, name: name))
                }
            }
        }
        
    }
    
    func checkCharacterList() -> PassItem {
        
        var passItems = [PassCharacter]()
        for passCharacter in self.passCharacters {
            if 0 < passCharacter.countNum{
                passItems.append(passCharacter)
            }
        }

        let item = PassItem(id: selectGoodsID,
                            goodsData: self.selectItem,
                            characters: passItems)


        return item
    }
}
//267
