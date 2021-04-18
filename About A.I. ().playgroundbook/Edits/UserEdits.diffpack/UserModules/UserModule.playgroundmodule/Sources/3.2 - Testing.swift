import SpriteKit
import Foundation
import PlaygroundSupport

public func testAI(){
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    var scene = AITester(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}

class AITester: SKScene, SKPhysicsContactDelegate{
    let background = Object(image: "background4").generateNode()
    let robot = Object(image: "realRobot", X:172, Y: -215).generateNode()
    let tree = Object(image: "tree", X:-76, Y: -60).generateNode()
    let objects = [
        Object(image: "realApple1",name: "apple", X: 22, Y: 52).generateNode(),
        Object(image: "realApple2",name: "apple", X: -70, Y: 105).generateNode(),
        Object(image: "realApple3",name: "apple", X: -172, Y: 35).generateNode(),
        Object(image: "realApple4",name: "apple", X: 55, Y: -55).generateNode(),
        Object(image: "realApple5",name: "apple", X: -205, Y: -103).generateNode(),
        Object(image: "realApple6",name: "apple", X: 20, Y: -126).generateNode(),
        Object(image: "realBug1",name: "bug",scale: 0.6, X: -108, Y: -3.4).generateNode(),
        Object(image: "realBug2",name: "bug",scale: 0.6, X: -16, Y: -43).generateNode(),
        Object(image: "realBug3",name: "bug",scale: 0.6, X: -137, Y: -120).generateNode(),
        
    ]
    let magnifier = DragableNode(image: "magnifier", nodeName: "magnifier", X: 83, Y: -248)
    
    var label = SKLabelNode(fontNamed: "Tough Love")
    
    var applesFound = 0
    var bugsFound = 0
    
    var baloon = Object(image: "remove", X: 176, Y:-62).generateNode()
    
    override func sceneDidLoad() {
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFit
        
        self.addChild(background)
        self.addChild(tree)
        self.addChild(robot)
        
        let font = #fileLiteral(resourceName: "Tough Love.ttf")
        CTFontManagerRegisterFontsForURL(font as CFURL, CTFontManagerScope.process, nil)
        label.fontName = "Tough Love"
        
        addObjects()
        
        self.addChild(magnifier)
        let circle = SKShapeNode(circleOfRadius: 5)
        circle.name = "magnifier"
        circle.fillColor = .clear
        circle.lineWidth = 0
        magnifier.addChildNode(node: circle)
        circle.position.y = 16
        circle.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        circle.physicsBody!.affectedByGravity = false
        circle.physicsBody!.categoryBitMask = 1
        circle.physicsBody!.collisionBitMask = 0
        circle.physicsBody!.contactTestBitMask = 2
        
        label.position = CGPoint(x: -165, y: -334)
        label.fontColor = .white
        self.addChild(label)
        label.text = "0"
        
        self.addChild(baloon)
        baloon.alpha = 0
    }
    
    func addObjects(){
        for object in objects{
            
            if object.name == "apple"{
                object.physicsBody = SKPhysicsBody(circleOfRadius: 5)
                object.physicsBody!.affectedByGravity = false
                object.physicsBody!.categoryBitMask = 2
                object.physicsBody!.collisionBitMask = 0
                object.physicsBody!.contactTestBitMask = 1
            }else{
                object.physicsBody = SKPhysicsBody(circleOfRadius: 10)
                object.physicsBody!.affectedByGravity = false
                object.physicsBody!.categoryBitMask = 2
                object.physicsBody!.collisionBitMask = 0
                object.physicsBody!.contactTestBitMask = 1
            }
            
            self.addChild(object)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("begun")
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        print(nodeA.name)
        let name = nodeA.name
        
        if name == "apple"{
            check()
            //baloon = Object(image: "count", X: 176, Y:-62).generateNode()
            baloon.texture = SKTexture(imageNamed: "count")
            print("achou uma maçã")
            applesFound += 1
            label.text = String(applesFound)
            nodeA.run(.fadeAlpha(by: -0.5, duration: 1))
        }else if name == "bug"{
            check()
            baloon.texture = SKTexture(imageNamed: "remove")
            //baloon = Object(image: "remove", X: 176, Y:-62).generateNode()
            bugsFound += 1
            print("vish, um bug")
            nodeA.run(.fadeOut(withDuration: 1))
        }
        
        nodeA.physicsBody = nil
        print(nodeB.name)
        
        if applesFound == 6 && bugsFound == 3{
            
            finish()
        }
        
    }
    
    func finish(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in
            baloon.texture = SKTexture(imageNamed: "amazing")
            magnifier.removeFromParent()
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [self] in
            
            let finishButton = Button(image: "finish", action: {goToNextPage()}, X: -85, Y: -70)
            finishButton.alpha = 0
            
            for object in objects{
                object.run(.fadeOut(withDuration: 2))
            }
            tree.run(.fadeOut(withDuration: 2))
            finishButton.run(.fadeIn(withDuration: 2.5))
            self.addChild(finishButton)
            
        })
        
    }
    
    func check(){
        if (bugsFound + applesFound) == 0{
            baloon.alpha = 1
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let t = touches.randomElement()!
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            print(location)
            
        }
}
}
