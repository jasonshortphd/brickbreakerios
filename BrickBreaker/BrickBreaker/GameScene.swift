import SpriteKit
import GameplayKit

struct PhysicsCategory
{
    static let Brick : UInt32 = 0x01 << 1
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
    var ballTimer = Timer()                     // How fast are balls launched?
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
    var xBrickStart = CGFloat()       // First box x
    var yBrickRowStart = CGFloat()     // All boxes start at the same y offset
    var yBrickStart = CGFloat()   // Balls have to start at the bottom

    var colorsSecondary = [Int : SKColor]()
    var colorsPrimary = [Int :SKColor]()
    var randomColor = SKColor()
    
    // BBTAN Style timer
    var timeLeftMin = Int()
    var timeLeftSec = Int()
    var labelTimer = Timer()            // the timer which updates the time at the bottom in the main game
    var timeRect = SKShapeNode()
    var timeLabel = SKLabelNode()

    // Menu on running screen
    var menuRect = SKShapeNode()
    //var pauseButton = PlaybackButton()
    var scoreLabel = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var highestLabel = SKLabelNode()

    
    var roundOver = Bool()              // Is this round done?
    var gameOver = Bool()
    var touchIsEnabled = Bool()         // Touch off while balls being released
    var startedBallTouch = Bool()
    var isBallTouchingBottom = Bool()   // Where will the next round start from?
    public var menuVisible = Bool()
    var gameOverVisible = Bool()
    
    // TODO: Fix this ugly game views in this class...
    // Game Over man
    var quitButton = SKShapeNode()
    var darkerBackgroundRect = SKShapeNode()
    var endGameLabel = SKLabelNode()
    var oneMoreLabel = SKLabelNode()
    var chanceLabel = SKLabelNode()

    var gameState = GameState.StartMenu

    // MAIN MENU
    var bouncingBall = SKSpriteNode()       // Demo of the current ball
    var bounceBottom = SKSpriteNode()       // Line to bounce off
    var playButtonShape = SKShapeNode()     // Play button
    var circleShape = SKShapeNode()         // Change ball
    var gameNameLabel = SKLabelNode()
    var upperLine = SKShapeNode()
    var bottomLine = SKShapeNode()
    var playBackGround = SKShapeNode()
    var ballBackGround = SKShapeNode()

    
    // Moving to this view - called right before we get started
    override func didMove(to view: SKView)
    {
        loadHighScore()

        self.view?.scene?.backgroundColor = SKColor.black
        
        // Call me for physics collisions
        physicsWorld.contactDelegate = self
        
        ballSize = self.frame.width / 40        // Default - we will make it so you can pick different balls
        ballColor = SKColor.white               // Color should be part of unlocked balls too

        // Setup starting positions
        xBrickStart = -self.frame.width  / 2 + self.frame.width / 14
        yBrickRowStart = self.frame.height / 2 - self.frame.height / 5 +  self.frame.width / 7
        yBrickStart = self.frame.height / 2 - self.frame.height / 5 + self.frame.width / 14

        // Make sure we can find the sprite and it is the correct type
//        if let title:SKSpriteNode = self.childNode(withName: "Title") as? SKSpriteNode
//        {
//
//        }
        
        // Range of colors
        colorsPrimary = [
            1 : UIColor(red: 0/255, green: 104/255, blue: 132/255, alpha: 1.0),
            2 : UIColor(red: 0/255, green: 144/255, blue: 158/255, alpha: 1.0),
            3 : UIColor(red: 137/255, green: 219/255, blue: 236/255, alpha: 1.0),
            4 : UIColor(red: 237/255, green: 0/255, blue: 38/255, alpha: 1.0),
            5 : UIColor(red: 250/255, green: 157/255, blue: 0/255, alpha: 1.0),
            6 : UIColor(red: 255/255, green: 208/255, blue: 141/255, alpha: 1.0),
            7 : UIColor(red: 176/255, green: 0/255, blue: 81/255, alpha: 1.0),
            8 : UIColor(red: 246/255, green: 131/255, blue: 112/255, alpha: 1.0),
            9 : UIColor(red: 254/255, green: 171/255, blue: 185/255, alpha: 1.0),
            10 : UIColor(red: 110/255, green: 0/255, blue: 108/255, alpha: 1.0),
            11: UIColor(red: 145/255, green: 39/255, blue: 143/255, alpha: 1.0),
            12: UIColor(red: 207/255, green: 151/255, blue: 215/255, alpha: 1.0),
            13: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0),
            14: UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1.0),
            15: UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0),
        ]
        
        // Alternate Color range?
        colorsSecondary = [
            1 : UIColor(red: 200/255, green: 112/255, blue: 126/255, alpha: 1.0),
            2 : UIColor(red: 226/255, green: 143/255, blue: 173/255, alpha: 1.0),
            3 : UIColor(red: 239/255, green: 180/255, blue: 193/255, alpha: 1.0),
            4 : UIColor(red: 228/255, green: 142/255, blue: 88/255, alpha: 1.0),
            5 : UIColor(red: 237/255, green: 170/255, blue: 125/255, alpha: 1.0),
            6 : UIColor(red: 240/255, green: 199/255, blue: 171/255, alpha: 1.0),
            7 : UIColor(red: 90/255, green: 160/255, blue: 141/255, alpha: 1.0),
            8 : UIColor(red: 76/255, green: 146/255, blue: 177/255, alpha: 1.0),
            9 : UIColor(red: 168/255, green: 200/255, blue: 121/255, alpha: 1.0),
            10: UIColor(red: 103/255, green: 143/255, blue: 174/255, alpha: 1.0),
            11: UIColor(red: 172/255, green: 153/255, blue: 193/255, alpha: 1.0),
            12: UIColor(red: 150/255, green: 177/255, blue: 208/255, alpha: 1.0),
            13: UIColor(red: 192/255, green: 136/255, blue: 99/255, alpha: 1.0),
            14: UIColor(red: 173/255, green: 167/255, blue: 89/255, alpha: 1.0),
            15: UIColor(red: 200/255, green: 194/255, blue: 189/255, alpha: 1.0),
        ]
        
        //TODO: Add more color themes https://i.pinimg.com/originals/3e/38/7f/3e387fae0f07d2d28fe6ea6acfb1a69d.png

        
        MainGameSceneMenu()
        
    }
    
    func deletePointer()
    {
        for node in self.children
        {
            if let nodeShape = node as? SKShapeNode
            {
                if nodeShape.name != nil
                {
                    if nodeShape.name == "directionPointer"
                    {
                        nodeShape.removeFromParent()
                    }
                }
            }
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
        //for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if menuVisible
            {
                if playBackGround.contains(location)
                {
                    playButtonShape.alpha = 0.6
                }
                else if ballBackGround.contains(location)
                {
                    circleShape.alpha = 0.6
                }
            }
            else if gameOverVisible
            {
                if quitButton.contains(location)
                {
                    endGameLabel.alpha = 0.6
                }
            }
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        // where the pointer is created
        // as the pointer has to be updated constantly it is created in touchesMoved
        // first -> if there is an old pointer it is deleted
        deletePointer()
    
        for touch in touches
        {
            // then we are setting up the new pointer
            let location = touch.location(in: self)
            if location.y < borderBottom.position.y{
            let line_path:CGMutablePath = CGMutablePath()
            line_path.move(to: ballStartingLocation.position)
            // we get tthe point where the line has to move to, by taking the opposite of imaginary line between the original ball and the location of the touch
            // if you want to change the length of the pointer, you would have to change the two '1.5'
            line_path.addLine(to: CGPoint(x:ballStartingLocation.position.x - 1.7*(location.x - ballStartingLocation.position.x), y: ballStartingLocation.position.y - 1.7*(location.y - ballStartingLocation.position.y)))
            let shape = SKShapeNode()
            shape.name = "directionPointer"
            shape.path = line_path
            shape.lineWidth = 5.0
            shape.strokeColor = SKColor.white
            shape.fillColor = SKColor.blue
            shape.zPosition = 3
            self.addChild(shape)
            }
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            if menuVisible
            {
                if playBackGround.contains(location)
                {
                    self.removeAllChildren()
                    startGame()
                }
                else if ballBackGround.contains(location)
                {
                    ballStartingLocation.removeFromParent()
                    ballSize /= 1.2
                    
                    // Rotate through ball colors
                    // TODO: Replace with color pallete
                    if ballColor == SKColor.white
                    {
                        ballColor = SKColor.green
                    }
                    else if ballColor == SKColor.green
                    {
                        ballColor = SKColor.red
                    }
                    else if ballColor == SKColor.red
                    {
                        ballColor = SKColor.blue
                    }
                    else
                    {
                        ballColor = SKColor.white
                        ballSize = self.frame.width / 40
                    }
                    
                    createMainMenuBallDisplay()
                    circleShape.alpha = 1.0
                }
                else
                {
                    playBackGround.alpha = 1.0
                    playButtonShape.alpha = 1.0
                    ballBackGround.alpha = 1.0
                    circleShape.alpha = 1.0
                }
            }
            else if gameOverVisible
            {
                if quitButton.contains(location)
                {
                    self.removeAllChildren()
                    gameOverVisible = false
                    MainGameSceneMenu()
                }
                else
                {
                    endGameLabel.alpha = 1.0
                    oneMoreLabel.alpha = 1.0
                    chanceLabel.alpha = 1.0
                }
            }
            else if touchIsEnabled
            {
                // TODO: Change so you can drag up or down
                // Prepare to launch balls
                if location.y < borderBottom.position.y
                {
                    if !ballStartingLocation.contains(location)
                    {
                        ballTargetLocation = location
                        ballsReleased = 0
                        
                        ballStartingLocation = SKShapeNode(circleOfRadius: ballStartingLocation.frame.width / 2)
                        ballStartingLocation.fillColor = ballColor
                        ballStartingLocation.strokeColor = ballColor
                        ballStartingLocation.position = ballStartingLocation.position
                        ballStartingLocation.zPosition = 10
                        ballStartingLocation.name = "startingBallLocation"
                        // TODO: What if ballStartingLocation isn't valid?
                        // TODO: What if touchIsEnabled was turned off and we can't
                        ballOriginLocation = ballStartingLocation.position
                        
                        ballStartingLocation.removeFromParent()
                        self.addChild(ballStartingLocation)
                        
                        // Add a label to show the user how many more are remaining
                        createNumberBallsLabel()
                        // Start the balls launching
                        startLaunchTimer()
                        
                        touchIsEnabled = false
                    }
                }
            }
        }
        deletePointer()

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
