import PlaygroundSupport
import SpriteKit
import Foundation
import UIKit

public func AboutAI(){
    class aboutScene:SKScene{
        
        override func sceneDidLoad() {
            self.backgroundColor = .red
        }
        
    } 
    
    
    
    
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    
    var scene = aboutScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}
