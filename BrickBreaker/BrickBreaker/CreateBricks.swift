import Foundation
import SpriteKit

extension GameScene
{
    class Brick : SKSpriteNode
    {
        var hitpoints = 1                               // Hitpoints for this brick
        var rowsMoved = 1                               // How many rows have we moved?
        var hitpointsLabel = SKLabelNode( text: "-")    // The label tp show hitpoints
    }

    // We are all just bricks in the wall
    func createBricks()
    {
        levelNumber += 1
        numBallsTotal += 1
        xBrickStart = -self.frame.width / 2 + self.frame.width / 14
        
        // Choose a color for the new row from our list of colors
        let randomColor = colorsSecondary[Int.random(in: 1...15)]!

        // Go through each slot and randomly choose if it will have a brick (in the wall)
        for _ in 1..<8
        {
            // Randomly determine if we want to create a box in the position
            if Bool.random()
            {
                let gameBrick = Brick(color: randomColor, size: CGSize(width: self.frame.width / 7.4, height: self.frame.width / 7.4))
                let brickHitLabel = Brick(color: SKColor.black, size: CGSize(width: self.frame.width / 8.8, height: self.frame.width / 8.8))
                
                gameBrick.position = CGPoint(x: xBrickStart, y: yBrickRowStart - gameBrick.frame.height / 2)

                brickHitLabel.zPosition = 2
                gameBrick.hitpoints = levelNumber
                gameBrick.name = "brick"
                brickHitLabel.name = "bricklabel"
                gameBrick.zPosition = 1
                gameBrick.physicsBody = SKPhysicsBody(rectangleOf: gameBrick.size)
                gameBrick.physicsBody?.categoryBitMask = PhysicsCategory.Brick
                gameBrick.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                gameBrick.physicsBody?.collisionBitMask = PhysicsCategory.Ball
                gameBrick.physicsBody?.affectedByGravity = false
                gameBrick.physicsBody?.isDynamic = false
                gameBrick.physicsBody?.friction = 0
                gameBrick.physicsBody?.restitution = 1.0
                
                gameBrick.hitpointsLabel = SKLabelNode(text: "\(levelNumber)")
                gameBrick.hitpointsLabel.color = UIColor.red
                gameBrick.hitpointsLabel.fontSize = 48
                gameBrick.hitpointsLabel.fontName = "Damascus"
                gameBrick.hitpointsLabel.position = CGPoint(x: 0, y: -gameBrick.hitpointsLabel.frame.height / 2)
                gameBrick.hitpointsLabel.zPosition = 5

                // Everything gets parented to the box itself
                gameBrick.addChild(gameBrick.hitpointsLabel)
                gameBrick.addChild(brickHitLabel)

                self.addChild(gameBrick)
            }
            
            // Step to the next position
            xBrickStart += self.frame.width / 7

        }

        for node in self.children
        {
            if let box = node as? Brick
            {
                box.rowsMoved += 1
                // setting up the action so that the boxes move down and then a function is called to check whether the game is over or not
                let moveDown = SKAction.moveTo(y: node.position.y - self.frame.width / 7, duration: 0.8)
                let checkIfGameOver = SKAction.run(checkIfGameIsOver)
                let moveDownCheck = SKAction.sequence([moveDown, checkIfGameOver])
                box.run(moveDownCheck)
            }
        }
    }
}

