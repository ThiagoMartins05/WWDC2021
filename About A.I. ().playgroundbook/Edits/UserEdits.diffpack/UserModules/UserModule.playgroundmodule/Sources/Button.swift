
import SpriteKit
import PlaygroundSupport
import Foundation

public class Button: SKNode {
    var image = String()
    var scale = CGFloat()
    var X = CGFloat()
    var Y = CGFloat()
    
    var acao: (()->Void)?
    
    init(image: String, action: (() -> Void)? = nil, scale: CGFloat = 0.55, X: CGFloat = 0, Y: CGFloat = 0){
        super.init()
        self.acao = action//action
        self.image = image
        self.scale = scale
        self.X = X ?? 0
        self.Y = Y ?? 0
        self.position.y = Y
        self.position.x = X
        
        let node = SKSpriteNode(imageNamed: image)
        node.setScale(0.55)
        self.addChild(node)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetButtoAction(action: Selector){
        
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let action = self.acao else{return}
        action()
    }
}
