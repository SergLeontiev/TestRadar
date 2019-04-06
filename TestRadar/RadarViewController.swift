import UIKit

class RadarViewController: UIViewController {

    var radius = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radius = maxRadius / CGFloat(numberCircles)
        for i in 1...numberCircles {
            drawCircle(radius: radius * CGFloat(i))
        }
        
        insertPlane()
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
        let randomX = CGFloat.random(in: (centerX - maxRadius)...(centerX + maxRadius))
        let randomY = CGFloat.random(in: (centerY - maxRadius)...(centerY + maxRadius))
        
        let planeImage = UIImage(named: "plane")!.cgImage

        let shapeLayer = CALayer()
        shapeLayer.frame = CGRect(x: randomX, y: randomY, width: radius, height: radius)
        shapeLayer.contents = planeImage
        
        self.view.layer.addSublayer(shapeLayer)
    }

}
