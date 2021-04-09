import SpriteKit
import PlaygroundSupport
import Foundation

public class Object{
    var image = String()
    var name = String()
    var scale = CGFloat()
    var X = CGFloat()
    var Y = CGFloat()
    
    
    init(image: String, name:String? = nil, scale: CGFloat = 0.55, X: CGFloat? = 0, Y: CGFloat? = 0) {
        self.image = image
        self.scale = scale
        self.X = X ?? 0
        self.Y = Y ?? 0
        
        if let Nodename = name{
            self.name = Nodename
        }
    }
    
    func generateNode() -> SKSpriteNode{
        let node = SKSpriteNode(imageNamed: image)
        node.setScale(scale)
        node.position.x = X
        node.position.y = Y
        node.name = name
        
        return node
    }
    
}



