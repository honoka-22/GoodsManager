//
//  Title.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/01.
//

import FirebaseFirestoreSwift

struct Title: Identifiable, Decodable {
    let id: String
    var name: String       // 作品名
    var shortName: String   // 略称
}

struct Character: Identifiable, Decodable {
    let id: String
    var firstName: String = ""
    var lastName: String = ""
    var nickname: String  = ""
 }

struct Groups: Identifiable, Decodable {
    @DocumentID var id: String?
    /// 作品名
    var title: Title
    /// グループ名
    var name: String
    /// 所属キャラ
    var characters: [Character]
}
