//
//  TradingRegistrationViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import Foundation
import SwiftUI
import Firebase

class TradingRegistrationViewModel: ObservableObject {
    @Published var selected = 1
    @Published var name = ""
    @Published var account = ""
    
    func nextStep() {
        
    }
    
    
    /// JANコードからグッズ情報を取得
    func getGoods(code: String) {
        
    }
 
    func sample1() {
        let data = ["name": "あんさんぶるスターズ",
                    "shortName": "あんスタ"] as [String: Any]
        let data2 = ["name": "ツイステッドワンダーランド",
                    "shortName": "ツイステ"] as [String: Any]
        
        firestore.collection("titles").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("登録完了")
        }
        
        firestore.collection("titles").addDocument(data: data2) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("登録完了")
        }
    }
    
    func get() {
        let docID = "9cbaU4q0GShHIzsKlokC"
        firestore.collection("titles").document(docID).getDocument { snap, error in
            if let error = error {
                print("エラーが発生しました")
                print("Error getting documents: \(error)")
            }
            
            guard snap != nil else { return }
        }
    }
    
    func sample2() {
        let datas = [
            ["firstName": "飛鷹","lastName": "北斗","nickname": ""],
            ["firstName": "明星","lastName": "スバル","nickname": ""],
            ["firstName": "遊木","lastName": "真","nickname": ""],
            ["firstName": "衣更","lastName": "真緒","nickname": ""],
            ["firstName": "天祥院","lastName": "英智","nickname": ""],
            ["firstName": "日々樹","lastName": "渉","nickname": ""],
            ["firstName": "伏見","lastName": "弓弦","nickname": ""],
            ["firstName": "姫宮","lastName": "桃李","nickname": ""],
            
            
        ] as [[String: Any]]
        
        for data in datas {
            firestore.collection("titles/9cbaU4q0GShHIzsKlokC/characters").addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("登録完了")
            }
        }
        
    }
    
    func sample3() {
        var titleID: String = ""
        print("実行")
        firestore.collection("titles").whereField("shortName", isEqualTo: "あんスタ").getDocuments() { snap, error in
            if let _ = error { return }
            guard let snap = snap else { return }
            for document in snap.documents {
                titleID = document.documentID
            }
            if titleID != "" {
                let data = ["titleID": titleID, "name": "イベコレ缶バッジ", "price": 440] as [String: Any]
                firestore.collection("products").addDocument(data: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    print("登録完了")
                }
            }
            
        }
        
        
    }
    
    func sample4() {
        let datas = [["type": "OFF SHOT"],
                     ["type": "IDOL SHOT"]
        ] as [[String: Any]]
        
        for data in datas {
            firestore
                .collection("products/3OswUW5hJF1Erzi3knDm/types")
                .addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("登録完了")
            }
        }
        
    }
    
    func sample5() {
        let datas = [["type": "OAirI577iXmy5JjaQgUT", "version": "vol.1"],
                     ["type": "OAirI577iXmy5JjaQgUT", "version": "vol.2"],
                     ["type": "OAirI577iXmy5JjaQgUT", "version": "vol.3"],
                     ["type": "OAirI577iXmy5JjaQgUT", "version": "vol.4"]
        ] as [[String: Any]]
        
        for data in datas {
            firestore
                .collection("products/3OswUW5hJF1Erzi3knDm/versions")
                .addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("登録完了")
            }
        }
    }
    
    /// 登録
    func registration() {
        
        
        let data = ["user" : "",
                    
                    "partner": ["name": "Aさん",
                                "account": "21cm0100_A",
                                "tool": "Twitter"],
                    
                    "status": ["type": "交換",
                               "method": "郵送",
                               "status": "予約"],
                    
                    "my": ["goodsID": "",
                           "characters":
                            ["character": "",
                             "count": ""]],
                    
                    "pair": ["goodsID": "",
                             "characters":
                              ["character": "",
                               "count": ""]],
                    
                    "memo": ""] as [String: Any]
        
        
        firestore.collection("trading").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("登録完了")
        }
    }
    
    
}
