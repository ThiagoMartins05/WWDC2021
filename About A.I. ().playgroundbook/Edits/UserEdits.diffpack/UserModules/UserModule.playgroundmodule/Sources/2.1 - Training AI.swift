import SpriteKit
import PlaygroundSupport
import Foundation


class trainingScene:SKScene, SKPhysicsContactDelegate {
    var board = SKSpriteNode(imageNamed: "board")
    var robot = SKSpriteNode(imageNamed: "applesRobot")
    var indice = Int()
    var apples = 4
    var bugs = 4
    var negatives = 4
    
    var Objects =  [
        //apples
        DragableNode(image: "apple1", nodeName: "apple", X: -164, Y: 242),
        DragableNode(image: "apple2", nodeName: "apple", X: 89, Y: 251),
        DragableNode(image: "apple3", nodeName: "apple", X: 177, Y: 194),
        DragableNode(image: "apple4", nodeName: "apple", X: 68, Y: 162),
        //bugs
        DragableNode(image: "bug1", nodeName: "bug", X: -27, Y: 172),
        DragableNode(image: "bug2", nodeName: "bug", X: -141, Y: 134),
        DragableNode(image: "bug3", nodeName: "bug", X: 8, Y: 251),
        DragableNode(image: "bug4", nodeName: "bug", X: 163, Y: 255),
        //negativeValues
        DragableNode(image: "neg1", nodeName: "neg", X: -78, Y: 240),
        DragableNode(image: "neg2", nodeName: "neg", X: -13, Y: 117),
        DragableNode(image: "neg3", nodeName: "neg", X: 119, Y: 144),
        DragableNode(image: "neg4", nodeName: "neg", X: 181, Y: 115)
    ]
    
    
    var robots = [
        
        Object(image: "applesRobot", name: "apple", X: -42 ,Y: -180 ),
        Object(image: "applesRobot", name: "apple", X: -42 ,Y: -180 ),
        Object(image: "bugsRobot", name: "bug", X: -42 ,Y: -180 ),
        Object(image: "bugsRobot", name: "bug", X: -42 ,Y: -180 ),
        Object(image: "negativeRobot", name: "neg", X: -42 ,Y: -180 ),
        Object(image: "bugsRobot", name: "bug", X: -42 ,Y: -180 ),
        Object(image: "negativeRobot", name: "neg", X: -42 ,Y: -180 ),
        Object(image: "bugsRobot", name: "bug", X: -42 ,Y: -180 ),
        Object(image: "applesRobot", name: "apple", X: -42 ,Y: -180 ),
        Object(image: "negativeRobot", name: "neg", X: -42 ,Y: -180 ),
        Object(image: "negativeRobot", name: "neg", X: -42 ,Y: -180 ),
        Object(image: "applesRobot", name: "apple", X: -42 ,Y: -180 ),
    ]
    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFit
        
        
        self.backgroundColor = .black
        board.setScale(0.55)
        self.addChild(board)
        board.position.y = 240
        
        getRobot()
        robot.setScale(0.52)
        robot.position.y = -180
        robot.position.x = -42
        robot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 350))
        robot.physicsBody!.affectedByGravity = false
        robot.physicsBody!.categoryBitMask = 2
        robot.physicsBody!.collisionBitMask = 0
        robot.physicsBody!.contactTestBitMask = 1
        
        self.addChild(robot)
        
        for object in Objects{
            object.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 20))
            object.physicsBody!.affectedByGravity = false
            object.physicsBody!.categoryBitMask = 1
            object.physicsBody!.collisionBitMask = 0
            object.physicsBody!.contactTestBitMask = 2
            self.addChild(object)
        }
        
    }
    
    
    func getRobot(){
        
        if robots.count == 0{
            //aqui é executado após todos os objetos terem sido comidos
            board.run(.fadeOut(withDuration: 2))
            DispatchQueue.main.asyncAfter(deadline: .now() + (2.5)){ [self] in
                board.removeFromParent()
            }
            robot.removeFromParent()
            let finalRobot = Object(image: "robotNoHead",scale: 0.52, X: 14, Y: -182).generateNode()
            self.addChild(finalRobot)
            
            let x = ((finalRobot.position.x) - (finalRobot.frame.width/4) - 9)
            let y = ((finalRobot.position.y) + (finalRobot.frame.height/2) - 5)
            let head = Object(image: "robotHead",scale: 0.52, X: x, Y: y).generateNode()
            
            
            self.addChild(head)
            head.color = .purple
            
            head.anchorPoint = CGPoint(x: 0.97, y: 0.96)
            head.run(.rotate(byAngle: -(.pi), duration: 3))
            
            let data = Object(image: "dataReceived", scale: 0.45, X:40, Y: (70)).generateNode()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                
                self.addChild(data)
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [self] in
                
                data.run(.moveBy(x: 0, y: 150, duration: 2.5))
                head.run(.moveBy(x: 0, y: 150, duration: 2.5))
                finalRobot.run(.moveBy(x: 0, y: 150, duration: 2.5))
                
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
                
                let action = {
                    goToNextPage()
                }
                let next = Button(image: "nextPage",action: action, Y: -250)
                self.addChild(next)
            }
            
            
            
            
        } 
        
        if robots.count > 0{
            let node = robots.first!
            robot.texture = SKTexture(imageNamed: node.image)
            robot.name = node.name
            robots.removeFirst()
        }
        
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        print(nodeA.name)
        print(nodeB.name)
        
        if let nameB = nodeB.name, let nameA = nodeA.name {
            
            if nameA == nameB{
                
                nodeB.removeFromParent()
                getRobot()
                
            }
        }
    }
}


public func TraineAI(){
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    var scene = trainingScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}


