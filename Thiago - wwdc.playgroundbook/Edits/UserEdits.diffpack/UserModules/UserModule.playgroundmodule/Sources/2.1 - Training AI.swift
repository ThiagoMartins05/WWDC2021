import SpriteKit
import PlaygroundSupport
import Foundation


class trainingScene:SKScene {
    var board = SKSpriteNode(imageNamed: "noApplesBoard")
    var robot = SKSpriteNode(imageNamed: "applesRobot")
    
    var apples = 4
    var bugs = 4
    var negatives = 4
    
    var applesObjects =  [
        //apples
        Object(image: "apple1", name: "apple", X: -164, Y: 242),
        Object(image: "apple2", name: "apple", X: 89, Y: 251),
        Object(image: "apple3", name: "apple", X: 177, Y: 194),
        Object(image: "apple4", name: "apple", X: 68, Y: 162),
    ]
    
    var bugsObjects = [
        //bugs
        Object(image: "bug1", name: "bug", X: -27, Y: 172),
        Object(image: "bug2", name: "bug", X: -141, Y: 134),
        Object(image: "bug3", name: "bug", X: 8, Y: 251),
        Object(image: "bug4", name: "bug", X: 163, Y: 255),
    ]
    
    var negativesObjects = [
        //negativeValues
        Object(image: "neg1", name: "neg", X: -78, Y: 240),
        Object(image: "neg2", name: "neg", X: -13, Y: 117),
        Object(image: "neg3", name: "neg", X: 119, Y: 144),
        Object(image: "neg4", name: "neg", X: 181, Y: 115)
    ]
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let t = touches.randomElement()!
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            //drag the column and the roof
            
            
            if let name = node.name{
                
                if name == "apple" && apples > 0{
                    node.position.x = location.x
                    node.position.y = location.y
                }
                if name == "bug" && apples == 0{
                    node.position.x = location.x
                    node.position.y = location.y
                }
                
                if name == "neg" && bugs == 0{
                    node.position.x = location.x
                    node.position.y = location.y
                }
            }
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch!.location(in: self)
        let touchedNode = self.atPoint(location)
        
        if let name = touchedNode.name{
            
            
            //nao precisa ter o if do nome, coloquei pq ainda não fiz a condição de ser um por vez
            if (Int(location.y) > -70 && Int(location.y) < 30 && Int(location.y) > -85 && Int(location.x)  < 115){
                touchedNode.removeFromParent()
                
                if name == "apple"{
                    apples -= 1
                    
                    if apples == 0 {
                        for bugs in bugsObjects{
                            let node = bugs.generateNode()
                            self.addChild(node)
                        }
                        
                        board.texture = SKTexture(imageNamed: "noBugsBoard")
                        robot.texture = SKTexture(imageNamed: "bugsRobot")
                    }
                }
                if name == "bug"{
                    bugs -= 1
                    
                    if bugs == 0 {
                        for negative in negativesObjects{
                            let node = negative.generateNode()
                            self.addChild(node)
                        }
                        
                        board.texture = SKTexture(imageNamed: "board")
                        robot.texture = SKTexture(imageNamed: "negativeRobot")
                    }
                }
                if name == "neg"{
                    negatives -= 1
                    
                    if negatives == 0{
                        
                        //aqui é onde termina
                        
                    }
                }
            }
            
            
            
            print(apples)
            print(bugs)
            print(negatives)
        }
    }
    
    
    
    
    override func sceneDidLoad() {
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFit
        
        
        self.backgroundColor = .black
        board.setScale(0.55)
        self.addChild(board)
        board.position.y = 240
        
        let node = SKShapeNode(rectOf: CGSize(width: 200, height: 100))
        node.position.x = 15
        node.position.y = -20
        node.fillColor = .red
        self.addChild(node)
        
        
        
        
        robot.setScale(0.52)
        robot.position.y = -180
        robot.position.x = -42
        
        
        self.addChild(robot)
        
        for apple in applesObjects{
            let node = apple.generateNode()
            self.addChild(node)
        }
    }
}



public func TraineAI(){
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    
    var scene = trainingScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}
    

