import Foundation
import SpriteKit

extension GameScene
{
    func createBorders()
    {
        borderRight = SKSpriteNode()
        borderRight.size = CGSize(width: 3, height: self.frame.height)
        borderRight.position = CGPoint(x: self.frame.width / 2 , y: 0)
        borderRight.physicsBody = SKPhysicsBody(rectangleOf: borderRight.size)
        borderRight.physicsBody?.affectedByGravity = false
        borderRight.physicsBody?.isDynamic = false
        borderRight.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderRight.physicsBody?.collisionBitMask = 0
        borderRight.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        borderRight.physicsBody?.friction = 0.0
        borderRight.color = UIColor.black
        borderRight.name = "border"
        
        borderLeft = SKSpriteNode()
        borderLeft.size = CGSize(width: 3, height: self.frame.height)
        borderLeft.position = CGPoint(x: -self.frame.width / 2 , y: 0)
        borderLeft.physicsBody = SKPhysicsBody(rectangleOf: borderLeft.size)
        borderLeft.physicsBody?.affectedByGravity = false
        borderLeft.physicsBody?.isDynamic = false
        borderLeft.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderLeft.physicsBody?.collisionBitMask = 0
        borderLeft.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        borderLeft.physicsBody?.friction = 0.0
        borderLeft.color = UIColor.black
        borderLeft.name = "borderLeft"
        
        borderTop = SKSpriteNode()
        borderTop.size = CGSize(width: self.frame.width, height: 3)
        borderTop.position = CGPoint(x: 0, y: BoxRowStarty)
        borderTop.zPosition = 3
        borderTop.physicsBody = SKPhysicsBody(rectangleOf: borderTop.size)
        borderTop.physicsBody?.affectedByGravity = false
        borderTop.physicsBody?.isDynamic = false
        borderTop.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderTop.physicsBody?.collisionBitMask = 0
        borderTop.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        borderTop.physicsBody?.friction = 0.0
        borderTop.color = UIColor.white
        borderTop.name = "border"
        
        borderBottom = SKSpriteNode()
        borderBottom.size = CGSize(width: self.frame.width, height: 3)
        borderBottom.position = CGPoint(x: 0, y: BallStarty - self.frame.width / 14 - 8 * self.frame.width / 7)
        borderBottom.zPosition = 3
        borderBottom.physicsBody = SKPhysicsBody(rectangleOf: borderBottom.size)
        borderBottom.physicsBody?.affectedByGravity = false
        borderBottom.physicsBody?.isDynamic = false
        borderBottom.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderBottom.physicsBody?.collisionBitMask = 0
        borderBottom.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        borderBottom.physicsBody?.friction = 1.0
        borderBottom.color = UIColor.white
        borderBottom.name = "borderBottom"
        
        self.addChild(borderTop)
        self.addChild(borderLeft)
        self.addChild(borderRight)
        self.addChild(borderBottom)
    }
}
