//
//  GoodsViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import Firebase
import UIKit

class GoodsViewModel: ObservableObject {
    let firebase = FirebaseFunction()
    @Published var isProgress = true
    @Published var goods: MyGoods
    @Published var images = [UIImage]()
    @Published var title = ""
    @Published var product = ""
    @Published var category1 = ""
    @Published var category2 = ""
    @Published var counts = [Count]()
    
    init(goods: MyGoods) {
        self.goods = goods
        getData(goods: goods)
    }
    
    func getInfo() {
        
        firebase.getMyGoodsInfo1(goods: goods) { [self] goods in
            
            self.goods = goods
            
            for image in goods.images {
                self.getImage(image: image)
            }
            
            self.firebase.getMyGoodsInfo2(goods: goods) { [self] goods in
                self.goods = goods
                
                guard let counts = goods.counts else { return }
                self.counts = counts
                print(self.counts)
                self.isProgress = false
            }
        }
    }
    
    func getImage(image: String) {
        
        guard let url = URL(string: image) else { return }
        
        guard let data = try? Data(contentsOf: url) else { return }
        
        self.images.append(UIImage(data: data)!)

    }

    func getData(goods: MyGoods) {
        let productID = goods.product
        firebase.getTitle(id: goods.title) { title in
            self.title = title.name
        }
        if goods.product == "" { return }
        firebase.getProductName(titleID: goods.title, id: productID) { product in
            self.product = product
        }
        
        if goods.category1 == "" { return }
        firebase.getCategory1Name(productID: productID, id: goods.category1) { category in
            self.category1 = category
        }
        
        if goods.category2 == "" { return }
        firebase.getCategory2Name(productID: productID, category1ID: goods.category1, id: goods.category2) { category in
            self.category2 = category
        }
    }
    
    
}
