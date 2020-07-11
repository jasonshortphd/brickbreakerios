import Foundation
import SpriteKit

extension GameScene
{
    // How fast are the balls released?  Should this be variable?
    func startLaunchTimer()
    {
        ballTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(launchBall), userInfo: nil, repeats: true)
    }

    func startGameTimer()
    {
        labelTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGameTimer), userInfo: nil, repeats: true)
    }

    // Update the BBTAN style time for the game
    @objc func updateGameTimer()
    {
        timeLeftSec -= 1
        
        if timeLeftSec < 1
        {
            timeLeftSec = 59
            timeLeftMin -= 1
        }
        
        if timeLeftMin < 0
        {
            timeLabel.text = "SO WHAT!"
            return
        }
        else if timeLeftSec > 9
        {
            timeLabel.text = "\(timeLeftMin):\(timeLeftSec)"
        }
        else
        {
            timeLabel.text = "\(timeLeftMin):0\(timeLeftSec)"
        }
    }

    
}
