import Foundation
let ball = OvalShape(width: 40, height: 40)

var barriers: [Shape] = []

let funnelPoints = [
Point(x: 0, y: 50), Point (x: 80, y: 50), Point(x: 60, y: 0), Point (x: 20, y: 0)]
let funnel = PolygonShape(points: funnelPoints)





fileprivate func setupBall() {
    ball.position = Point(x: 250, y: 400)
    ball.hasPhysics = true
    ball.fillColor = .blue
    ball.isDraggable = false
    ball.bounciness = 0.6
    scene.add (ball)
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
    
    
    
}

fileprivate func addBarrier(at position: Point, width: Double, height:Double,
                angle:Double) {
    // Add a barrier to the scene
    let barrierPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: height),
        Point(x: width, y: height),
        Point(x: width, y: 0)
    ]
    
    let barrier = PolygonShape(points: barrierPoints)
    
    barriers.append(barrier)
    
    barrier.position = position
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.angle = angle
    scene.add (barrier)}


fileprivate func setupFunnel() {
    // Add a funnel to the scene.
    funnel.position = Point (x: 200, y: scene.height - 25)
    funnel.isDraggable = false
    scene.add (funnel)
}


//I Drops the ball by moving it to the funnel's position.
func dropBall () {
    ball.position = funnel.position
    ball.stopAllMotion()
    for barrier in barriers {barrier.isDraggable = false}
    
}



func ballExitedScene(){
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene
    for barrier in barriers {barrier.isDraggable = true}
    
    var hitTragets = 0
    for target in targets {
        if target.fillColor == .green {
            hitTragets += 1
            //print(hitTragets)
        }
    }
    if hitTragets == targets.count {
        scene.presentAlert(text: "you won!", completion: alertDismissed)
        
    }
    
    for target in targets {
        target.fillColor = .yellow
    }
}


func alertDismissed(){}

func resetGame(){
    ball.position = Point(x: 0, y: -80)
}


func printPosition(of shape: Shape){
    print(shape.position)
}



func setup(){
    setupBall()
    addBarrier(at: Point(x: 200, y: 150), width: 88, height: 25, angle: 0.15)
    addBarrier(at: Point(x: 100 , y: 80), width: 60, height: 25, angle: -0.2)
    addBarrier(at: Point(x: 325, y: 150), width: 50, height: 25, angle: -0.2)
    addBarrier(at: Point(x: 80, y: 50), width: 50, height: 25, angle:  0.2)
    setupFunnel()
    addTarget(at: Point(x: 150, y: 400))
    addTarget(at: Point(x: 184, y: 563))
    addTarget(at: Point(x: 238, y: 624))
    addTarget(at: Point(x: 269 , y: 453))
    addTarget(at: Point(x: 317 , y: 187))



    
    
    
    
    
    func ballCollided(with otherShape: Shape){
        if otherShape.name != "target" {return}
        otherShape.fillColor = .green}
    
   
    funnel.onTapped = dropBall
    ball.onCollision = ballCollided(with:)
    
    resetGame()
    scene.onShapeMoved = printPosition(of:)
    
    // Add a barrier to the scene.
    
    }




let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
]

let target = PolygonShape(points:targetPoints)

var targets: [Shape] = []


func addTarget(at position: Point ) {
    let targetPoints = [
        Point(x: 10, y: 0),
        Point(x: 0, y: 10),
        Point(x: 10, y: 20),
        Point(x: 20, y: 10)
    ]
    let target = PolygonShape(points: targetPoints)
    
    targets.append(target)
    
    target.position = position
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.name = "target"
    target.fillColor = .yellow
    //target.isDraggable = false  //comment out to move the targets
    scene.add(target)
}


