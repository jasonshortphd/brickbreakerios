import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?
        {
            if let scene = GameScene(fileNamed: "GameScene")
            {
                // Fits better on iPad and Mac this way
                scene.scaleMode = .aspectFit

                view.presentScene(scene)
            }
            
            #if DEBUG
                view.showsFPS = true
                view.showsNodeCount = true
            #endif
        }
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
