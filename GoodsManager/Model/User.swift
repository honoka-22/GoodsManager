//
//  User.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import FirebaseFirestoreSwift

struct  User: Identifiable, Decodable {
    let email: String               // ユーザーのメールアドレス
    let uid: String                 // ユーザーのID
    @DocumentID var id: String?     // ユーザーのID
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id}
}

