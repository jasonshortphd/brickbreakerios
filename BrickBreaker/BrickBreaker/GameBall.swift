import Foundation
import SpriteKit

extension GameScene
{
    class GameBall : SKShapeNode
    {
        var previousYPostition = CGFloat(0)
        var samePositionCount = 0
        //TODO:  Could we add hitpoints here too so that balls die?
    }
    
    // Show the start screen ball, and the one at the bottom of the screen during levels
    func showBall()
    {
        ballStartingLocation = SKShapeNode(circleOfRadius: ballSize)
        ballStartingLocation.fillColor = ballColor
        ballStartingLocation.strokeColor = ballColor
        ballStartingLocation.position = CGPoint(x: 0, y: borderBottom.position.y + ballStartingLocation.frame.height / 2 + 5)
        ballStartingLocation.zPosition = 4
        ballStartingLocation.name = "mainBall"
        ballOriginLocation = ballStartingLocation.position
        self.addChild(ballStartingLocation)
    }
    
    @objc func launchBall()
    {
        // Are there still more balls to release?
        if ballsReleased < numBallsTotal
        {
            if numBallsTotal - ballsReleased > 0
            {
                ballsRemainingLabel.text = "\(numBallsTotal - ballsReleased)"
            }
            else
            {
                ballsRemainingLabel.removeFromParent()
            }

            let ball = GameBall(circleOfRadius: ballSize)
            ball.fillColor = ballColor
            ball.strokeColor = ballColor
            ball.position = ballStartingLocation.position
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.height / 2)
            ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
            ball.physicsBody?.contactTestBitMask = PhysicsCategory.Brick | PhysicsCategory.Border
            ball.physicsBody?.collisionBitMask = PhysicsCategory.Brick | PhysicsCategory.Border
            ball.physicsBody?.affectedByGravity = false
            ball.physicsBody?.isDynamic = true
            ball.physicsBody?.friction = 0
            ball.physicsBody?.restitution = 1.0
            ball.physicsBody?.angularDamping = 0.0
            ball.physicsBody?.linearDamping = 0.0
            ball.name = "ball"
            ball.zPosition = 3
            ball.physicsBody?.mass = 0.0564

            self.addChild(ball)

            let x = ballTargetLocation.x - ballOriginLocation.x
            let y = ballTargetLocation.y - ballOriginLocation.y
            let ratio = x/y
            let newY = CGFloat(getShootSpeed(a:ballOriginLocation, b: ballTargetLocation)/(sqrt(Double(1 + (ratio * ratio)))))
            let newX = CGFloat(ratio * newY)
            
            // Add some push
            ball.physicsBody?.applyImpulse(CGVector(dx: newX, dy: newY))
            ballsReleased += 1
            
        }
        else
        {
            // No more balls
            ballTimer.invalidate()
            ballStartingLocation.removeFromParent()
            ballsRemainingLabel.removeFromParent()
        }
    }

    func getShootSpeed(a: CGPoint, b: CGPoint) -> Double
    {
        // calculating how fast the bullet is going to fly
        // if you want to change it, i would not recommand you to try to understand my calculations, simply change the return value to e.g 200:)
        // ...and if you try to understand, don't blame me for my strange thinking
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        let distance = CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
        if distance < self.frame.width / 6
        {
            // if the distance is between 0 and self.frame.width / 6
            return 60
        }
        else if distance < self.frame.width / 4
        {
            // if the distance is between self.frame.width / 6 and self.frame.width / 4
            return 75
        }
        else if distance < self.frame.width / 2
        {
            // if the distance is between self.frame.width / 4 and self.frame.width / 2
            return 90
        }
        else
        {
            return 100
        }
    }
}
