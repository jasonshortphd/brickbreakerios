
import Foundation

extension GameScene
{
    func loadHighScore()
    {
        // if there is a saved highscore it is loaded
        if savedHighscore != nil
        {
            highscore = savedHighscore!
        } else {
            highscore = 1
        }
    }
    
    func saveHighScore()
    {
        UserDefaults.standard.set(highscore, forKey: "highscore")
        UserDefaults.standard.synchronize()
    }
}
