
import PlaygroundSupport
import SpriteKit
import Foundation


    class exampleScene:SKScene{
        
        var currentText = [String]()
        var textIndex = 0
        
        let baloon = Object(image: "balao_de_fala_2", Y: 230)
        
        let label = SKLabelNode()
        var firstTime = true
        //var isReading = true
        
        let nextPageBtn = Button(image: "nextPage", Y: -300)
        
        let continueBtn = Button(image: "continueBtn", X: 130, Y: 145)
        
        override func sceneDidLoad() {
            
            let florest = Button(image: "trees", action: {self.applesAction()}, scale: 0.5,X: -115, Y: 20)
            let health = Button(image: "health", action: {self.healthAction()}, scale: (0.5), X: 115, Y: 20)
            let car = Button(image: "car",action: {self.carsAction()}, scale: 0.5, X: 115, Y: -165)
            let gps = Button(image: "gps",action: {self.gpsAction()}, scale: 0.5, X: -115, Y: -165)
            
            self.backgroundColor = .black
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFit
            
            self.addChild(baloon.generateNode())
            self.addChild(florest)
            self.addChild(health)
            self.addChild(gps)
            self.addChild(car)
            
            let font = #fileLiteral(resourceName: "Tough Love.ttf")
            CTFontManagerRegisterFontsForURL(font as CFURL, CTFontManagerScope.process, nil)
            label.fontName = "Tough Love"
            
            label.position.y = 230
            label.preferredMaxLayoutWidth = 400
            label.numberOfLines = 0
            label.text = "Do you know in wich of these situations Artificial Intelligence can be used?"
            label.verticalAlignmentMode = .center
            
            self.addChild(label)
            self.addChild(continueBtn)
            let acao = { [self] in
                continueText()
            }
            
            self.addChild(nextPageBtn)
            continueBtn.acao =  acao
            continueBtn.isHidden = true
            nextPageBtn.isHidden = true
            nextPageBtn.acao = {goToNextPage()}
        }
        
        func healthAction(){
            textIndex = 0
            continueBtn.isHidden = false
            var healthText = [
                "In health care, A.I. can be a key for early diagnosis of some diseases,...", "...and even discover new medicines"
            ]
            //isReading = true
            
            
            if firstTime {
                healthText = FirstTime(text: healthText)
            }
            currentText = healthText
            
            continueText()
            
        }
        
        
        
        func gpsAction(){
            textIndex = 0
            continueBtn.isHidden = false
            //isReading = true
            var gpsText = [
                "On the gps, A.I. can be used to find the shortest route to your destination"
                //"It's also used to find a restaurant next to you, for example"
            ]
            
            
            if firstTime {
                gpsText = FirstTime(text: gpsText)
            }
            currentText = gpsText
            
            continueText()
            //typeText(label: label, text: currentText[0], timeForLetter: 0.08)
            //textIndex = 1
        }
        
        
        func applesAction(){
            textIndex = 0
            continueBtn.isHidden = false
            //isReading = true
            var applesText = [
                "On farms, A.I. can be used to inspect the fruits health, detect bugs, etc"
            ]
            
            
            if firstTime {
                applesText = FirstTime(text: applesText)
            }
            currentText = applesText
            
            continueText()
            
            }
        
        
        func carsAction(){
            textIndex = 0
            
            var carsText = [
            "On the automation, A.I. can be used in autonomous vehicles"
            ]
            if firstTime {
                carsText = FirstTime(text: carsText)
            }
            
            currentText = carsText
            
            continueText()
            
            textIndex = 1
        }
        
        func FirstTime(text: [String]) -> [String]{
            let text = ["You are right!"] + text + 
                ["But... Surprise! A.I. can also be used in the others situations...",
                 "...you can explore it, clicking on different images, or go to the next page"]
            firstTime = false
            return text
        }
        
        
        func continueText(){
            //if isReading{
                if currentText.count > textIndex{
                    typeText(label: label, text: currentText[textIndex], timeForLetter: 0.08)
                    textIndex += 1
                    nextPageBtn.isHidden = true
                    continueBtn.isHidden = true
                    
                    
                    if currentText.count != (textIndex){
                        DispatchQueue.main.asyncAfter(deadline: .now() + (Double(currentText[textIndex-1].count)*0.08)) { [self] in
                            continueBtn.isHidden = false
                        }
                    }
                    
                    
                    print(currentText.count)
                    print(textIndex)
                    
                }
            
            
                
                
                
                if (currentText.count) == textIndex {
                    textIndex = 0
                    //isReading = false
                    continueBtn.isHidden = true
                    nextPageBtn.isHidden = false
                }
            }
            
        //}
        
    }






public func ExamplesOfAI(){
    
    var view = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 518, height: 717)))
    
    var scene = exampleScene(size: view.frame.size)
    view.presentScene(scene)
    PlaygroundPage.current.setLiveView(view)
}
