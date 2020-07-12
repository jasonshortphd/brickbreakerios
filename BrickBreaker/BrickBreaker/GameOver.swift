import Foundation
import SpriteKit

extension GameScene
{
    func createGameOverView()
    {
        menuVisible = false
        gameOverVisible = true

        // We could show an ad here... But I sort of hate ads.
        
        darkerBackgroundRect = SKShapeNode(rectOf: self.frame.size)
        darkerBackgroundRect.position = CGPoint(x: 0, y: 0)
        darkerBackgroundRect.strokeColor = SKColor.black
        darkerBackgroundRect.fillColor = SKColor.black
        darkerBackgroundRect.alpha = 0.6
        darkerBackgroundRect.zPosition = 6
        darkerBackgroundRect.name = "darkerBackgroundRect"
        self.addChild(darkerBackgroundRect)
        
        menuRect = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: self.frame.height / 3))
        menuRect.position = CGPoint(x: 0, y: 0)
        menuRect.strokeColor = SKColor(red: 33/255, green: 61/255, blue: 79/255, alpha: 0.65)
        menuRect.lineWidth = 0
        menuRect.fillColor = SKColor(red: 33/255, green: 61/255, blue: 79/255, alpha: 0.65)
        menuRect.zPosition = 7
        menuRect.name = "menuRect"
        self.addChild(menuRect)
        
        quitButton = SKShapeNode(rectOf: CGSize(width: self.frame.width / 2.8, height: self.frame.height / 6))
        quitButton.position = CGPoint(x: -quitButton.frame.width * (7/12), y: 0)
        quitButton.strokeColor = SKColor(red: 100/255, green: 0, blue: 0, alpha: 1.0)
        quitButton.lineWidth = 10
        quitButton.fillColor = colorsSecondary[4]!
        quitButton.zPosition = 8
        quitButton.name = "quitButton"
        self.addChild(quitButton)
                
        endGameLabel = SKLabelNode(text: "QUIT")
        endGameLabel.position = CGPoint(x: quitButton.position.x, y: -endGameLabel.frame.height / 2)
        endGameLabel.fontSize = self.frame.width / 12
        endGameLabel.fontColor = SKColor(red: 144/255, green: 103/255, blue: 149/255, alpha: 1.0)
        endGameLabel.fontName = "Helvetica Neue Condensed Bold"
        endGameLabel.zPosition = 9
        endGameLabel.name = "endGameLabel"
        self.addChild(endGameLabel)
    }
    
    func deleteGameOverView()
    {
        // gets called when the user chose to watch a video ad to get one more chance
        gameOverVisible = false
        startGameTimer()
        
        //pauseButton.isHidden = false
        
        for child in self.children
        {
            if let box = child as? Brick
            {
                // Remove last couple rows and let player have one extra life?
                if box.rowsMoved >= 8
                {
                    box.removeFromParent()
                    for child in self.children
                    {
                        if box.contains(child.position)
                        {
                            child.removeFromParent()
                        }
                    }
                }
            }
        }
        // deleting the actual gameOverView
        darkerBackgroundRect.removeFromParent()
        menuRect.removeFromParent()
        quitButton.removeFromParent()
        endGameLabel.removeFromParent()
        oneMoreLabel.removeFromParent()
        chanceLabel.removeFromParent()
    }
}

