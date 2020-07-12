import Foundation
import SpriteKit

extension GameScene
{
    func createMainMenuBallDisplay()
    {
        showBall()
        ballStartingLocation.position = CGPoint(x: playBackGround.position.x + playBackGround.frame.width / 2.3, y: playBackGround.position.x + playBackGround.frame.height)
        ballStartingLocation.physicsBody = SKPhysicsBody(circleOfRadius: ballStartingLocation.frame.width / 2)
        ballStartingLocation.physicsBody?.affectedByGravity = true
        ballStartingLocation.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ballStartingLocation.physicsBody?.contactTestBitMask = PhysicsCategory.Border
        ballStartingLocation.physicsBody?.collisionBitMask = PhysicsCategory.Border
        ballStartingLocation.physicsBody?.friction = 0.0
        ballStartingLocation.physicsBody?.restitution = 1.0
        ballStartingLocation.physicsBody?.angularDamping = 0.0
        ballStartingLocation.physicsBody?.linearDamping = 0.1
        ballStartingLocation.physicsBody?.mass = 0.0564
    }
    
    func MainGameSceneMenu()
    {
        //TODO: Replace with game state
        menuVisible = true
        gameOverVisible = false
        //pauseButton.isHidden = true
        
        playBackGround = SKShapeNode(rectOf: CGSize(width: self.frame.width / 3, height: self.frame.height / 10))
        playBackGround.position = CGPoint(x: self.frame.width / 5, y: -1.5 * playBackGround.frame.height)
        playBackGround.strokeColor = SKColor(red: 212/255, green: 49/255, blue: 127/255, alpha: 1.0)
        playBackGround.lineWidth = 10
        playBackGround.fillColor = SKColor(red: 72/255, green: 13/255, blue: 67/255, alpha: 1.0)
        playBackGround.zPosition = 1
        self.addChild(playBackGround)
        
        ballBackGround = SKShapeNode(rectOf: CGSize(width: self.frame.width / 3, height: self.frame.height / 10))
        ballBackGround.position = CGPoint(x: -self.frame.width / 5, y: -1.5 * ballBackGround.frame.height)
        ballBackGround.strokeColor = SKColor(red: 212/255, green: 49/255, blue: 127/255, alpha: 1.0)
        ballBackGround.lineWidth = 10
        ballBackGround.fillColor = SKColor(red: 72/255, green: 13/255, blue: 67/255, alpha: 1.0)
        ballBackGround.zPosition = 1
        self.addChild(ballBackGround)
        
        let line_path:CGMutablePath = CGMutablePath()
        let lineHeight = playBackGround.frame.height / 2
        line_path.move(to: CGPoint(x: playBackGround.position.x - lineHeight / 2, y: playBackGround.position.y + lineHeight / 2))
        line_path.addLine(to: CGPoint(x:playBackGround.position.x + lineHeight / 2, y: playBackGround.position.y))
        line_path.addLine(to: CGPoint(x: playBackGround.position.x - lineHeight / 2, y: playBackGround.position.y - lineHeight / 2))
        line_path.addLine(to: CGPoint(x: playBackGround.position.x - lineHeight / 2, y: playBackGround.position.y + lineHeight / 2))
        triangleShape = SKShapeNode()
        triangleShape.name = "playButton"
        triangleShape.path = line_path
        triangleShape.lineWidth = 10
        triangleShape.strokeColor = SKColor(red: 227/255, green: 160/255, blue: 158/255, alpha: 1.0)
        triangleShape.zPosition = 2
        self.addChild(triangleShape)
        
        gameNameLabel = SKLabelNode(text: "Brick Breaker")
        gameNameLabel.fontSize = self.frame.height / 9
        gameNameLabel.fontName = "Helvetica Neue Condensed Bold"
        gameNameLabel.fontColor = SKColor(red: 221/255, green: 232/255, blue: 130/255, alpha: 1.0)
        gameNameLabel.zPosition = 1
        self.addChild(gameNameLabel)
        
        upperLine = SKShapeNode(rectOf: CGSize(width: gameNameLabel.frame.width, height: self.frame.width / 60))
        upperLine.strokeColor = SKColor(red: 221/255, green: 232/255, blue: 130/255, alpha: 1.0)
        upperLine.fillColor = upperLine.strokeColor
        upperLine.position = CGPoint(x: 0, y: 1.2 * gameNameLabel.frame.height)
        upperLine.zPosition = 1
        self.addChild(upperLine)
        
        bottomLine = SKShapeNode(rectOf: CGSize(width: gameNameLabel.frame.width, height: self.frame.width / 60))
        bottomLine.strokeColor = SKColor(red: 221/255, green: 232/255, blue: 130/255, alpha: 1.0)
        bottomLine.fillColor = upperLine.strokeColor
        bottomLine.position = CGPoint(x: 0, y: -0.2 * gameNameLabel.frame.height)
        bottomLine.zPosition = 1
        self.addChild(bottomLine)
        
        circleShape = SKShapeNode(circleOfRadius: lineHeight / 4)
        circleShape.strokeColor = SKColor(red: 227/255, green: 160/255, blue: 158/255, alpha: 1.0)
        circleShape.fillColor = circleShape.strokeColor
        circleShape.position = ballBackGround.position
        circleShape.zPosition = 2
        self.addChild(circleShape)
        
        createInGameMenuBottom()
        createBorder()
        timeLabel.fontSize = self.frame.width / 8
        timeLabel.fontName = "Helvetica Neue Condensed Bold"
        timeLabel.text = "READY PLAYER 1..."
        
        createMainMenuBallDisplay()
        
        bounceBottom = SKSpriteNode(color: SKColor.clear, size: CGSize(width: self.frame.width , height: 0.1))
        bounceBottom.position = playBackGround.position
        bounceBottom.position.y += playBackGround.frame.height / 2
        bounceBottom.physicsBody = SKPhysicsBody(rectangleOf: bounceBottom.size)
        bounceBottom.physicsBody?.affectedByGravity = false
        bounceBottom.physicsBody?.isDynamic = false
        bounceBottom.physicsBody?.categoryBitMask = PhysicsCategory.Border
        bounceBottom.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        bounceBottom.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        bounceBottom.physicsBody?.friction = 0.0
        self.addChild(bounceBottom)
    }
}















