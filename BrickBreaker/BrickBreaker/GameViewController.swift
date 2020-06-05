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
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene")
            {
                // TODO:  Should we do this here?
                scene.scaleMode = .aspectFit

                view.presentScene(scene)
            }
            
            #if DEBUG
                view.showsFPS = true
                view.showsNodeCount = true
            #endif
        }
    }

    override var shouldAutorotate: Bool
    {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .portrait
        }
        else
        {
            return .portrait
        }
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
