//
//  GameScene.swift
//  FlappyBird
//
//  Created by 久保田 梨央 on 2023/05/15.
//

import SpriteKit

class GameScene: SKScene {
    
    var scrollNode:SKNode!
    
    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
//        背景色
        backgroundColor = UIColor(red: 0.15, green: 0.75, blue: 0.90, alpha: 1)
        
//        スクロールするスプライトの親ノード
        scrollNode = SKNode()
        addChild(scrollNode)
        
//        地面画像
        let groundTexture = SKTexture(imageNamed: "ground")
        groundTexture.filteringMode = .nearest
        
//        必要な枚数を計算
        let needNumber = Int(self.frame.size.width / groundTexture.size().width) + 2
        
//        スクロールするアクションを作成
//        左方向に画像一枚分スクロールさせるアクション
        let moveGround = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 5)
        
//        元の位置に戻すアクション
        let resetGround = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
        
//        左にスクロール->元の位置->左にスクロールと無限に繰り返すアクション
        let repeatScrollGround = SKAction.repeatForever(SKAction.sequence([moveGround, resetGround]))
        
//　　　　　groundのスプライトを配置する
        for i in 0..<needNumber {
                    let sprite = SKSpriteNode(texture: groundTexture)
        
//        テクスチャを指定してスプライトを作成
        let groundSprite = SKSpriteNode(texture: groundTexture)
        
//        スプライトの表示する位置を指定する
        groundSprite.position = CGPoint(
            x: groundTexture.size().width / 2 + groundTexture.size().width * CGFloat(i),
            y: groundTexture.size().height / 2
        )
            
//        スプライトにアクションを設定する
        sprite.run(repeatScrollGround)

//        シーンにスプライトを追加する
        scrollNode.addChild(groundSprite)
        }
    }
}
