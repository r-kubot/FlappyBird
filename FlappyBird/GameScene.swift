//
//  GameScene.swift
//  FlappyBird
//
//  Created by 久保田 梨央 on 2023/05/15.
//

import SpriteKit

class GameScene: SKScene {
    
    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
//        背景色
        backgroundColor = UIColor(red: 0.15, green: 0.75, blue: 0.90, alpha: 1)
        
//        地面画像
        let groundTexture = SKTexture(imageNamed: "ground")
        groundTexture.filteringMode = .nearest
        
//        テクスチャを指定してスプライトを作成
        let groundSprite = SKSpriteNode(texture: groundTexture)
        
//        スプライトの表示する位置を指定する
        groundSprite.position = CGPoint(
            x: groundTexture.size().width / 2,
            y: groundTexture.size().height / 2
        )

//        シーンにスプライトを追加する
        addChild(groundSprite)
    }
}

