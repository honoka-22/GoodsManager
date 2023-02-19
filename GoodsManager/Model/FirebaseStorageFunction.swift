//
//  FirebaseStorageFunction.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import FirebaseStorage
import UIKit

class FirebaseStorageFunction {
    let reference = Storage.storage().reference()
    
    func uploadImage(image: UIImage, path: String, id: String,
                     completion: @escaping (String?) -> ()) {
        // 画像を.jpegData()メソッドでData型にする
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("画像が変換できませんでした")
            completion(nil)
            return
        }
        
        let riversRef = reference.child(path + "/" + id + ".jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        riversRef.putData(imageData, metadata: metadata) { metadata, error in
            if let _ = error { return }
            riversRef.downloadURL() { url, error in
                guard let url = url else { return }
                let urlString = url.absoluteString
                completion(urlString)
            }
        }
    }
    
    func uploadImages(images: [UIImage], uid: String, id: String,
                     completion: @escaping ([String]?) -> ()) {
        
        var urlStrings = [String]()
        if images.count == 0 { completion(urlStrings) }
        var number = 1
        var imageCount = images.count
        for image in images {
            
            uploadImage(image: image, path: uid + "/" + id, id: id + String(number)) { urlString in
                guard let urlString = urlString else {
                    imageCount -= 1
                    return
                }
                urlStrings.append(urlString)
                
                
                if urlStrings.count == imageCount {
                    print("アップロードが完了しました")
                    completion(urlStrings)
                }
            }
            number += 1
            
        }
    }
}
