//
//  BarCodeReaderDelegate.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import Foundation
import AVFoundation

class BarCodeReaderDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    // 読み取りイベント
    var onFound: (String) -> Void = { _  in }
    // 閉じるイベント
    var onClose: () -> Void = { }
    
    // 読み取り設定
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // バーコードの内容が空かどうかの確認
            if metadata.stringValue == nil { continue }

            // 読み取ったデータの値
            print(metadata.type)
            print(metadata.stringValue!)
            
            // 読み取りイベント実行
            onFound(metadata.stringValue!)
        }
    }
}

