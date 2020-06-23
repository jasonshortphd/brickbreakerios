import SpriteKit
import GameplayKit

struct PhysicsCategory
{
    static let Box : UInt32 = 0x01 << 1
    static let Ball : UInt32 = 0x01 << 2
    static let Border : UInt32 = 0x01 << 3
    static let Powerup : UInt32 = 0x01 << 4
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
    var highscore = Int()
    var savedHighscore : Int? = UserDefaults.standard.object(forKey: "highscore") as! Int?  // Pull from coredata
    
    // Information about the balls
    var numBallsTotal = Int()
    var ballsReleased = Int()
    var ballsRemainingLabel = SKLabelNode()     // Countdown on screen as we release balls
    var ballTargetLocation = CGPoint()          // Target where balls fly towards
    var ballOriginLocation = CGPoint()          // Balls starting point
    var ballStartingLocation = SKShapeNode()
    var ballSize = CGFloat()
    var ballColor = SKColor()
    var backGroundBall = SKShapeNode()          // Ball stays in background at origin location

    // Borders
    var borderRight = SKSpriteNode()
    var borderLeft = SKSpriteNode()
    var borderTop = SKSpriteNode()
    var borderBottom = SKSpriteNode()

    // Box Starting Positions
    var BoxStartx = CGFloat()       // First box x
    var BoxRowStarty = CGFloat()     // All boxes start at the same y offset
    var BallStarty = CGFloat()   // Balls have to start at the bottom

    
    
    var gameState = GameState.StartMenu
    
    // Moving to this view
    override func didMove(to view: SKView)
    {
        
        self.view?.scene?.backgroundColor = SKColor.black
        
        // Call me for physics collisions
        physicsWorld.contactDelegate = self
        
        ballSize = self.frame.width / 40        // Default - we will make it so you can pick different balls
        ballColor = SKColor.white               // Color should be part of unlocked balls too
        
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
