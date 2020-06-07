import SpriteKit
import GameplayKit

struct PhysicsCategory
{
    static let Box : UInt32 = 0x01 << 1
    static let Ball : UInt32 = 0x01 << 2
    static let Border : UInt = 0x01 << 3
    static let Powerup : UInt = 0x01 << 4
    static let Bonus : UInt32 = 0x01 << 5
}

enum GameState
{
    case StartMenu
    case GameOver
    case Playing
    case Paused
    case BallStore
}

class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    var levelNumber = Int()
    
    // Information about the balls
    var numBallsTotal = Int()
    var ballsReleased = Int()
    var ballsRemainingLabel = SKLabelNode()
    var ballLocation = CGPoint()
    var ballOrigin = CGPoint()
    var ballStartingLoc = SKShapeNode()
    var ballSize = CGFloat()
    var ballColor = SKColor()
    
    
    var gameState = GameState.StartMenu
    
    // Moving to this view
    override func didMove(to view: SKView)
    {
        
        self.view?.scene?.backgroundColor = SKColor.black
        // Call me for physics collisions
        physicsWorld.contactDelegate = self
        
        ballSize = self.frame.width / 40
        ballColor = SKColor.white
        
        // Make sure we can find the sprite and it is the correct type
        if let title:SKSpriteNode = self.childNode(withName: "Title") as? SKSpriteNode
        {
            
        }
    }
    
    func touchDown(atPoint pos : CGPoint)
    {

    }
    
    func touchMoved(toPoint pos : CGPoint)
    {

    }
    
    func touchUp(atPoint pos : CGPoint)
    {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval)
    {

    }
}
