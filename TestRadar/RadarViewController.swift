import UIKit

class RadarViewController: UIViewController {

    var stepCircles = CGFloat()
    var circlesRadius = [CGFloat()]
    var sideRect = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepCircles = maxRadius / CGFloat(numberCircles)
        sideRect = stepCircles / 2

        for i in 1...numberCircles {
            let currentRadius = stepCircles * CGFloat(i)
            drawCircle(radius: currentRadius)
            circlesRadius.append(currentRadius)
        }

        for _ in 0..<numberPlanes {
            insertPlane()
        }
    }
    
    func drawCircle(radius: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: centerScreen, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor

        self.view.layer.addSublayer(shapeLayer)
    }

    func insertPlane() {
        let rectPlane = randomRectPlane()
        let planeImage = UIImage(named: "plane")!.cgImage
        
        let shapeLayer = CALayer()
        shapeLayer.frame = rectPlane
        shapeLayer.contents = planeImage
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
    func randomRectPlane() -> CGRect {
        let randomX = CGFloat.random(in: (centerX - maxRadius)...(centerX + maxRadius))
        let randomY = CGFloat.random(in: (centerY - maxRadius)...(centerY + maxRadius))

        let rectPoints = [
            CGPoint(x: randomX, y: randomY),
            CGPoint(x: randomX + sideRect, y: randomY),
            CGPoint(x: randomX, y: randomY + sideRect),
            CGPoint(x: randomX + sideRect, y: randomY + sideRect)
        ]
        
        for i in 0..<circlesRadius.count - 1 {
            var countHitsPoints = 0
            for point in rectPoints {
                if isPointInRing(point: point, radusMin: circlesRadius[i], radiusMax: circlesRadius[i + 1]) {
                    countHitsPoints += 1
                }
            }
            if countHitsPoints == rectPoints.count {
                return CGRect(x: randomX, y: randomY, width: sideRect, height: sideRect)
            }
        }
        
        return randomRectPlane()
    }

    func isPointInRing(point: CGPoint, radusMin: CGFloat, radiusMax: CGFloat) -> Bool {
        let halfCircleEquation = pow(Double(point.x - centerX), 2) + pow(Double(point.y - centerY), 2)
        
        return sqrt(halfCircleEquation) > Double(radusMin) && sqrt(halfCircleEquation) < Double(radiusMax)
    }

}
