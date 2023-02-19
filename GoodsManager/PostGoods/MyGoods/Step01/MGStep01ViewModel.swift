//
//  MyGoodsStep01ViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/15.
//

import Foundation
import Firebase
enum NewDataType {
    case product
    case category1
    case category2
}
class MGStep01ViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    private let storage = FirebaseStorageFunction()
    
    @Published var baseData = GoodsBase()
    @Published var newDataType = NewDataType.product
    
    let defaultLabel = "未選択"
    
    @Published var titleLabel = "未選択"
    @Published var productLabel = "未選択"
    @Published var Category1Lagel = "未選択"
    @Published var Category2Lagel = "未選択"
    
    // 登録情報
    /// 作品名
    @Published var titles = [Title]()
    /// 商品名
    @Published var products = [Product]()
    /// カテゴリー１
    @Published var firstCategorys = [Category]()
    /// カテゴリー2
    @Published var secondCategorys = [Category]()
    
    init() {
        firebase.getTitles() { titles in
            self.titles = titles
        }
    }
    
    func setTitle(title: Title) {
        if titleLabel != title.name {
            baseData.title = title
            getProducts()
            resetProduct()
            titleLabel = title.name
        }
    }
    
    func setProduct(product: Product) {
        if productLabel != product.name {
            baseData.product = product
            get1stCategorys()
            resetCategory1()
            productLabel = product.name
        }
    }
    
    func setCategory1(category: Category) {
        if Category1Lagel != category.name {
            baseData.category1 = category
            get2ndCategorys()
            resetCategory2()
            Category1Lagel = category.name
        }
    }
    
    func setCategory2(category: Category) {
        if Category2Lagel != category.name {
            baseData.category2 = category
            Category2Lagel = category.name
        }
    }
    
    func getProducts() {
        guard let title = baseData.title else { return }
        firebase.getProducts(titleID: title.id) { products in
            guard let products = products else { return }
            self.products = products
            if self.products.count == 1 {
                self.setProduct(product: self.products[0])
            }
        }
    }
    
    func get1stCategorys() {
        guard let product = baseData.product else { return }
        firebase.get1stCategorys(productID: product.id) { categorys in
            self.firstCategorys = categorys
            if self.firstCategorys.count == 1 {
                self.setCategory1(category: self.firstCategorys[0])
            }
        }
    }
    
    func get2ndCategorys() {
        guard let product = baseData.product else { return }
        guard let category = baseData.category1 else { return }
        firebase.get2ndCategorys(productID: product.id, categoryID: category.id) { categorys in
            self.secondCategorys = categorys
            if self.secondCategorys.count == 1 {
                self.setCategory2(category: self.secondCategorys[0])
            }
        }
    }
    
    func resetProduct() {
        productLabel = defaultLabel
        baseData.product = nil
        resetCategory1()
        firstCategorys.removeAll()
    }
    
    func resetCategory1() {
        Category1Lagel = defaultLabel
        baseData.category1 = nil
        resetCategory2()
        secondCategorys.removeAll()
    }
    
    func resetCategory2() {
        Category2Lagel = defaultLabel
        baseData.category2 = nil
    }
    
    func nextStep() -> Bool {
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
    
    
    func addData(name: String) {
        switch newDataType {
        case .product:
            addProduct(name: name)
            getProducts()
            
        case .category1:
            add1stCategory(name: name)
            get1stCategorys()
            
        case .category2:
            add2ndCategory(name: name)
            get2ndCategorys()
        }
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
        guard let product = baseData.product else { return }
        guard let category = baseData.category1 else { return }
        let data = ["name" : name] as [String: Any]
        let id = "products/" + product.id + "/categorys/" + category.id + "/categorys"
        firebase.addData(collectionID: id, data: data)
    }
    
}
