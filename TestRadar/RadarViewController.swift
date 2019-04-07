import UIKit

class RadarViewController: UIViewController {

    var stepCircles = CGFloat()
    var circlesRadius: [CGFloat] = []
    var sideRect = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepCircles = maxRadius / CGFloat(numberCircles)
        sideRect = stepCircles / sqrt(2)
        
        for i in 1...numberCircles {
            let currentRadius = stepCircles * CGFloat(i)
            drawCircle(radius: currentRadius)
            circlesRadius.append(currentRadius)
        }

        for _ in 1...numberPlanes {
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

        let points = [
            CGPoint(x: randomX, y: randomY),
            CGPoint(x: randomX + sideRect, y: randomY),
            CGPoint(x: randomX, y: randomY + sideRect),
            CGPoint(x: randomX + sideRect, y: randomY + sideRect)
        ]
        
        var k = 0
        for i in stride(from: 0, to: circlesRadius.count - 1, by: 2) {
            k = 0
            for point in points {
                if check(point: point, radusMin: circlesRadius[i], radiusMax: circlesRadius[i + 1]) {
                    k += 1
                }
            }
            if k == 4 {
                return CGRect(x: randomX, y: randomY, width: sideRect, height: sideRect)
            }
        }
        
        return randomRectPlane()
    }

    func check(point: CGPoint, radusMin: CGFloat, radiusMax: CGFloat) -> Bool {
        let kek = pow(Double(point.x - centerX), 2) + pow(Double(point.y - centerY), 2)
        
        return kek > pow(Double(radusMin), 2) && kek < pow(Double(radiusMax), 2)
    }

}
