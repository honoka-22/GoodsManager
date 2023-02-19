//
//  WindowViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/15.
//

import Firebase

class WindowViewModel: ObservableObject {
    @Published var baseData = GoodsBase()
    private let firebase = FirebaseFunction()
    
    init(baseData: GoodsBase) {
        guard let title = baseData.title else { return }
        self.baseData.title = title
        guard let product = baseData.product else { return }
        self.baseData.product = product
        guard let category = baseData.category1 else { return }
        self.baseData.category1 = category
    }
    
    func addData(name: String) {
        guard let _ = baseData.product else {
            addProduct(name: name)
            return
        }
        guard let _ = baseData.category1 else {
            add1stCategory(name: name)
            return
        }
        add2ndCategory(name: name)
    }
    
    func addProduct(name: String) {
        guard let title = baseData.title else { return }
        let data = ["name" : name,
                    "title" : title.id] as [String : Any]
        firebase.addData(collectionID: "products", data: data)
    }
    
    func add1stCategory(name: String) {
        guard let product = baseData.product else { return }
        let data = ["name" : name] as [String: Any]
        let id = "products/" + product.id + "/categorys"
        firebase.addData(collectionID: id, data: data)
    }
    
    func add2ndCategory(name: String) {
        guard let category = baseData.category1 else { return }
        let data = ["name" : name] as [String: Any]
        let id = category.id + "/categorys"
        firebase.addData(collectionID: id, data: data)
    }
}
