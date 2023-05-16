//
//  GameScene.swift
//  FlappyBird
//
//  Created by 久保田 梨央 on 2023/05/15.
//

import SpriteKit

class GameScene: SKScene {
    
    var scrollNode:SKNode!
    var wallNode:SKNode!
    var bird:SKSpriteNode!
    
// SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
//        背景色
        backgroundColor = UIColor(red: 0.15, green: 0.75, blue: 0.90, alpha: 1)
        
//        スクロールするスプライトの親ノード
        scrollNode = SKNode()
        addChild(scrollNode)
        
//        壁用のノード
        wallNode = SKNode()
        scrollNode.addChild(wallNode)
        
//        各種スプライトを生成する処理をメソッドに分割
        setupGround()
        setupCloud()
        setupWall()
        setupBird()
    }
    
    func setupGround() {
//        地面画像
        let groundTexture = SKTexture(imageNamed: "ground")
        groundTexture.filteringMode = .nearest
        
//       　必要な枚数を計算
        let needNumber = Int(self.frame.size.width / groundTexture.size().width) + 2
        
//       　スクロールするアクションを作成
//    　　　左方向に画像一枚分スクロールさせるアクション
        let moveGround = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 5)
        
//         元の位置に戻すアクション
        let resetGround = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
        
//         左にスクロール->元の位置->左にスクロールと無限に繰り返すアクション
        let repeatScrollGround = SKAction.repeatForever(SKAction.sequence([moveGround, resetGround]))
        
//         groundのスプライトを配置する
        for i in 0..<needNumber {
            let sprite = SKSpriteNode(texture: groundTexture)
            
//         テクスチャを指定してスプライトを作成
            let groundSprite = SKSpriteNode(texture: groundTexture)
            
//         スプライトの表示する位置を指定する
            groundSprite.position = CGPoint(
                x: groundTexture.size().width / 2 + groundTexture.size().width * CGFloat(i),
                y: groundTexture.size().height / 2
            )
            
//         スプライトにアクションを設定する
            sprite.run(repeatScrollGround)
            
//         シーンにスプライトを追加する
            scrollNode.addChild(groundSprite)
        }
    }
    
    func setupCloud() {
//        雲の画像を読み込む
        let cloudTexture = SKTexture(imageNamed: "cloud")
        cloudTexture.filteringMode = .nearest
        
//        必要な枚数を計算
        let needCloudNumber = Int(self.frame.size.width / cloudTexture.size().width) + 2
        
//        スクロールするアクションを作成
//        左方向に画像一枚分スクロールさせるアクション
        let moveCloud = SKAction.moveBy(x: -cloudTexture.size().width, y: 0, duration: 20)
        
//        元の位置に戻すアクション
        let resetCloud = SKAction.moveBy(x: cloudTexture.size().width, y: 0, duration: 0)
        
//       ↑を無限に繰り返す
        let repeatScrollCloud = SKAction.repeatForever(SKAction.sequence([moveCloud, resetCloud]))
        
//        スプライトを配置
        for i in 0..<needCloudNumber {
            let sprite = SKSpriteNode(texture: cloudTexture)
            sprite.zPosition = -100 // 一番後ろになるようにする
            
//        スプライトを表示する位置を指定
            sprite.position = CGPoint(
                x: cloudTexture.size().width / 2 + cloudTexture.size().width * CGFloat(i),
                y: self.size.height - cloudTexture.size().height / 2
            )
            
//        スプライトにアニメーションを設定
            sprite.run(repeatScrollCloud)
            
//        スプライトを追加
            scrollNode.addChild(sprite)
        }
    }
    
    func setupWall() {
        
//        壁の画像
        let wallTexture = SKTexture(imageNamed: "wall")
        wallTexture.filteringMode = .linear
        
//        移動距離を計算
        let movingDistance = self.frame.size.width + wallTexture.size().width
        
//        画面外まで移動するアクションを追加
        let moveWall = SKAction.moveBy(x: -movingDistance, y: 0, duration:4)
        
//        自身を取り除くアクションを作成
        let removeWall = SKAction.removeFromParent()
        
//        2つのアニメーションを順に実行するアクションを作成
        let wallAnimation = SKAction.sequence([moveWall, removeWall])
        
//        鳥の画像サイズを取得
        let birdSize = SKTexture(imageNamed: "bird_a").size()
        
//        鳥が通り抜ける隙間の大きさを鳥のサイズの４倍とする
        let slit_length = birdSize.height * 4
        
//        隙間位置の上下の振れ幅を60ptとする
        let random_y_range: CGFloat = 60
        
//        空の中央位置(y座標)を取得
        let groundSize = SKTexture(imageNamed: "ground").size()
        let sky_center_y = groundSize.height + (self.frame.size.height - groundSize.height) / 2
        
//        空の中央位置を基準として下側の壁の中央位置を取得
        let under_wall_center_y = sky_center_y - slit_length / 2 - wallTexture.size().height / 2
        
//        壁を生成するアクションを作成
        let createWallAnimation = SKAction.run({
//            壁をまとめるノードを作成
            let wall = SKNode()
            wall.position = CGPoint(x: self.frame.size.width + wallTexture.size().width / 2, y: 0)
            wall.zPosition = -50 // 雲より手前、地面より奥

//            下側の壁の中央位置にランダム値を足して、下側の壁の表示位置を決定
            let random_y = CGFloat.random(in: -random_y_range...random_y_range)
            let under_wall_y = under_wall_center_y + random_y
            
//            下側の壁を作成
            let under = SKSpriteNode(texture: wallTexture)
            under.position = CGPoint(x: 0, y: under_wall_y)
            
//            壁をまとめるノードに下側の壁を追加
            wall.addChild(under)
            
//            上側の壁を作成
            let upper = SKSpriteNode(texture: wallTexture)
            upper.position = CGPoint(x: 0, y: under_wall_y + wallTexture.size().height + slit_length)
            
//            壁をまとめるノードに上側の壁を追加
            wall.addChild(upper)
            
//            壁をまとめるノードにアニメーションを設定
            wall.run(wallAnimation)
            
//            壁を表示するノードに今回作成した壁を追加
            self.wallNode.addChild(wall)
        })
        
//        次の壁作成までの時間まちのアクションを作成
        let waitAnimation = SKAction.wait(forDuration: 2)
        
//        壁を作成→時間待ち→壁を作成を無限に繰り返すアクションを作成
        let repeatForeverAnimation = SKAction.repeatForever(SKAction.sequence([createWallAnimation, waitAnimation]))
        
//        壁を表示するノードに壁の作成を無限に繰り返すアクションを設定
        wallNode.run(repeatForeverAnimation)
    }
    
    func setupBird() {
//        鳥の画像を2種類読み込む
        let birdTextureA = SKTexture(imageNamed: "bird_a")
        birdTextureA.filteringMode = .linear
        let birdTextureB = SKTexture(imageNamed: "bird_b")
        birdTextureB.filteringMode = .linear
        
//        2種類のテクスチャを交互に変更するアニメーションを作成
        let texturesAnimation = SKAction.animate(with: [birdTextureA, birdTextureB], timePerFrame: 0.2)
        let flap = SKAction.repeatForever(texturesAnimation)
        
//        スプライトを作成
        bird = SKSpriteNode(texture: birdTextureA)
        bird.position = CGPoint(x: self.frame.size.width * 0.2, y:self.frame.size.height * 0.7)
        
//        アニメーションを設定
        bird.run(flap)
        
//        スプライトを追加
        addChild(bird)
            
    }
}
