
import PlaygroundSupport
import SpriteKit
import Foundation


public func Start(){
    class myScene: SKScene{
        let capaInicio = SKSpriteNode(imageNamed: "background-1")
        let startButton = SKSpriteNode(imageNamed: "startButton")
        let outerCircle = SKSpriteNode(imageNamed: "outerCircle")
        let innerCircle = SKSpriteNode(imageNamed: "innerCircle")
        
        override func sceneDidLoad() {
            initialConfig(scene: self)
            addBackground(image: capaInicio, scale: 0.54, scene: self)
            
            addAnimatedCircles()
            addStartButton(image: startButton, scale: 0.58, scene: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.addText()
            }
            
            
        }
        
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            let positionInScene = touch!.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name{
                if name == "start"{
                    AboutAI()
                    
                    for child in self.children{
                        child.removeFromParent()
                    }
                    
                }
            }
        }
        
        
        func addText(){
            let label = SKLabelNode()//(fontNamed: "Chalkduster")
            label.fontSize = 60
            label.fontColor = SKColor.cyan
            label.preferredMaxLayoutWidth = 330
            label.numberOfLines = 0
            label.verticalAlignmentMode = .center
            var texto = "The age of A.I."
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
    
    func addStartButton(image: SKSpriteNode,scale:CGFloat, scene:SKScene){
        let startButton = image
        startButton.setScale(scale)
        startButton.position.y = -250
        scene.addChild(startButton)
        startButton.name = "start"
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
    
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    
    var scene = myScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}
