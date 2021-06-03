import Foundation
import SpriteKit

extension GameScene
{
    func checkIfRoundIsOver()
    {
        if !gameOver
        {
            roundOver = true
            for node in self.children
            {
                // Do we still have balls being released?  Or any active ones?
                if node.name == "ball" || ballsReleased < numBallsTotal
                {
                    //TODO:  What if it has been a LONG time?  Ball could be stuck.
                    roundOver = false
                }
            }
            
            if roundOver
            {
                createBricks()
                createNumberBallsLabel()

                if ballStartingLocation.position.x >= 0
                {
                    ballsRemainingLabel.position = CGPoint(x: ballStartingLocation.position.x -  ballStartingLocation.frame.width, y: ballStartingLocation.position.y - ballsRemainingLabel.frame.height / 2)
                } else {
                    ballsRemainingLabel.position = CGPoint(x: ballStartingLocation.position.x +  ballStartingLocation.frame.width, y: ballStartingLocation.position.y - ballsRemainingLabel.frame.height / 2)
                }
                
                // looking for new highscore, if new highscore -> save it in core data
                if levelNumber > highscore
                {
                    highscore = levelNumber
                    highscoreLabel.text = "\(highscore)"
                    saveHighScore()
                }
                scoreLabel.text = "\(levelNumber)"
                touchIsEnabled = true
                hasFirstBallReturned = true
            }
        }
    }
    
    func checkIfGameIsOver()
    {
        // the game is over when a box has moved to the bottom
        if !gameOver
        {
            for node in self.children
            {
                // We only care about Brick objects
                if let brick = node as? Brick
                {
                    // 9 means they have hit bottom
                    if brick.rowsMoved >= 9
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


