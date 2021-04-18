
import SpriteKit
import PlaygroundSupport
import Foundation

public class DragableNode: SKNode {
    var image = String()
    var nodeName = String()
    var scale = CGFloat()
    var X = CGFloat()
    var Y = CGFloat()
    
    init(image: String, nodeName: String, scale: CGFloat = 0.55, X: CGFloat = 0, Y: CGFloat = 0){
        super.init()
        self.image = image
        self.scale = scale
        self.X = X ?? 0
        self.Y = Y ?? 0
        self.nodeName = nodeName
        self.position.y = Y
        self.position.x = X
        
        let node = SKSpriteNode(imageNamed: image)
        node.setScale(0.55)
        node.name = nodeName
        
        self.addChild(node)
        
        self.name = nodeName
        self.isUserInteractionEnabled = true
    }
    
    func addChildNode(node: SKNode){
        self.addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // fazer a lógica de drag
        for touch in touches{
            let t = touches.randomElement()!
            let location = touch.location(in: self.parent ?? self)
            let node: SKNode = self.atPoint(location)
            
            self.position.x = location.x
            self.position.y = location.y
        }
    }
}
