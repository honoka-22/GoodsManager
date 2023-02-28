//
//  PostTradingViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class PostTradingViewModel: ObservableObject {
    /// お相手様のお名前
    @Published var name = ""
    /// お相手様のアカウント名
    @Published var account = ""
    
    @Published var passItems = [PassItem]()
    @Published var giveItems = [GiveItem]()
    
    
    /// 取引ツール
    let tradingServices = ["Twitter", "メルカリ","LINE", "その他"]
    @Published var selectService = ""
    /// 取引タイプ ["交換", "譲渡", "買取", "交換+譲渡", "交換+買取"]
    let tradingTypes = ["交換", "譲渡", "買取", "交換+譲渡", "交換+買取"]
    @Published var selectType = ""
    /// 取引方法
    let tradingMethods = ["郵送", "手渡し", "未定"]
    @Published var selectMethod = ""
    
    let status = ["取引中", "予約", "完了"]
    @Published var selectStatus = ""
    
    /// お渡しする金額
    @Published var purchasePrice = 0
    /// 受け取る金額
    @Published var salesPrice = 0
    
    
    @Published var memo = ""
    
    /// 登録
    func registration() {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let userID = user.uid
        
        let partner = ["name": name,
                       "account" : account,
                       "tool": selectService] as [String: Any]
        
        let status = ["type": selectType,
                       "method": selectMethod,
                       "status": selectStatus] as [String: Any]
        
        
        var passGoods = [[String: Any]]()
        
        for passItem in passItems {
            var charactersCount = [[String: Any]]()
            for character in passItem.characters {
                let data = ["character" : character.id,
                            "count" : character.countNum] as [String: Any]
                charactersCount.append(data)
            }
            
            let passData = ["goodsID" : passItem.id,
                            "characters": charactersCount] as [String: Any]
            
            passGoods.append(passData)
        }
        
        var giveGoods = [[String: Any]]()
        
        for giveItem in giveItems {
            var charactersCount = [[String: Any]]()
            for character in giveItem.characters {
                let data = ["character" : character.id,
                            "count" : character.countNum] as [String: Any]
                charactersCount.append(data)
            }
            
            let giveData = ["goodsID" : giveItem.id,
                            "characters": charactersCount] as [String: Any]
            
            giveGoods.append(giveData)
        }
        
        let data = ["partner": partner,
                    "status": status,
                    "passGoods": passGoods,
                    "purchasePrice" : purchasePrice,
                    "giveGoods": giveGoods,
                    "salesPrice" : salesPrice,
                    "memo": memo] as [String: Any]
        
        let collectionID = "users/" + userID + "/tradings"
        firestore.collection(collectionID).addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("登録完了")
        }
    }
    
    
}
