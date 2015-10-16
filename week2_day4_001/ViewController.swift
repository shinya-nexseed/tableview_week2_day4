//
//  ViewController.swift
//  week2_day4_001
//
//  Created by Shinya Hirai on 2015/10/15.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    // メンバーのデータを保持するグローバル変数を定義
    // 辞書データの定義 (Dictionary)
    var akira:[String:String] = [:]
    var ami:[String:String] = [:]
    var iyo:[String:String] = [:]
    var kenichiro:[String:String] = [:]
    var seiya:[String:String] = [:]
    var shinpei:[String:String] = [:]
    var shintaro:[String:String] = [:]
    
    var members:[[String:String]] = [[:]]
    
    var memberInfo:[String:String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 辞書データの定義と呼び出し
        var dict:[String:String] = ["キー１" : "値１", "キー２" : "値２"]
        println(dict["キー２"])
        
        // メンバーの変数を初期化 (データを入れる)
        // すべて辞書データ (Dictionary)
        akira = ["name" : "Akira Maeda", "age" : "25", "gender" : "male", "picture" : "akira.jpg"]
        
        ami = ["name" : "Ami Ohsugi", "age" : "28", "gender" : "female", "picture" : "ami.jpg"]
        
        iyo = ["name" : "Iyo Koda", "age" : "28", "gender" : "female", "picture" : "iyo.jpg"]
        
        kenichiro = ["name" : "Kenichiro Taniguchi", "age" : "22", "gender" : "male", "picture" : "kenichiro.jpg"]
        
        seiya = ["name" : "Seiya Tamura", "age" : "20", "gender" : "male", "picture" : "seiya.jpg"]
        
        shinpei = ["name" : "Shinpei Ohsugi", "age" : "28", "gender" : "male", "picture" : "shinpei.jpg"]
        
        shintaro = ["name" : "Migitama", "age" : "8", "gender" : "male", "picture" : "migitama.jpg"]
        
        // 辞書データを配列にまとめる
        members = [akira,ami,iyo,kenichiro,seiya,shinpei,shintaro]
        println(members[0]["name"])
        
        // 配列データは.countで配列の中にあるデータをカウントできる
        println(members.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // members配列のもつデータの数ぶんセルをつくる
        return members.count
    }
    
    // セルの設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // セルを定義
        var cell = UITableViewCell(style: .Default, reuseIdentifier: "CELL")
        
        cell.textLabel?.text = members[indexPath.row]["name"]
        // println(indexPath.row)
        
        
        // 画像設定
        var image = cropThumbnailImage(UIImage(named: members[indexPath.row]["picture"]!)!, w: 100, h: 100)
        
        cell.imageView?.image = image
        
        cell.imageView?.layer.borderColor = UIColor.grayColor().CGColor
        cell.imageView?.layer.borderWidth = 5
        cell.imageView?.layer.cornerRadius = 50
        cell.imageView?.layer.masksToBounds = true
        
        return cell
    }
    
    // セルの高さ
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    // セルが選択された時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("\(indexPath.row)行目のセルがタップされた")
        
        memberInfo = members[indexPath.row]
        
        performSegueWithIdentifier("showSVC", sender: nil)
    }
    
    // Segueで遷移するときの処理
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showSVC") {
            let sVC:SecondViewController = segue.destinationViewController as! SecondViewController
            
            // sVCのプロパティmemberInfoにアクセスしデータを受け渡す
            sVC.memberInfo = memberInfo
            
            println("memberInfoの値 = \(memberInfo)")
            println("sVC.memberInfoの値 = \(sVC.memberInfo)")
        }
    }
    
    
    func cropThumbnailImage(image :UIImage, w:Int, h:Int) ->UIImage
    {
        // リサイズ処理
        
        let origRef    = image.CGImage;
        let origWidth  = Int(CGImageGetWidth(origRef))
        let origHeight = Int(CGImageGetHeight(origRef))
        var resizeWidth:Int = 0, resizeHeight:Int = 0
        
        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSizeMake(CGFloat(resizeWidth), CGFloat(resizeHeight))
        UIGraphicsBeginImageContext(resizeSize)
        
        image.drawInRect(CGRectMake(0, 0, CGFloat(resizeWidth), CGFloat(resizeHeight)))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 切り抜き処理
        
        let cropRect  = CGRectMake(
            CGFloat((resizeWidth - w) / 2),
            CGFloat((resizeHeight - h) / 2),
            CGFloat(w), CGFloat(h))
        let cropRef   = CGImageCreateWithImageInRect(resizeImage.CGImage, cropRect)
        let cropImage = UIImage(CGImage: cropRef)
        
        return cropImage!
    }

}

