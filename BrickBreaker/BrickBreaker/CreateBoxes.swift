import Foundation
import SpriteKit


extension GameScene
{
    class Box : SKSpriteNode
    {
        var hitpoints = 1       // For now we use the current level at the time box is generated
        var hasMovedDown = 1    // How many rows below the starting row?
    }

    // Create new boxes for a new level
    func createBoxes()
    {
        levelNumber += 1
        numBallsTotal += 1
        xPosition = -self.frame.width / 2 + self.frame.width / 14
        
        let randomColorIndex = randomNumber(range: 1..<11)
        var randomColor = colorDictionary[randomColorIndex]!
        
        print(randomColor)

        for _ in 1..<8 {
            if randomNumber(range: 0..<2) == 0
            {
                // this basically gives a random true or false (0 or 1)
                // if one -> no box is created
                xPosition += self.frame.width / 7
            } else {
                // if two -> a box is created
                // the outer box is what you see(the border), the inner box makes e smaller black square
                let box = Box(color: randomColor, size: CGSize(width: self.frame.width / 7.4, height: self.frame.width / 7.4))
                let innerBox = Box(color: SKColor.black, size: CGSize(width: self.frame.width / 8.8, height: self.frame.width / 8.8))
                box.position = CGPoint(x: xPosition, y: yPositionUp - box.frame.height / 2)
                innerBox.position = box.position
                innerBox.zPosition = 2  // Stand out from the main box
                box.hitpoints = levelNumber
                box.name = "outerBox"
                innerBox.name = "innerBox"
                box.zPosition = 1
                // Must add a body if we want collisions
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                // What is this node?
                box.physicsBody?.categoryBitMask = PhysicsCategory.Box
                // What do we want to know about if it collides with us? Callback for contact
                box.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                box.physicsBody?.collisionBitMask = PhysicsCategory.Ball
                box.physicsBody?.affectedByGravity = false
                box.physicsBody?.isDynamic = false
                box.physicsBody?.friction = 0
                box.physicsBody?.restitution = 1.0
                
                createBoxLabel()
                
                box.addChild(innerBox)
                
                self.addChild(box)
                // I don't think this is needed
                // self.addChild(innerBox)
            }
        }
        for node in self.children
        {
            // Move all existing boxes down
            if let box = node as? Box
            {
                // checking if there is one or more boxes which touched the game -> if yes gameover:(
                if box.name == "outerBox"
                {
                    box.hasMovedDown += 1
                }
                // setting up the action so that the boxes move down and then a function is called to check whether the game is over or not
                let moveDown = SKAction.moveTo(y: node.position.y - self.frame.width / 7, duration: 0.8)
                let checkIfGameOver = SKAction.run(checkIfGameIsOver)
                let moveDownCheck = SKAction.sequence([moveDown, checkIfGameOver])
                box.run(moveDownCheck)
            }
            if let label = node as? SKLabelNode
            {
                // moving down only the labels of a box
                if let _ = Int(label.name!){
                    let moveDown = SKAction.moveTo(y: node.position.y - self.frame.width / 7, duration: 0.8)
                    label.run(moveDown)
                }
            }
        }
    }
    
    func createBoxLabel()
    {
        let boxLabel = SKLabelNode(text: "\(levelNumber)")
        boxLabel.color = UIColor.white
        boxLabel.fontSize = 50
        boxLabel.fontName = "Kailasa"
        boxLabel.position = CGPoint(x: BoxStartx , y: BoxRowStarty - self.frame.width / 14 - (boxLabel.frame.height / 2))
        boxLabel.zPosition = 3
        boxLabel.name = "\(levelNumber)"
        
        xPosition += self.frame.width / 7
        
        self.addChild(boxLabel)
        labelArray.append(boxLabel)
    }
    

}





















