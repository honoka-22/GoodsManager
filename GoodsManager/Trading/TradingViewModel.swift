//
//  TradingRegistrationViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import Foundation
import SwiftUI
import Firebase

class TradingViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    
    @Published var tradings = [Trading]()
    var nowTradings = [Trading]()
    var reservations = [Trading]()
    var completeds = [Trading]()
    
    @Published var selectTrading: Trading?
    @Published var passGoods = [PassItem]()
    @Published var giveGoods = [PassItem]()
    
    init() {
        getTradings()
    }
    
    func getTradings() {
        firebase.getTradings(){ tradings, error in
            if let _ = error { return }
            guard let tradings = tradings else { return }
            for trading in tradings {
                let status = trading.status.status
                if status == "取引中" {
                    self.nowTradings.append(trading)
                }
                if status == "予約" {
                    self.reservations.append(trading)
                }
                if status == "完了" {
                    self.completeds.append(trading)
                }
            }
            self.tradings = (self.nowTradings + self.reservations + self.completeds)
        }
    }
    
    func allTradings(select: Int) {
        switch select {
        case 1:
            tradings = nowTradings
            break;
        case 2:
            tradings = reservations
            break;
        case 3:
            tradings = completeds
            break;
        default: tradings = (nowTradings + reservations + completeds)
        }
    }
    
    func getTrading(trading: Trading) {
        passGoods.removeAll()
        giveGoods.removeAll()
        getGoods(goodsData: trading.passGoods, type: .pass)
        getGoods(goodsData: trading.giveGoods, type: .give)
        
    }
    
    enum tradingType {
        case pass
        case give
    }
    
    func getGoods(goodsData: [[String: Any]], type: tradingType) {
        
        for goodsItem in goodsData {
            guard let id = goodsItem["goodsID"] as? String else { continue }
            
            firebase.getGoods(id: id) { goods in
                guard let goods = goods else { return }
                var items = PassItem(id: id, goodsData: goods.base)
                if let characters = goodsItem["characters"] as? [[String: Any]] {
                    var num = characters.count
                    for character in characters {
                        guard let characterID =
                                character["character"] as? String else {
                            num -= 1
                            continue
                        }
                        guard let count =
                                character["count"] as? Int else {
                            num -= 1
                            continue
                        }
                        guard let title = goods.base.title else {
                            num -= 1
                            continue
                        }
                        
                        self.firebase.getCharacter(titleID: title.id, id: characterID) { character in
                            
                            guard let character = character else {
                                return
                            }
                            let item = PassCharacter(id: characterID,
                                                     name: character.lastName,
                                                     countNum: count)
                            items.characters.append(item)
                            if num == items.characters.count {
                                switch type {
                                case .pass:
                                    self.passGoods.append(items)
                                case .give:
                                    self.giveGoods.append(items)
                                }
                                
                            }
                        }
                    }
                }
            }
        }
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
    
}
