
import PlaygroundSupport
import SpriteKit
import Foundation
import AVFoundation

public func Start(){
    class myScene: SKScene{
        
        let capaInicio = SKSpriteNode(imageNamed: "background-1")
        //let startButton = SKSpriteNode(imageNamed: "startButton")
        let outerCircle = SKSpriteNode(imageNamed: "outerCircle")
        let innerCircle = SKSpriteNode(imageNamed: "innerCircle")
        
        override func sceneDidLoad() {
            initialConfig(scene: self)
            addBackground(image: capaInicio, scale: 0.54, scene: self)
            
            addAnimatedCircles()
            addStartButton(image: "startButton", scene: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.addText()
            }
            
        }
        
        func addText(){
            let font = #fileLiteral(resourceName: "Tough Love.ttf")
            CTFontManagerRegisterFontsForURL(font as CFURL, CTFontManagerScope.process, nil)
            
            let label = SKLabelNode(fontNamed: "Tough Love")
            //print(font.absoluteString)
            //label.fontName = font
            label.fontSize = 50
            label.fontColor = SKColor.cyan
            label.preferredMaxLayoutWidth = 330
            label.numberOfLines = 0
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .center
            var texto = "About A.I. ( )"
            self.addChild(label)
            typeText(label: label, text: texto, timeForLetter: 0.15)
        }
        
        
        
        func addAnimatedCircles(){
            
            outerCircle.setScale(0.54)
            makeRotateForever(for: outerCircle, for: 45, clockwise: true)
            self.addChild(outerCircle)
            
            innerCircle.setScale(0.54)
            makeRotateForever(for: innerCircle, for: 45, clockwise: false)
            self.addChild(innerCircle)
        }
    }
    
    func initialConfig(scene: SKScene){
        scene.backgroundColor = .black
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFit
        
    }
    
    func addBackground(image: SKSpriteNode,scale:CGFloat, scene:SKScene){
        image.setScale(scale)
        scene.addChild(image)
    }
    
    func addStartButton(image: String, scene:SKScene){
        
        let action = {
            goToNextPage()
        }
        let startButton = Button(image: image, action: action, Y: -250)
        scene.addChild(startButton)
    }
    
    
    
    
    func makeRotateForever(for node: SKSpriteNode, for duration: TimeInterval, clockwise: Bool){
        if clockwise{
            let rotation = SKAction.rotate(byAngle: (.pi * 2), duration: duration)
            let repeatForever = SKAction.repeatForever(rotation)
            node.run(repeatForever)
        }else{
            let rotation = SKAction.rotate(byAngle: (.pi * -2), duration: duration)
            let repeatForever = SKAction.repeatForever(rotation)
            node.run(repeatForever)
        }
        
        
    }
    
    func typeSound(){
        //let player = try! AVAudioPlayer(data: 
        
        let player = try! AVAudioPlayer(contentsOf:#fileLiteral(resourceName: "typeEffect.m4a"))
        player.numberOfLoops = 1
        player.averagePower(forChannel: 100)
        player.play()
        
    }
    
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    
    var scene = myScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}

