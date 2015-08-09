//
//  ViewController.swift
//  QRgenerator
//
//  Created by 猪野凌也 on 2015/05/13.
//  Copyright (c) 2015年 猪野凌也. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //テキストフィールドの文字列
    @IBOutlet weak var TextBox: UITextField!
    
    //QRコード画像
    @IBOutlet weak var QRCode: UIImageView!
    
    //ボタンが押されたときにQRコードを生成する処理
    @IBAction func generate(sender: UIButton){
        //Generateボタンをタップした場合キーボードを引っ込める
        self.view.endEditing(true)
        //QRコード作成用フィルター作成とパラメータ初期化
        let filter:CIFilter = CIFilter(name: "CIQRCodeGenerator")
        filter.setDefaults()
        //QRコードにエンコードしたいテキストボックスの文字列を用意
        let qrMsg = self.TextBox.text
        let data = qrMsg.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        //Core Imageコンテキストを取得して、CGimage→UIImageの変換
        let ciContext:CIContext = CIContext(options: nil)
        let cgimg:CGImageRef = ciContext.createCGImage(filter.outputImage, fromRect: filter.outputImage.extent())
        let qrImg:UIImage = UIImage(CGImage: cgimg, scale:0.2, orientation: UIImageOrientation.Up)!
        //UIImageViewの画像を更新(最近傍を使ってぼかしを無くしてから)
        self.QRCode.layer.magnificationFilter = kCAFilterNearest
        self.QRCode.image = qrImg
    }
    
    //テキストフィールド外をタップした場合キーボードを引っ込める
    @IBAction func tapScreen(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

