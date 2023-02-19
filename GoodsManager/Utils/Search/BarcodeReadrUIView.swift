//
//  BarcodeReadrUIView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI
import AVFoundation

/// バーコード読み取り画面
class  BarcodeReadrUIView: UIView {
    // カメラプレビューレイヤ
    var previewLayer: AVCaptureVideoPreviewLayer?
    // 映像セッション情報
    var session: AVCaptureSession
    // バーコードイベントクラス
    var delegate: BarCodeReaderDelegate
    
    let x: CGFloat = 0.1
    let y: CGFloat = 0.4
    let width: CGFloat = 0.8
    let height: CGFloat = 0.2
    
    //初期化処理
    init(session: AVCaptureSession, delegate: BarCodeReaderDelegate) {
        self.session = session
        self.delegate = delegate
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //レイアウト設定
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
        
        // 読み取り可能エリア
        let detectionArea = UIView()
        // 位置と大きさ
        detectionArea.frame = CGRect(
            x: self.frame.size.width * x,
            y: self.frame.size.height * y,
            width: self.frame.size.width * width,
            height: self.frame.size.height * height)
        // 枠線の色
        detectionArea.layer.borderColor = UIColor.red.cgColor
        // 枠線の太さ
        detectionArea.layer.borderWidth = 3
        // 表示
        self.addSubview(detectionArea)
        
        
        // 閉じるボタン
        let closeBtn:UIButton = UIButton()
        // 位置と大きさ
        closeBtn.frame = CGRect(x: 20, y: 20, width: 100, height: 40)
        // ボタンのテキスト
        closeBtn.setTitle("閉じる", for: UIControl.State.normal)
        // 背景色
        closeBtn.backgroundColor = UIColor.lightGray
        // 処理
        closeBtn.addTarget(self, action: #selector(onCloseEvent(sender:)), for: .touchUpInside)
        // 表示
        self.addSubview(closeBtn)
    }
    
    // 閉じるが押されたら呼ばれる
    @objc func onCloseEvent(sender: UIButton) {
        delegate.onClose()
    }
}
