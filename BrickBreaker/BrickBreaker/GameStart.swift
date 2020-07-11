import Foundation
import SpriteKit

extension GameScene
{
    func startGame()
    {
        menuVisible = false
        gameOverVisible = false
        gameOver = false
        xBrickStart = -self.frame.width  / 2 + self.frame.width / 14
        numBallsTotal = 0
        levelNumber = 0
        touchIsEnabled = true
        isBallTouchingBottom = true
        //pauseButton.isHidden = false

        // Adding the timer like BBTAN had
        timeLeftMin = 29
        timeLeftSec = 59
        
        startGameTimer()
        createInGameMenuTop()
        createInGameMenuBottom()
        createBorder()
        createBricks()
        showBall()
        createNumberBallsLabel()
       
        // Check if the ball is in a good position to start
        if ballStartingLocation.position.x >= 0
        {
            ballsRemainingLabel.position = CGPoint(x: ballStartingLocation.position.x -  ballStartingLocation.frame.width, y: ballStartingLocation.position.y - ballsRemainingLabel.frame.height / 2)
        }else
        {
            ballsRemainingLabel.position = CGPoint(x: ballStartingLocation.position.x +  ballStartingLocation.frame.width, y: ballStartingLocation.position.y - ballsRemainingLabel.frame.height / 2)
        }
        updateGameTimer()
    }

}
