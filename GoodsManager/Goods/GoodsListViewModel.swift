//
//  GoodsListViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import Firebase
import UIKit

struct TitleMyGoods: Identifiable, Decodable {
    let id: String
    let title: Title
    var products: [ProductMyGoods]
}

struct ProductMyGoods: Identifiable, Decodable {
    let id: String
    let name: String
    var categorys = [CategoryMyGoods]()
}

struct CategoryMyGoods: Identifiable, Decodable {
    let id: String
    var name: String = ""
    var goods: MyGoods
}


class GoodsListViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    var titles = [Title]()
    
    @Published var isRoad = false
    @Published var titleMyGoods = [TitleMyGoods]()
    @Published var selectGoods: MyGoods?
    @Published var isShowInfo = false
    @Published var myList = MyList.title
    @Published var selectProduct: ProductMyGoods?
    @Published var goodsList = [CategoryMyGoods]()
    
    init() {
        firebase.getTitles() { titles in
            self.titles = titles
            self.getMyGoods()
        }
    }


    
    func getMyGoods() {
        for title in titles {
            var titleProducts = [ProductMyGoods]()
            
            firebase.getMyGoods(titleID: title.id) { goodsList in
                guard let goodsList = goodsList else { return }
                
                var products = [Product]()
                
                for goods in goodsList {
                    if let product = goods.base.product {
                        if !products.contains(where: {$0.id == product.id}) {
                            products.append(product)
                        }
                    }
                }

                for product in products {
                    var categoryGoods = [CategoryMyGoods]()
                    
                    for goods in goodsList {
                        guard let goodsProduct = goods.base.product else { continue }
                        if product.id != goodsProduct.id { continue }
                        
                        let item = CategoryMyGoods(id: goods.id, goods: goods)
                        categoryGoods.append(item)
                    }
                    
                    
                    let item = ProductMyGoods(id: product.id,
                                              name: product.name,
                                              categorys: categoryGoods)
                    
                    titleProducts.append(item)
                    
                    if products.count == titleProducts.count {
                        let item = TitleMyGoods(id: title.id, title: title, products: titleProducts)
                        self.titleMyGoods.append(item)
                        self.titleMyGoods.sort(by: {$0.title.name < $1.title.name})
                    }

                }
            }
            
        }
        
    }
    
    func getCategory() {
        guard let product = selectProduct else { return }
        goodsList.removeAll()
        
        for category in product.categorys {
            let goodsID = category.goods.id
            let base = category.goods.base
            let goods = MyGoods(id: goodsID, base: base)
            
            var label = ""
            
            if let category1 = base.category1 {
                if category1.id != "" { label += (category1.name + " ") }
            }
            
            if let category2 = base.category2 {
                if category2.id != "" { label += category2.name }
            }
            
            let item = CategoryMyGoods(id: goodsID, name: label, goods: goods)
            self.goodsList.append(item)
            
            print("-------------------------")
            print(item)
            self.goodsList.sort{ $0.name < $1.name }
        }
        
    }
}

