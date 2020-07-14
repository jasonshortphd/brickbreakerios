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
    
    // A collision has happened!
    func didBegin(_ contact: SKPhysicsContact)
    {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        // with all these disgusting if statements we have to check which nodes collided
        // to check that, you can either use the categoryBitMask (PhysicsCategory) or their name
        if (firstBody.node?.name == "borderBottom" && secondBody.categoryBitMask == PhysicsCategory.Ball)
        {
            secondBody.node?.physicsBody?.restitution = 1.0
            secondBody.isDynamic = false
            // First ball to hit bottom stays for next round
            if isBallTouchingBottom
            {
                ballStartingLocation.removeFromParent()
                ballStartingLocation.position = (secondBody.node?.position)!
                ballStartingLocation.position.y = borderBottom.position.y + ballStartingLocation.frame.height / 2 + 5
                self.addChild(ballStartingLocation)
                secondBody.node?.removeFromParent()
                isBallTouchingBottom = false
                checkIfRoundIsOver()
            }
            else
            {
                // if it is not the first ball, we are animate it so that it goes to the first ball
                let moveBall = SKAction.moveTo(y: borderBottom.position.y + (secondBody.node?.frame.height)! / 2, duration: 0.2)
                secondBody.node?.run(moveBall)
                let moveToCenter = SKAction.moveTo(x: ballStartingLocation.position.x, duration: 0.4)
                let remove = SKAction.removeFromParent()
                let check = SKAction.run(checkIfRoundIsOver)
                let moveAndRemove = SKAction.sequence([moveToCenter, remove, check])
                secondBody.node?.run(moveAndRemove)
                checkIfRoundIsOver()
            }
        }
        else if (firstBody.categoryBitMask == PhysicsCategory.Ball && secondBody.node?.name == "borderBottom")
        {
            // same if statement as obove but vice-versa
            if isBallTouchingBottom
            {
                ballStartingLocation.removeFromParent()
                ballStartingLocation.position = (firstBody.node?.position)!
                ballStartingLocation.position.y = borderBottom.position.y + ballStartingLocation.frame.height + 5
                self.addChild(ballStartingLocation)
                secondBody.node?.removeFromParent()
                isBallTouchingBottom = true
                checkIfRoundIsOver()
            }
            else
            {
                firstBody.isDynamic = false
                firstBody.node?.physicsBody?.restitution = 1.0
                let moveDown = SKAction.moveTo(y: borderBottom.position.y + (secondBody.node?.frame.height)! / 2, duration: 0.2)
                firstBody.node?.run(moveDown)
                let moveToCenter = SKAction.moveTo(x: ballStartingLocation.position.x, duration: 0.4)
                let remove = SKAction.removeFromParent()
                let check = SKAction.run(checkIfRoundIsOver)
                let moveAndRemove = SKAction.sequence([moveToCenter, remove, check])
                firstBody.node?.run(moveAndRemove)
                checkIfRoundIsOver()
            }
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
            // algorithm to detect if a ball is flying horizontally -> prevention from a never ending game
            for child in self.children
            {
                if let ball = child as? GameBall
                {
                    // Not EXACT same position, lumping into buckets of ranges in the game
                    if ball.previousYPostition <= ball.position.y + self.frame.height / 100 && ball.previousYPostition >= ball.position.y - self.frame.height / 100
                    {
                        ball.samePositionCount += 1

                        if ball.samePositionCount > 3
                        {
                            // Shove the ball out of alignment a random amount
                            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Int.random(in: 15...55)))
                            ball.samePositionCount = 0
                        }
                    }
                }
            }
            if let ball = firstBody.node as? GameBall
            {
                ball.previousYPostition = ball.position.y
            }

        }
        else if (firstBody.node?.name == "borderLeft" && secondBody.categoryBitMask == PhysicsCategory.Ball)
        {
            // Has the ball hit the left side N times in the same region?
            for child in self.children
            {
                if let ball = child as? GameBall
                {
                    // Using a mod operator to break screen up into regions
                    if ball.previousYPostition <= ball.position.y + self.frame.height / 100 && ball.previousYPostition >= ball.position.y - self.frame.height / 100
                    {
                        ball.samePositionCount += 1

                        // Too many times?  Add a little random shove to the ball
                        if ball.samePositionCount > 3
                        {
                            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Int.random(in: 15...55)))
                            ball.samePositionCount = 0
                        }
                    }
                }
            }
            if let ball = secondBody.node as? GameBall
            {
                ball.previousYPostition = ball.position.y
            }
        }
    }
}

