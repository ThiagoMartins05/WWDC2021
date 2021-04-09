
import PlaygroundSupport
import SpriteKit
import Foundation

public func ExamplesOfAI(){
    class exampleScene:SKScene{
        let baloon = SKSpriteNode(imageNamed:"balao_de_fala_2")
        let florest = SKSpriteNode(imageNamed:"threes")
        let health = SKSpriteNode(imageNamed:"health")
        let car = SKSpriteNode(imageNamed:"car")
        let photos = SKSpriteNode(imageNamed:"photos")
        
        override func sceneDidLoad() {
            self.backgroundColor = .black
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFit
            
            baloon.setScale(0.55)
            baloon.position.y = 230
            self.addChild(baloon)
            
            florest.setScale(0.5)
            florest.position.x = -115
            florest.position.y = 10
            florest.name = "florest"
            self.addChild(florest)
            
            health.setScale(0.5)
            health.position.x = 115
            health.position.y = 10
            health.name = "health"
            self.addChild(health)
            
            photos.setScale(0.5)
            photos.position.x = -115
            photos.position.y = -180
            photos.name = "photos"
            self.addChild(photos)
            
            car.setScale(0.5)
            car.position.x = 115
            car.position.y = -180
            car.name = "car"
            self.addChild(car)
            
        }
        
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            let positionInScene = touch!.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name{
                //print(name)
            }
        }
        
        
        
    }
    
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    
    var scene = exampleScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}
