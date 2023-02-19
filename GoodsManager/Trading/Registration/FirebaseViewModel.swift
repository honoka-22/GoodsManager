//
//  FirebaseViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/02.
//

import Foundation
import SwiftUI
import Firebase

class FirebaseViewModel: ObservableObject {
    @Published var titles = [Title]()
    @Published var characters = [Character]()
    @Published var checkCharacters = [CheckCharacter]()
    let firebase = FirebaseFunction()


    
    func showCheckItem() {
        for checkCharacter in checkCharacters {
            if checkCharacter.isChecked {
                print(checkCharacter.name)
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









