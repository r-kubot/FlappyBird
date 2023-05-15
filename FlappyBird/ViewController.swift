//
//  ViewController.swift
//  FlappyBird
//
//  Created by 久保田 梨央 on 2023/05/15.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        SKViewに型変換
        let skView = self.view as! SKView
        
//        FPSの表示
        skView.showsFPS = true
        
//        ノード数の表示
        skView.showsNodeCount = true
        
//        ビューと同サイズのシーンの作成
        let scene = GameScene(size:skView.frame.size) // ←GameSceneクラスに変更する
        
//        ビューにシーンを表示
        skView.presentScene(scene)
    }


}

