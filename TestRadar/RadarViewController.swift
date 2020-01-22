import UIKit

class RadarViewController: UIViewController {

    var stepCircles: CGFloat {
        return maxRadius / CGFloat(numberCircles)
    }
    var sideRectPlane: CGFloat {
        return stepCircles / sqrt(2)
    }
    var circleRadiuses: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for radius in stride(from: stepCircles, to: maxRadius, by: stepCircles) {
            drawCircle(radius: radius)
            circleRadiuses.append(radius)
        }

        for _ in 0..<numberPlanes {
            insertPlane()
        }
    }
    
    func drawCircle(radius: CGFloat) {
        let circlePath = UIBezierPath(
            arcCenter: centerScreen,
            radius: radius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor

        self.view.layer.addSublayer(shapeLayer)
    }

    func insertPlane() {
        guard let planeImage = UIImage(named: "plane")?.cgImage else { return }
        
        let rectPlane = randomRectPlane()
        let shapeLayer = CALayer()
        shapeLayer.frame = rectPlane
        shapeLayer.contents = planeImage
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
    func randomRectPlane() -> CGRect {
        let randomRadius = circleRadiuses.randomElement()! - stepCircles / 2
        let randomAngle = Double.random(in: 0...360)
        
        let sizePlane = CGSize(width: sideRectPlane, height: sideRectPlane)
        var originPointPlane = convertPolarToCartesian(radius: Double(randomRadius), angle: randomAngle)
        originPointPlane.x += centerX - sideRectPlane / 2
        originPointPlane.y += centerY - sideRectPlane / 2
        
        return CGRect(origin: originPointPlane, size: sizePlane)
    }

    func convertPolarToCartesian(radius: Double, angle: Double) -> CGPoint {
        return CGPoint(x: radius * __cospi(angle / 180), y: radius * __sinpi(angle / 180))
    }

}
