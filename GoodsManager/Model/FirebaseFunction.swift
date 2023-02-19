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
                 completion: @escaping (DocumentSnapshot) -> ()) {
        
        DB.collection(id).document(documentID).getDocument { snapshot, error in
            if let error = error {
                print("エラーが発生しました")
                print(error.localizedDescription)
                return
            }
            guard let snapshot = snapshot else { return }
            completion(snapshot)
        }
    }
    
    /// Firebaseから全データを取得
    func getData(id: String, completion: @escaping ([QueryDocumentSnapshot]) -> ())  {
        
        DB.collection(id).getDocuments { snapshot, error in
            if let error = error {
                print("エラーが発生しました")
                print(error.localizedDescription)
                return
            }
            guard let snaps = snapshot else { return }
            completion(snaps.documents)
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
    
    func setData(collectionID: String,
                 documentID: String, data: [String: Any],
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
    func getTitle(id: String, completion: @escaping (Title) -> ()) {
        
        getData(id: "titles", documentID: id) { document in
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
        
        getData(id: "titles") { documents in
            
            for document in documents {
                let id = document.documentID
                self.getTitle(id: id) { title in
                    titles.append(title)
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
    func getCharacter(titleID: String, id: String, completion: @escaping (Character) -> ()) {
        
        getData(id: getCharacterPath(titleID: titleID), documentID: id) { document in
            
            guard let firstName = document.get("firstName") as? String,
                  let lastName = document.get("lastName") as? String,
                  let nickname = document.get("nickname") as? String else { return }
            
            let item = Character(id: id, firstName: firstName,
                                 lastName: lastName, nickname: nickname)
            completion(item)
        }
    }
    
    /// 複数のキャラクターを取得
    func getCharacters(titleID: String, completion: @escaping ([Character]) -> ()) {
        var characters = [Character]()
        
        getData(id: getCharacterPath(titleID: titleID)) { documents in
            
            for document in documents {
                let id = document.documentID
                self.getCharacter(titleID: titleID, id: id) { character in
                    characters.append(character)
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
    func getProduct(titleID: String, id: String, completion: @escaping (Product) -> ()) {
        
        getData(id: "products", documentID: id) { document in
            let id = document.documentID
            guard let name = document.get("name") as? String else { return }
            
            let item = Product(id: id, name: name, title: titleID)
            
            completion(item)
        }
    }
    
    func getProductName(titleID: String, id: String, completion: @escaping (String) -> ()) {
        getData(id: "products", documentID: id) { document in
            guard let name = document.get("name") as? String else { return }
            completion(name)
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
        getData(id: getCategoryPath(productID)) { documents in
            
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
    
    func getCategory1Name(productID: String, id: String, completion: @escaping (String) -> ()) {
        getData(id: getCategoryPath(productID), documentID: id) { document in
            guard let name = document.get("name") as? String else { return }
            completion(name)
        }
    }
    
    
    // ----------------------------------------------------------------- //
    
    func get2ndCategorys(productID: String, categoryID: String,
                         completion: @escaping ([Category]) -> ()) {
        let path = makePath([getCategoryPath(productID), categoryID, "categorys"])
        
        getData(id: path) { documents in
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
    
    func getCategory2Name(productID: String, category1ID: String,
                          id: String, completion: @escaping (String) -> ()) {
        
        let path = makePath([getCategoryPath(productID), category1ID, "categorys"])
        
        getData(id: path, documentID: id) { document in
            guard let name = document.get("name") as? String else { return }
            completion(name)
        }
    }
    
    // ----------------------------------------------------------------- //
    
    
    func getGoodsCharacters(id: String, completion: @escaping ([String]?) -> ()) {
        getData(id: makePath(["goods", id, "characters"])) { documents in
            var characters = [String]()
            
            for document in documents {
                guard let id = document.get("character") as? String else { continue }
                characters.append(id)
            }
            
            completion(characters)

        }
    }
    
    /// 既に登録があるかを確認
    func checkGoods(baseData: GoodsBase, completion: @escaping ([String]?) -> ()) {
        guard let title = baseData.title else { return }
        guard let product = baseData.product else { return }
        
        var category1ID = ""
        var category2ID = ""
        if let category1 = baseData.category1 { category1ID = category1.id}
        if let category2 = baseData.category2 { category2ID = category2.id}

        DB.collection("goods")
            .whereField("title", isEqualTo: title.id)
            .whereField("product", isEqualTo: product.id)
            .whereField("category1", isEqualTo: category1ID)
            .whereField("category2", isEqualTo: category2ID)
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                }
                
                guard let snap = snapshot else { return }
                var goodsID = [String]()
                for document in snap.documents {
                    goodsID.append(document.documentID)
                }
                completion(goodsID)
            }
        completion(nil)
    }

    func makePath(_ items: [String]) -> String {
        return items.joined(separator : "/")
    }
    
    func getC(uid: String, myGoodsID: String,
              titleID: String,completion: @escaping ([Count]) -> ()) {
        let path = makePath(["users", uid, "myGoods", myGoodsID, "characters"])
        
        getData(id: path) { documents in
            
            
        }
    }
    
    func getCountCharacter(titleID: String, id: String, completion: @escaping ([Count]?) -> ()) {
        getData(id: id) { documents in
            
            var items = [Count]()

            for document in documents {
                
               
                guard let character = document.get("character") as? String,
                      let possesion = document.get("possesion") as? Int,
                      let strayChild = document.get("strayChild") as? Int,
                      let target = document.get("target") as? Int,
                      let trading = document.get("trading") as? Int else { continue }

                
                self.getCharacter(titleID: titleID, id: character) { character in
                    let detail = Detail(strayChild: strayChild, trading: trading)
                    
                    let item = Count(character: character,
                                     possession: possesion,
                                     reservation: detail,
                                     target: target)
                    items.append(item)
                    
                    if items.count == documents.count {
                        completion(items)
                    }
                }
                
                
                
            }
        }
    }
    
    func getMyGoodsInfo1(goods: MyGoods, completion: @escaping (MyGoods) -> ()) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        let path = makePath(["users", user.uid, "myGoods"])
        getData(id: path, documentID: goods.id) { document in
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
        
        getData(id: path, documentID: goods.id) { document in
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
    
    func getTitleMyGoods(titleID: String, completion: @escaping ([MyGoods]?) -> ()) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let id = "users/" + user.uid + "/myGoods"
        DB.collection(id)
            .whereField("title", isEqualTo: titleID).getDocuments() { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                }
                
                guard let snap = snapshot else { return }
                
                var myGoodsList = [MyGoods]()
                var count = snap.documents.count
                for document in snap.documents {
                    let goodsID = document.documentID
                    guard let title = document.get("title") as? String,
                          let product = document.get("product") as? String,
                          let category1 = document.get("category1") as? String,
                          let category2 = document.get("category2") as? String else {
                        count -= 1
                        continue
                        
                    }
                    
                    let item = MyGoods(id: goodsID, title: title, product: product,
                                       category1: category1, category2: category2)
                    
                    myGoodsList.append(item)
                    
                    if myGoodsList.count == count {
                        completion(myGoodsList)
                    }
                }
                
            }
    }
    
    func getMyGoodsBaseData(userID: String, completion: @escaping ([MyGoods]?) -> ()) {
        let id = "users/" + userID + "/myGoods"
        
        getData(id: id) { documents in
            
            var myGoodsList = [MyGoods]()
            for document in documents {
                let goodsID = document.documentID
                guard let title = document.get("title") as? String,
                      let product = document.get("product") as? String,
                      let category1 = document.get("category1") as? String,
                      let category2 = document.get("category2") as? String else { continue }
                
                
                let item = MyGoods(id: goodsID, title: title, product: product,
                                   category1: category1, category2: category2)
                
                myGoodsList.append(item)
                
                if document == documents.last {
                    completion(myGoodsList)
                }


            }
            
        }
    }
}
