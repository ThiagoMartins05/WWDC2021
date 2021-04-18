import SpriteKit
import PlaygroundSupport
import Foundation


class commandsScene:SKScene {
    let phrase = Object(image: "ifYouFind", X: -15,Y: 317).generateNode()
    let robot = Object(image: "robot", X: 0,Y: -417).generateNode()
    let doubt = Object(image: "doubt", X: 0,Y: -215).generateNode()
    
    
    let appleCase = Object(image: "appleCase",scale: 0.5, X: -175, Y: 230).generateNode()
    let appleFunc = Object(image: "appleFunc",scale: 0.5, X: 177, Y: -120).generateNode()
    var moveAppleLine = false
    var connectedAppleLine = false
    var appleLine = SKShapeNode()
    
    
    let bugCase = Object(image: "bugCase",scale: 0.5, X: -190, Y: 55).generateNode()
    let bugFunc = Object(image: "bugFunc",scale: 0.5, X: 142, Y: 230).generateNode()
    var moveBugLine = false
    var connectedBugLine = false
    var bugLine = SKShapeNode()
    
    
    let negativeCase = Object(image: "negativeCase",scale: 0.5, X: -150, Y: -120).generateNode()
    let negativeFunc = Object(image: "negativeFunc",scale: 0.5, X: 160, Y: 55).generateNode()
    var moveNegativeLine = false
    var connectedNegativeLine = false
    var negativeLine = SKShapeNode()
    
    override func sceneDidLoad() {
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFit
        self.backgroundColor = .black
        
        self.addChild(appleCase)
        self.addChild(appleFunc)
        
        self.addChild(appleLine)
        appleLine.strokeColor = .green
        appleLine.lineWidth = 5
        appleLine.lineCap = .round
        
        self.addChild(bugCase)
        self.addChild(bugFunc)
        
        self.addChild(bugLine)
        bugLine.strokeColor = .purple
        bugLine.lineWidth = 5
        bugLine.lineCap = .round
        
        
        self.addChild(negativeCase)
        self.addChild(negativeFunc)
        
        self.addChild(negativeLine)
        negativeLine.strokeColor = .red
        negativeLine.lineWidth = 5
        negativeLine.lineCap = .round
        
        self.addChild(phrase)
        phrase.run(.repeatForever(.sequence([
            .fadeAlpha(by: -0.5, duration: 2),
            .fadeAlpha(by: 0.5, duration: 2),
        ])))
        
        self.addChild(robot)
        self.addChild(doubt)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let t = touches.randomElement()!
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            print(location)
            
                //AppleObject
            if location.x > -120 && location.x < -102 && location.y < 235 && location.y > 217{
                
                if !connectedAppleLine{
                    moveAppleLine = true
                }
                print("clicou")
            }
            
            //BugObject
            if location.x > -151 && location.x < -135 && location.y < 60 && location.y > 45{
                
                if !connectedBugLine{
                    moveBugLine = true
                }
                print("clicou")
            }
            
            //NegativeObject
            if location.x > -77 && location.x < -55 && location.y < -104  && location.y > -136{
                
                if !connectedNegativeLine{
                    moveNegativeLine = true
                }
                print("clicou")
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let t = touches.randomElement()!
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            print(location)
            //AppleFunc
            if location.x > 108 && location.x < 125 && location.y < -113 && location.y > -129{
                connectedAppleLine = true
            }
            if !connectedAppleLine{
                appleLine.path = nil
            }
            
            
            //ObjectFunc
            if location.x > 38 && location.x < 52 && location.y < 236 && location.y > 220{
                connectedBugLine = true
            }
            if !connectedBugLine{
                bugLine.path = nil
            }
            
            //NegativeFunc
            if location.x > 67 && location.x < 99 && location.y < 70 && location.y > 48{
                connectedNegativeLine = true
            }
            if !connectedNegativeLine{
                negativeLine.path = nil
            }
            
            //MakeAllLinesNotMove
            moveAppleLine = false
            moveBugLine = false
            moveNegativeLine = false
            
            checkTheStatus()
        }
    }
    
    func checkTheStatus(){
        if connectedAppleLine, connectedBugLine, connectedNegativeLine{
            doubt.removeFromParent()
            robot.run(.moveBy(x: -145, y: 0, duration: 1))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                let gotIt = Object(image: "gotIt",scale: 0.5, X: -17, Y: -220).generateNode()
                let nextButton = Button(image: "nextPage", action: {goToNextPage()}, X: 137, Y: -320)
                self.addChild(nextButton)
                self.addChild(gotIt)
                nextButton.alpha = 0
                gotIt.alpha = 0
                
                gotIt.run(.fadeIn(withDuration: 1))
                nextButton.run(.fadeIn(withDuration: 1.5))
            })
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let t = touches.randomElement()!
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            if moveAppleLine{
                let path = CGMutablePath()
                path.move(to: CGPoint(x: -110, y: 225))
                path.addLine(to: location)
                appleLine.path = path
            }
            
            
            if moveBugLine{
                let path = CGMutablePath()
                path.move(to: CGPoint(x: -143, y: 55))
                path.addLine(to: location)
                bugLine.path = path
            }
            
            if moveNegativeLine{
                let path = CGMutablePath()
                path.move(to: CGPoint(x: -61, y: -120))
                path.addLine(to: location)
                negativeLine.path = path
            }
            
        }
    }
    
    
}



public func DefineCommands(){
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    var scene = commandsScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}

extension SKShapeNode {
    convenience init(start: CGPoint,
                     end: CGPoint,
                     strokeColor: UIColor,
                     lineWidth: CGFloat) {
        self.init()
        
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)
        
        self.path = path
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
    }
}
