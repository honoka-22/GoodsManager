//
//  FirebaseFunction.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/07.
//

import Foundation
import Firebase

class FirebaseFunction {
    private let DB = Firestore.firestore()
    
    /// Firebaseから特定のドキュメントデータを取得
    func getData(id: String, documentID: String,
                 completion: @escaping (DocumentSnapshot?, Error?) -> ()) {
        
        DB.collection(id).document(documentID).getDocument { snapshot, error in
            if let error = error {
                print("エラーが発生しました")
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            guard let snapshot = snapshot else { return }
            completion(snapshot, nil)
        }
    }
    
    /// Firebaseから全データを取得
    func getData(id: String, completion: @escaping ([QueryDocumentSnapshot]?, Error?) -> ())  {
        
        DB.collection(id).getDocuments { snapshot, error in
            if let error = error {
                print("エラーが発生しました")
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            guard let snaps = snapshot else { return }
            completion(snaps.documents, nil)
        }
    }
    
    /// Firebaseに単体データを登録 ドキュメントIDは自動生成
    func addData(collectionID: String, data: [String: Any]) {
        DB.collection(collectionID).addDocument(data: data) { error in
            if let error = error {
                print("エラーが発生しました")
                print(error.localizedDescription)
                return
            }
        }
    }
    
    /// Firebaseに複数データを登録 ドキュメントIDは自動生成
    func addData(collectionID: String, data: [[String: Any]]) {
        for data in data {
            addData(collectionID: collectionID, data: data)
        }
    }
    
    /// Firebaseに単体データを登録 ドキュメントID指定
    func setData(collectionID: String, documentID: String, data: [String: Any]) {
        DB.collection(collectionID).document(documentID).setData(data) { error in
            if let error = error {
                print("エラーが発生しました")
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func setData(collectionID: String,documentID: String, data: [String: Any],
                 completion: @escaping () -> ()) {
        DB.collection(collectionID).document(documentID).setData(data) { error in
            if let error = error {
                print("エラーが発生しました")
                print(error.localizedDescription)
                return
            }
            completion()
        }
    }
    
    
}

extension FirebaseFunction {
    /// 特定のタイトルを取得
    func getTitle(id: String, completion: @escaping (Title?) -> ()) {
        
        getData(id: "titles", documentID: id) { document, error in
            if let _ = error {
                completion(nil)
                return
            }
            guard let document = document else { return }
            
            let id = document.documentID
            guard let name = document.get("name") as? String,
                  let shortName = document.get("shortName") as? String else { return }
            let title = Title(id: id, name: name, shortName: shortName)
            
            completion(title)
        }
        
    }
    
    /// 複数タイトルを取得
    func getTitles(completion: @escaping ([Title]) -> ()) {
        var titles = [Title]()
        
        getData(id: "titles") { documents, error in
            if let _ = error {
                completion([])
                return
            }
            guard let documents = documents else { return }
            
            for document in documents {
                let id = document.documentID
                self.getTitle(id: id) { title in
                    if let title = title {
                        titles.append(title)
                    }
                    
                    if documents.count == titles.count {
                        completion(titles)
                    }
                }
            }
        }
    }
    
    /// タイトルを登録
    func addTitle(name: String, shortName: String) {
        let data = ["name": name, "shortName": shortName]
        addData(collectionID: "titles", data: data)
    }
    
    // ----------------------------------------------------------------- //
    
    func getCharacterPath(titleID: String) -> String {
        return makePath(["titles", titleID, "characters"])
    }
    
    /// 特定のキャラクターを取得
    func getCharacter(titleID: String, id: String, completion: @escaping (Character?) -> ()) {
        
        getData(id: getCharacterPath(titleID: titleID), documentID: id) { document, error in
            if let _ = error {
                completion(nil)
                return
            }
            guard let document = document else { return }
            guard let firstName = document.get("firstName") as? String,
                  let lastName = document.get("lastName") as? String else { return }
            var item = Character(id: id, firstName: firstName, lastName: lastName)
            
            if let nickname = document.get("nickname") as? String {
                item.nickname = nickname
            }
            completion(item)
        }
    }
    
    /// 複数のキャラクターを取得
    func getCharacters(titleID: String, completion: @escaping ([Character]?) -> ()) {
        var characters = [Character]()
        
        getData(id: getCharacterPath(titleID: titleID)) { documents, error in
            if let _ = error {
                completion(nil)
                return
            }
            guard let documents = documents else { return }
            
            for document in documents {
                let id = document.documentID
                self.getCharacter(titleID: titleID, id: id) { character in
                    if let character = character {
                        characters.append(character)
                    }
                    if characters.count == documents.count {
                        completion(characters)
                    }
                }
            }
        }
    }
    
    /// キャラクターを登録
    func addCharacters(id: String, characters: [Character]) {
        var data = [[String: Any]]()
        
        for character in characters {
            let item = ["firstName": character.firstName,
                        "lastName": character.lastName,
                        "nickname": character.nickname] as [String : Any]
            data.append(item)
        }
        
        addData(collectionID: getCharacterPath(titleID: id), data: data)
    }
    
    // ----------------------------------------------------------------- //
    
    /// 特定の商品を取得
    func getProduct(titleID: String, id: String, completion: @escaping (Product?) -> ()) {
        
        getData(id: "products", documentID: id) { document, error in
            if let _ = error {
                completion(nil)
                return
            }
            guard let document = document else { return }
            
            let id = document.documentID
            guard let name = document.get("name") as? String else { return }
            
            let item = Product(id: id, name: name, title: titleID)
            
            completion(item)
        }
    }
    
    /// タイトルの商品を取得
    func getProducts(titleID: String, completion: @escaping ([Product]?) -> ()) {
        DB.collection("products")
            .whereField("title", isEqualTo: titleID).getDocuments { snapshot, error in
                if let error = error {
                    print("エラーが発生しました")
                    print(error.localizedDescription)
                    completion(nil)
                }
                guard let snaps = snapshot else { return }
                
                var items = [Product]()
                
                for document in snaps.documents {
                    let id = document.documentID
                    guard let name = document.get("name") as? String else { continue }
                    
                    let item = Product(id: id, name: name, title: titleID)
                    items.append(item)
                    
                    if document == snaps.documents.last {
                        completion(items)
                    }
                }
                
            }
    }
    
    // ----------------------------------------------------------------- //
    
    func getCategoryPath(_ productID: String) -> String {
        return makePath(["products", productID, "categorys"])
    }
    
    func get1stCategorys(productID: String, completion: @escaping ([Category]) -> ()) {
        getData(id: getCategoryPath(productID)) { documents, error in
            if let _ = error { return }
            guard let documents = documents else { return }
            
            var categorys = [Category]()
            for document in documents {
                let categoryID = document.documentID
                guard let name = document.get("name") as? String else { continue }
                let item = Category(id: categoryID, name: name)
                categorys.append(item)
            }
            completion(categorys)
        }
    }
    
    func getCategory1(productID: String, id: String, completion: @escaping (Category) -> ()) {
        getData(id: getCategoryPath(productID), documentID: id) { document, error in
            if let _ = error { return }
            guard let document = document else { return }
            
            guard let name = document.get("name") as? String else { return }
            let category = Category(id: id, name: name)
            completion(category)
        }
    }
    // ----------------------------------------------------------------- //
    
    func get2ndCategorys(productID: String, categoryID: String,
                         completion: @escaping ([Category]) -> ()) {
        let path = makePath([getCategoryPath(productID), categoryID, "categorys"])
        
        getData(id: path) { documents, error in
            if let _ = error { return }
            guard let documents = documents else { return }
            
            var categorys = [Category]()
            
            for document in documents {
                let categoryID = document.documentID
                guard let name = document.get("name") as? String else { continue }
                let item = Category(id: categoryID, name: name)
                categorys.append(item)
            }
            categorys.sort(by: {$0.name > $1.name})
            
            completion(categorys)
            
        }
    }
    
    func getCategory2(productID: String, category1ID: String,
                      id: String, completion: @escaping (Category) -> ()) {
        
        let path = makePath([getCategoryPath(productID), category1ID, "categorys"])
        
        getData(id: path, documentID: id) { document, error in
            if let _ = error { return }
            guard let document = document else { return }
            
            guard let name = document.get("name") as? String else { return }
            let category = Category(id: id, name: name)
            completion(category)
        }
    }
    
    // ----------------------------------------------------------------- //
    
    /// 既に登録があるかを確認
    func checkGoods(baseData: GoodsBase, completion: @escaping (Goods?) -> ()) {
        guard let title = baseData.title else { return }
        guard let product = baseData.product else { return }
        
        var category1ID = ""
        var category2ID = ""
        if let category1 = baseData.category1 { category1ID = category1.id }
        if let category2 = baseData.category2 { category2ID = category2.id }
        
        DB.collection("goods")
            .whereField("title", isEqualTo: title.id)
            .whereField("product", isEqualTo: product.id)
            .whereField("category1", isEqualTo: category1ID)
            .whereField("category2", isEqualTo: category2ID)
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let snap = snapshot else { return }
                
                if snap.documents.count == 0 {
                    completion(nil)
                    return
                }
                
                let document = snap.documents[0]
                
                let item = Goods(id: document.documentID, base: baseData)
                print(item)
                completion(item)
            }
    }
    
    func getGoods(code: String, completion: @escaping (Goods?) -> ()) {
        DB.collection("goods")
            .whereField("code", isEqualTo: code)
            .getDocuments() { documents, error in
                if let _ = error {
                    completion(nil)
                    return
                }
                guard let documents = documents else {
                    completion(nil)
                    return
                }
                
                self.getGoods(id: documents.documents[0].documentID) { goods in
                    guard let goods = goods else {
                        completion(nil)
                        return
                    }
                    completion(goods)

                }
        }
    }
    
    func getGoods(id: String, completion: @escaping (Goods?) -> ()) {
        var data = Goods(id: id)
        getData(id: "goods", documentID: id) { document, error in
            if let _ = error {
                completion(data)
                return
            }
            guard let document = document else {
                completion(data)
                return
            }
            
            guard let title = document.get("title") as? String,
                  let product = document.get("product") as? String else {
                completion(data)
                return
            }
            
            self.getTitle(id: title) { title in
                guard let title = title else {
                    completion(data)
                    return
                }
                data.base.title = title
                
                self.getProduct(titleID: title.id, id: product) { product in
                    guard let product = product else {
                        completion(data)
                        return
                    }
                    data.base.product = product
                    
                    guard let category1 = document.get("category1") as? String else {
                        completion(data)
                        return
                    }
                    if category1 == "" {
                        completion(data)
                        return
                    }
                    self.getCategory1(productID: product.id, id: category1) { category in
                        data.base.category1 = category
                        
                        guard let category2 = document.get("category2") as? String else {
                            completion(data)
                            return
                        }
                        if category2 == "" {
                            completion(data)
                            return
                        }
                        self.getCategory2(productID: product.id,
                                                   category1ID: category.id,
                                                   id: category2) { category in
                            data.base.category2 = category
                            completion(data)
                        }
                    }
                    
                }
            }
        }
    }

    func makePath(_ items: [String]) -> String {
        return items.joined(separator : "/")
    }
    
    func getCountCharacter(titleID: String, id: String, completion: @escaping ([Count]?) -> ()) {
        getData(id: id) { documents, error in
            if let _ = error { return }
            guard let documents = documents else { return }
            
            var items = [Count]()
            var count = documents.count
            
            for document in documents {
                let character = document.documentID
                
                guard let possesion = document.get("possesion") as? Int,
                      let strayChild = document.get("strayChild") as? Int,
                      let target = document.get("target") as? Int,
                      let trading = document.get("trading") as? Int else { continue }
                
                self.getCharacter(titleID: titleID, id: character) { character in
                    guard let character = character else {
                        count -= 1
                        if items.count == count {
                            completion(items)
                        }
                        return
                    }
                    let detail = Detail(strayChild: strayChild, trading: trading)
                    
                    let item = Count(character: character,
                                     possession: possesion,
                                     reservation: detail,
                                     target: target)
                    items.append(item)
                    
                    if items.count == count {
                        completion(items)
                    }
                }
            }
        }
    }
    
    func getMyGoodsInfo1(goods: MyGoods, completion: @escaping (MyGoods) -> ()) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        let path = makePath(["users", user.uid, "myGoods"])
        getData(id: path, documentID: goods.id) { document, error in
            if let _ = error { return }
            guard let document = document else { return }
            
            var goods = goods
            
            if let images = document.get("images") as? [String] {
                goods.images = images
            }
            completion(goods)
        }
    }
    
    func getMyGoodsInfo2(goods: MyGoods, completion: @escaping (MyGoods) -> ()) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let path = makePath(["users", user.uid, "myGoods"])
        
        getData(id: path, documentID: goods.id) { document, error in
            if let _ = error { return }
            guard let document = document else { return }
            
            let path2 = self.makePath([path, goods.id, "characters"])
            
            var goods = goods
            guard let title = document.get("title") as? String else { return }
            
            self.getCountCharacter(titleID: title, id: path2) { counts in
                guard let counts = counts else { return }
                
                goods.counts = counts
                completion(goods)
            }
        }
    }
    
    func getGoodsCharacters(id: String, completion: @escaping ([String]?) -> ()) {
        print(id)
        getData(id: makePath(["goods", id, "characters"])) { documents, error in
            if let _ = error {
                completion(nil)
                return
            }
            guard let documents = documents else { return }
            
            var characters = [String]()
            
            for document in documents {
                let id = document.documentID
                characters.append(id)
            }
            
            completion(characters)
            
        }
    }
    

    func getMyGoods(titleID: String = "", completion: @escaping ([MyGoods]?) -> ()) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let id = makePath(["users", user.uid, "myGoods"])
        var getDocuments = DB.collection(id).getDocuments(completion: )
        
        if titleID != "" {
            getDocuments = DB.collection(id)
                .whereField("title", isEqualTo: titleID).getDocuments(completion: )
        }
        
        getDocuments() { snapshot, error in
            if let _ = error {
                completion(nil)
                return
            }
            
            guard let snap = snapshot else { return }
            
            var myGoodsList = [MyGoods]()
            var count = snap.documents.count
            for document in snap.documents {
                let goodsID = document.documentID
                
                self.getGoods(id: goodsID) { goods in
                    guard let goods = goods else {
                        count -= 1
                        return
                    }
                    let item = MyGoods(id: goodsID, base: goods.base)
                    myGoodsList.append(item)
                    
                    if myGoodsList.count == count {
                        completion(myGoodsList)
                    }
                }
            }
        }
    }
    
    func getTradings(completion: @escaping ([Trading]?, Error?) -> ()) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let id = makePath(["users", user.uid, "tradings"])
        
        getData(id: id) { documents, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let documents = documents else {
                completion(nil, nil)
                return
            }
            
            var tradings = [Trading]()
            
            for document in documents {
                let tradingID = document.documentID
                
                guard let partner = document.get("partner") as? [String: Any] else {
                    continue
                }
                
                guard let name = partner["name"] as? String else { continue }
                guard let tool = partner["tool"] as? String else { continue }
                var tradingPartner = Partner(name: name, tool: tool)
                if let account = partner["account"] as? String {
                    tradingPartner.account = account
                }
                
                guard let statusData = document.get("status") as? [String: Any] else {
                    continue
                }
                guard let type = statusData["type"] as? String else { continue }
                guard let method = statusData["method"] as? String else { continue }
                guard let status = statusData["status"] as? String else { continue }
                let tradingStatus = Status(type: type, method: method, status: status)
                
                var trading = Trading(id: tradingID,
                                      partner: tradingPartner,
                                      status: tradingStatus)
                
                if let passGoods = document.get("passGoods") as? [[String: Any]] {
                    trading.passGoods = passGoods
                }
                
                if let purchasePrice = document.get("purchasePrice") as? Int {
                    trading.purchasePrice = purchasePrice
                }
                
                if let giveGoods = document.get("giveGoods") as? [[String: Any]] {
                    trading.giveGoods = giveGoods
                }
                   
                if let salesPrice = document.get("salesPrice") as? Int {
                    trading.salesPrice = salesPrice
                }
                
                if let memo = document.get("memo") as? String {
                    trading.memo = memo
                }
                
                tradings.append(trading)
            }
            
            completion(tradings, nil)
        }
    }
}
