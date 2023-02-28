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
        
        guard let title = goods.base.title else { return }
        firebase.getTitle(id: title.id) { title in
            guard let title = title else { return }
            self.title = title.name
            print(self.title)
        }
        
        guard let product = goods.base.product else { return }
        firebase.getProduct(titleID: title.id, id: product.id) { product in
            guard let product = product else { return }
            self.product = product.name
            print(self.product)
        }
        
        guard let category1 = goods.base.category1 else { return }
        firebase.getCategory1(productID: product.id, id: category1.id) { category in
            self.category1 = category.name
            print(self.category1)
        }
        
        guard let category2 = goods.base.category2 else { return }
        firebase.getCategory2(productID: product.id,
                              category1ID: category1.id, id: category2.id) { category in
            self.category2 = category.name
            print(self.category2)
        }
    }
    
    func makeTemplate() -> String {
        var text = title + " " + product + " " + category1 + " " + category2 + "\n"
        text += "譲: "
        for count in counts {
            if count.possession == 0 { continue }
            text += (count.character.lastName + " \(count.possession)")
            if count.character.id != counts.last?.character.id {
                text += ", "
            }
        }
        return text
    }
    
}
