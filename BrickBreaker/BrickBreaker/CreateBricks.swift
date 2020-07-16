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

        for _ in 1..<8
        {
            // Randomly determine if we want to create a box in the position
            if Bool.random()
            {
                // if two -> a box is created
                // the outer box is what you see(the border), the inner box makes a smaller black square
                let box = Brick(color: randomColor, size: CGSize(width: self.frame.width / 7.4, height: self.frame.width / 7.4))
                let innerBox = Brick(color: SKColor.black, size: CGSize(width: self.frame.width / 8.8, height: self.frame.width / 8.8))
                
                box.position = CGPoint(x: xBrickStart, y: yBrickRowStart - box.frame.height / 2)

                // We don't need to offset this if it is a child
                //innerBox.position = box.position
                
                innerBox.zPosition = 2
                box.hitpoints = levelNumber
                box.name = "outerBox"
                innerBox.name = "innerBox"
                // the zPosition defines the layer on which the node exists
                // e.g if to nodes have the same position and size, their zPosition decides which one is shown
                box.zPosition = 1
                // Physics Body : every node we want to interact with another node has to get a physicsbody
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                // the category of the node itsself
                box.physicsBody?.categoryBitMask = PhysicsCategory.Brick
                // the category of the nodes we want to get informed when they collide with this node (function in Contacts.swift gets called)
                box.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                // the category of the nodes we want to collide with this node
                box.physicsBody?.collisionBitMask = PhysicsCategory.Ball
                // saying if we want the node to be affected by gravity ( if yes it falls down)
                box.physicsBody?.affectedByGravity = false
                // if the node is dynamic it moves on collision
                box.physicsBody?.isDynamic = false
                // how much energy gets lost on contacts with other nodes
                box.physicsBody?.friction = 0
                // hte 'bounciness' of the node
                box.physicsBody?.restitution = 1.0
                
                //createBoxLabel()
                
                // creating the labels in the boxes
                box.hitpointsLabel = SKLabelNode(text: "\(levelNumber)")
                box.hitpointsLabel.color = UIColor.red
                box.hitpointsLabel.fontSize = 50
                box.hitpointsLabel.fontName = "Damascus"
                box.hitpointsLabel.position = CGPoint(x: 0, y: -box.hitpointsLabel.frame.height / 2)
                box.hitpointsLabel.zPosition = 5

                // Everything gets parented to the box itself
                box.addChild(box.hitpointsLabel)
                box.addChild(innerBox)

                self.addChild(box)
            }
            
            // Step to the next position
            xBrickStart += self.frame.width / 7

        }
        for node in self.children
        {
            // moving down all the boxes of the game after each round
            if let box = node as? Brick
            {
                // checking if there is one or more boxes which touched the game -> if yes gameover:(
                if box.name == "outerBox"
                {
                    box.rowsMoved += 1
                }
                // setting up the action so that the boxes move down and then a function is called to check whether the game is over or not
                let moveDown = SKAction.moveTo(y: node.position.y - self.frame.width / 7, duration: 0.8)
                let checkIfGameOver = SKAction.run(checkIfGameIsOver)
                let moveDownCheck = SKAction.sequence([moveDown, checkIfGameOver])
                box.run(moveDownCheck)
            }
//            if let label = node as? SKLabelNode
//            {
//                // moving down only the labels of a box
//                if let _ = Int(label.name!)
//                {
//                    let moveDown = SKAction.moveTo(y: node.position.y - self.frame.width / 7, duration: 0.8)
//                    label.run(moveDown)
//                }
//            }
        }
    }

    
}

