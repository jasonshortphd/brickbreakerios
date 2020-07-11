import Foundation
import SpriteKit

extension GameScene
{
    func createInGameMenuTop()
    {
        menuRect = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: self.frame.height / 2 - yBrickRowStart))
        menuRect.position = CGPoint(x: 0, y: yBrickRowStart + menuRect.frame.height / 2)
        menuRect.fillColor = SKColor.black
        menuRect.strokeColor = SKColor.black
        menuRect.zPosition = 4
        menuRect.name = "menuRect"
        self.addChild(menuRect)
        
        // setting up the scorelabel in the main game... you'll probably get it for the next ones:)
        scoreLabel = SKLabelNode(text: "1")
        scoreLabel.fontSize = self.frame.width / 7
        scoreLabel.fontName = "Verdana"
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: 0, y: yBrickRowStart + 0.35 * (scoreLabel.frame.height))
        scoreLabel.zPosition = 5
        scoreLabel.name = "scoreLabel"
        self.addChild(scoreLabel)
        
        highscoreLabel = SKLabelNode(text: "\(highscore)")
        highscoreLabel.fontSize = self.frame.width / 12
        highscoreLabel.fontName = "Verdana"
        highscoreLabel.fontColor = SKColor.white
        highscoreLabel.position = CGPoint(x: self.frame.width / 2 - 1.5 * highscoreLabel.frame.height, y: yBrickRowStart + 0.65 * (highscoreLabel.frame.height))
        highscoreLabel.zPosition = 5
        highscoreLabel.name = "highscoreLabel"
        self.addChild(highscoreLabel)
        
        
        highestLabel = SKLabelNode(text: "HIGH")
        highestLabel.fontSize = self.frame.width / 20
        highestLabel.fontName = "Verdana"
        highestLabel.fontColor = SKColor.white
        highestLabel.position = CGPoint(x: self.frame.width / 2 - 1.5 * highscoreLabel.frame.height, y: yBrickRowStart + 1.75 * (highscoreLabel.frame.height))
        highestLabel.zPosition = 5
        highestLabel.name = "highestLabel"
        self.addChild(highestLabel)
    }
    
//    func createPauseButton()
//    {
//        // setting up the pause button, dont worry too much about the external file used
//        // all you would want to change are the color, position and size which you can easily do in the following lines
//        // to hide the button the code would be : pauseButton.isHidden = true
//        pauseButton = PlaybackButton(frame: CGRect(x: 0, y: 5, width: self.frame.width / 10, height: self.frame.width / 10 ))
//        pauseButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        pauseButton.adjustMargin = 1
//        pauseButton.backgroundColor = UIColor.clear
//        pauseButton.setButtonColor(UIColor.white)
//        pauseButton.addTarget(self, action: #selector(didTapPauseButton(_:)), for: UIControl.Event.touchUpInside)
//        self.pauseButton.setButtonState(.playing, animated: false)
//        self.scene?.view?.addSubview(self.pauseButton)
//    }
    
//    @objc func didTapPauseButton(_ sender: AnyObject)
//    {
//        // the function which gets called when the user clicks on the pausebutton
//        // the button gets the according state -> .playing or .pausing
//        if self.pauseButton.buttonState == .playing {
//            self.pauseButton.setButtonState(.pausing, animated: true)
//            labelTimer.invalidate()
//        } else if self.pauseButton.buttonState == .pausing {
//            self.pauseButton.setButtonState(.playing, animated: true)
//            startGameTimer()
//        }
//    }

    // How many left?
    func createNumberBallsLabel()
    {
        ballsRemainingLabel = SKLabelNode(text: "\(numBallsTotal)")
        ballsRemainingLabel.fontSize = self.frame.width / 20
        ballsRemainingLabel.fontName = "Verdana"
        ballsRemainingLabel.fontColor = SKColor.white

        if ballOriginLocation.x >= 0
        {
            ballsRemainingLabel.position = CGPoint(x: ballOriginLocation.x -  1.2*ballStartingLocation.frame.width, y: ballOriginLocation.y - ballsRemainingLabel.frame.height / 2)
        } else {
            ballsRemainingLabel.position = CGPoint(x: ballOriginLocation.x + 1.2*ballStartingLocation.frame.width, y: ballOriginLocation.y - ballsRemainingLabel.frame.height / 2)
        }
        ballsRemainingLabel.zPosition = 5
        ballsRemainingLabel.name = "ballsLeftLabel"
        self.addChild(ballsRemainingLabel)
    }
    
    // BBTAN Style timer (could have been an ad, but you know...)
    func createInGameMenuBottom()
    {
        timeRect = SKShapeNode(rectOf: CGSize(width: self.frame.width , height: (self.frame.height / 2 - yBrickStart) / 2))
        timeRect.strokeColor = colorsSecondary[15]!  // getting the cyan color
        timeRect.lineWidth = 10
        timeRect.position = CGPoint(x: 0 , y: -self.frame.height / 2 + timeRect.frame.height / 2)
        timeRect.zPosition = 3
        timeRect.name = "timRect"
        self.addChild(timeRect)
    
        timeLabel = SKLabelNode(text: "\(timeLeftMin):\(timeLeftSec)")
        timeLabel.fontSize = self.frame.width / 7
        timeLabel.fontName = "Verdana"
        timeLabel.position = CGPoint(x: 0, y: -self.frame.height / 2 + timeLabel.frame.height / 3.8)
        timeLabel.zPosition = 3
        timeLabel.name = "timeLabel"
        self.addChild(timeLabel)
        
    }
}
