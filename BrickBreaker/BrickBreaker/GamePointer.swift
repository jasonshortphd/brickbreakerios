import Foundation
import SpriteKit

extension GameScene
{

    class GamePointer : SKShapeNode
    {
        static let multiplier = CGFloat(1.7)
        
        init(newPath:CGPath)
        {
            super.init()
            self.path = newPath
            self.lineWidth = CGFloat(7.0)
            self.strokeColor = SKColor.white
            self.fillColor = SKColor.blue
            self.zPosition = 3
        }
        
        required init?(coder aDecoder: NSCoder) {
            // NO IDEA why I need this for a class I am only going to be using
            fatalError("init(coder:) has not been implemented")
        }
        
        func hidePointer()
        {
            self.isHidden = true
        }
        
        func showPointer()
        {
            self.isHidden = false
        }
    }

    func deletePointer()
    {
        for node in self.children
        {
            // We only want the game pointer
            if let nodeShape = node as? GamePointer
            {
                nodeShape.removeFromParent()
            }
        }
    }

}
