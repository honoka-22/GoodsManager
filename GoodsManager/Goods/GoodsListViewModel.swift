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
    var goods: [MyGoods]
}

struct CategoryMyGoods: Identifiable, Decodable {
    let id: String
    let name: String
    var goods: [MyGoods]
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

    
    init() {
        firebase.getTitles() { titles in
            self.titles = titles
            self.getMyGoods()
        }
    }

    func getMyGoods() {
        
        for title in titles {
            var titleProducts = [ProductMyGoods]()
            
            firebase.getTitleMyGoods(titleID: title.id) { goodsList in
                guard let goodsList = goodsList else { return }
                
                var products : Set<String> = []
                
                for goods in goodsList {
                    products.insert(goods.product)
                }
                
                for product in products {
                    var productGoods = [MyGoods]()
                    
                    for goods in goodsList {
                        if product != goods.product { continue }
                        productGoods.append(goods)
                    }
                    
                    
                    self.firebase.getProductName(titleID: title.id, id: product) { name in
                        let item = ProductMyGoods(id: product,name: name, goods: productGoods)
                        titleProducts.append(item)
                        
                        if products.count == titleProducts.count {
                            let item = TitleMyGoods(id: title.id, title: title, products: titleProducts)
                            self.titleMyGoods.append(item)
                        }
                    }
                }
            }
        }
        
    }
    
    func getCategory() {
        guard let product = selectProduct else { return }
        let productID = product.id

        for goods in product.goods {
            var label = ""
            
            if goods.category1 == "" { return }
            firebase.getCategory1Name(productID: productID, id: goods.category1) { category in
                label = category
            }
            
            if goods.category2 == "" { return }
            
            firebase.getCategory2Name(productID: productID, category1ID: goods.category1,
                                      id: goods.category2) { category in
                label += " "
                label += category
            }
            
            
        }
        
        
        
        
    }
}

