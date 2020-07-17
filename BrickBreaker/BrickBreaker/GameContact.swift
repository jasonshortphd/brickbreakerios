import Foundation
import SpriteKit

extension GameScene
{
    func BrickHit( nodeHit:SKNode  )
    {
        if let node = nodeHit as? SKSpriteNode as? Brick
        {
            node.hitpoints -= 1
            if node.hitpoints < 1
            {
                // We have an emitter for explosions
                let explosion = SKEmitterNode(fileNamed: "Explosion2")!
                explosion.position = node.position
                addChild(explosion)

                // Build up the explosion
                let wait = SKAction.wait(forDuration: 0.5)
                let removeMe = SKAction.removeFromParent()
                let explode = SKAction.sequence([wait, removeMe])
                
                // Run explosion!
                explosion.run(explode)

                let DeathAnim = SKAction.run {
                    node.removeAllChildren()
                    node.removeFromParent()
                }
                self.run(DeathAnim)
            }
            else
            {
                node.hitpointsLabel.text = "\(Int(node.hitpoints))"
            }
        }
    }
    
    func BallHitBottom( ball:SKPhysicsBody )
    {
        // First ball to hit bottom stays until next round
        if hasFirstBallReturned
        {
            ballStartingLocation.position = (ball.node?.position)!
            // Make sure the Y lines up with the border (someties due to velocity it didn't quite line up
            ballStartingLocation.position.y = borderBottom.position.y + ballStartingLocation.frame.height / 2 + 5

            // Remove the ball
            ball.node?.removeFromParent()
            hasFirstBallReturned = false
        }
        else
        {
            // Freeze movement
            ball.node?.physicsBody?.restitution = 1.0
            ball.isDynamic = false

            // if it is not the first ball, we are animate it so that it goes to the first ball
            let moveBall = SKAction.moveTo(y: borderBottom.position.y + (ball.node?.frame.height)! / 2, duration: 0.2)
            ball.node?.run(moveBall)
            let moveToCenter = SKAction.moveTo(x: ballStartingLocation.position.x, duration: 0.4)
            let remove = SKAction.removeFromParent()
            let check = SKAction.run(checkIfRoundIsOver)
            let moveAndRemove = SKAction.sequence([moveToCenter, remove, check])
            ball.node?.run(moveAndRemove)
        }
    }
    
    func isBallStuckSideways( ballHit:SKPhysicsBody )
    {
        // algorithm to detect if a ball is flying horizontally -> prevention from a never ending game
        let ball = ballHit.node as! GameBall
        // Not EXACT same position, lumping into buckets of ranges in the game
        if ball.previousYPosition <= ball.position.y + ballZoneHeight && ball.previousYPosition >= ball.position.y - ballZoneHeight
        {
            ball.samePositionCount += 1

            if ball.samePositionCount > 3
            {
                // Shove the ball out of alignment a random amount
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Int.random(in: 15...55)))
                ball.samePositionCount = 0
            }
        }
        else
        {
            // Reset if we are outside the zone
            ball.samePositionCount = 0
            //ball.previousYPosition = ball.position.y
        }
    }
    
    // A collision has happened!
    func didBegin(_ contact: SKPhysicsContact)
    {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if (firstBody.node?.name == "borderBottom" && secondBody.categoryBitMask == PhysicsCategory.Ball)
        {
            BallHitBottom(ball: secondBody)
        }
        else if (firstBody.categoryBitMask == PhysicsCategory.Ball && secondBody.node?.name == "borderBottom")
        {
            BallHitBottom(ball: firstBody)
        }
        else if (firstBody.categoryBitMask == PhysicsCategory.Ball && secondBody.categoryBitMask == PhysicsCategory.Brick)
        {
            BrickHit( nodeHit: secondBody.node! )
        }
        else if (secondBody.categoryBitMask == PhysicsCategory.Ball && firstBody.categoryBitMask == PhysicsCategory.Brick)
        {
            BrickHit( nodeHit: firstBody.node! )
        }
        else if (firstBody.categoryBitMask == PhysicsCategory.Ball && secondBody.node?.name == "borderLeft")
        {
            isBallStuckSideways(ballHit: firstBody)
        }
        else if (firstBody.node?.name == "borderLeft" && secondBody.categoryBitMask == PhysicsCategory.Ball)
        {
            isBallStuckSideways(ballHit: secondBody)
        }
        
        // See if all moving balls have stopped
        checkIfRoundIsOver()

    }
}

