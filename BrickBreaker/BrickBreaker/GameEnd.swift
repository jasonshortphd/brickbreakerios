import Foundation
import SpriteKit

extension GameScene
{
    func checkIfRoundIsOver()
    {
        roundOver = true
        for node in self.children
        {
            // Do we still have balls being released?  Or any active ones?
            if node.name == "ball" || ballsReleased < numBallsTotal
            {
                roundOver = false
            }
        }
        
        if roundOver
        {
            createBricks()
            createNumberBallsLabel()

            if ballStartingLocation.position.x >= 0
            {
                ballsRemainingLabel.position = CGPoint(x: ballStartingLocation.position.x -  ballStartingLocation.frame.width, y: ballStartingLocation.position.y - ballStartingLocation.frame.height / 2)
            }else{
                ballsRemainingLabel.position = CGPoint(x: ballStartingLocation.position.x +  ballStartingLocation.frame.width, y: ballStartingLocation.position.y - ballStartingLocation.frame.height / 2)
            }
            
            // looking for new highscore, if new highscore -> saving it in core data
            if levelNumber > highscore
            {
                highscore = levelNumber
                highscoreLabel.text = "\(highscore)"
                saveHighScore()
            }
            scoreLabel.text = "\(levelNumber)"
            touchIsEnabled = true
            isBallTouchingBottom = true
        }
    }
    
    func checkIfGameIsOver()
    {
        // the game is over when a box has moved to the bottom
        if !gameOver
        {
            for node in self.children
            {
                if let box = node as? Brick
                {
                    // a box actually touches the bottom when its property hasmoveddown equals to 9
                    if box.rowsMoved >= 9
                    {
                        //pauseButton.isHidden = true
                        gameOver = true
                        labelTimer.invalidate()
                        createGameOverView()
                    }
                }
            }
        }
    }
}


