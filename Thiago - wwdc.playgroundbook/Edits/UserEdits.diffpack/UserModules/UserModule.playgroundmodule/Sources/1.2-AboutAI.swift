import PlaygroundSupport
import SpriteKit
import Foundation

public func AboutAI(){
    
    
    class aboutScene:SKScene{
        
        var i = 0
        
        var firstTime = true
        let robot = SKSpriteNode(imageNamed: "robo_que_fala")
        var label = SKLabelNode()
        let baloon = SKSpriteNode(imageNamed: "balao_de_fala_1")
        let mouth = SKSpriteNode(imageNamed: "boca_robo")
        let eye = SKSpriteNode(imageNamed: "olho_robo")
        let background = SKSpriteNode(imageNamed: "background-2")
        
        override func sceneDidLoad() {
            self.backgroundColor = .black
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFit
            
            background.setScale(0.55)
            self.addChild(background)
            
            robot.setScale(0.5)
            robot.position.y = -166
            self.addChild(robot)
            
            eye.setScale(0.5)
            eye.position.y = -68
            eye.position.x = -63
            self.addChild(eye)
            
            baloon.setScale(0.55)
            baloon.position.y = 160
            self.addChild(baloon)
            
            addContinueButton(in: self)
            
            eye.run(.repeatForever(.sequence([
                .move(to: .init(x: -63, y: -68), duration: 2),
                .move(to: .init(x: 63, y: -68), duration: 2)
            ])))
            
            mouth.run(.repeatForever(.sequence([
                .fadeIn(withDuration: 0.5),
                .fadeOut(withDuration: 0.5)
            ])))
            
            mouth.setScale(0.5)
            mouth.position.y = -108
            self.addChild(mouth)
            

            
            
            label.verticalAlignmentMode = .center
            label.numberOfLines = 0
            label.preferredMaxLayoutWidth = 400
            label.position.y = 220
            
            let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
            
            self.addChild(label)
            
            typeText(label: label, text: text, timeForLetter: 0.1)
            
            
        }
        
        
        
        
        func addContinueButton(in scene: SKScene){
            let acao = { [self] in
                continueText()
            }
            let continueBtn = Button(image: "continueBtn", action: acao, X: 130, Y: 125)
            scene.addChild(continueBtn)
        }
        
        func continueText(){
            
            let text = ["1 - Lorem impusm dolor sit amte, consectur adipiscing elit, sed do eiusmod tempor incidunt", " 2 - Lorem impusm dolor sit amte, consectur adipiscing elit, sed do eiusmod tempor incidunt", "3 - Lorem impusm dolor sit amte, consectur adipiscing elit, sed do eiusmod tempor incidunt"]
            if text.count > i{
                typeText(label: label, text: text[i], timeForLetter: 0.1)
                i += 1
            }
            
            if text.count == i {
                ExamplesOfAI()
            }
            
            
        }
        
        
    } 
    
    
    
    
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    
    var scene = aboutScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}
