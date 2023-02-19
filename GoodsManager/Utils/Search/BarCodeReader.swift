//
//  BarCodeReader.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import UIKit
import SwiftUI
import AVFoundation
import Foundation

/// バーコード読み取りクラス
struct BarCodeReader: UIViewRepresentable  {
    //カメラセッション
    private let session = AVCaptureSession()
    //読み取りイベント
    private let delegate = BarCodeReaderDelegate()
    //映像情報
    private let metadataOutput = AVCaptureMetadataOutput()
    
    /// 読み取りイベント設定
    func found(_ event: @escaping (String) -> Void) -> BarCodeReader {
        //読み取りイベントを設定する
        delegate.onFound = event
        return self
    }
    
    // 閉じるイベント設定
    func close(_ event: @escaping () -> Void) -> BarCodeReader {
        //閉じるイベントを設定する
        delegate.onClose = event
        return self
    }

    /// UIView作成処理
    func makeUIView(context: UIViewRepresentableContext<BarCodeReader>) -> BarcodeReadrUIView {
        //バーコード読み取り画面を作成
        let cameraView = BarcodeReadrUIView(session: session,delegate: self.delegate)
        //認証チェック
        checkCameraAuthorizationStatus(cameraView)
        return cameraView
    }

    /// UIView削除処理
    static func dismantleUIView(_ uiView: BarcodeReadrUIView, coordinator: ()) {
        //カメラ停止
        uiView.session.stopRunning()
    }
    
    func updateUIView(_ uiView: BarcodeReadrUIView, context: UIViewRepresentableContext<BarCodeReader>) {
    }

    /// 認証チェック
    private func checkCameraAuthorizationStatus(_ uiView: BarcodeReadrUIView) {
        //カメラ認証状態確認
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        if cameraAuthorizationStatus == .authorized {
            //認証されている場合はカメラセットアップ処理実行
            setupCamera(uiView)
        } else {
            // カメラへのアクセスを要求
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(uiView)
                    }
                }
            }
        }
    }
    
    /// カメラセットアップ
    func setupCamera(_ view: BarcodeReadrUIView) {
        // デバイスオブジェクトを生成（ワイドアングルカメラ・ビデオ・背面カメラを指定）
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back)

        // デバイスを取得
        let devices = discoverySession.devices
        
        //　該当するデバイスのうち最初に取得したものを利用する
        if let camera = devices.first {
            do {
                // カメラ設定
                let deviceInput = try AVCaptureDeviceInput(device: camera)
                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)

                    // カメラの映像からバーコードを検出するための設定
                    let metadataOutput = AVCaptureMetadataOutput()
                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)

                        //Outputイベント設定
                        metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                        
                        // TODO: 全部入れる
                        // 読み取りたいコードの種類を指定
                        metadataOutput.metadataObjectTypes = [.ean13]

                        // 読み取り可能エリアの設定を行う
                        metadataOutput.rectOfInterest = CGRect(x: view.y, y: 1 - view.x - view.width, width: view.height, height: view.width)

                        // カメラの映像を画面に表示するためのレイヤーを生成
                        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                        view.backgroundColor = UIColor.gray
                        previewLayer.videoGravity = .resizeAspectFill
                        view.layer.addSublayer(previewLayer)
                        view.previewLayer = previewLayer
                        
                        // 読み取り開始
                        self.session.startRunning()
                        
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
