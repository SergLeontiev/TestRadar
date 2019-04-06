import UIKit

class RadarViewController: UIViewController {

    var radius = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radius = (widthScreen - 20) / CGFloat(2) / CGFloat(numberCircles)
        for i in 1...numberCircles {
            drawCircle(radius: radius * CGFloat(i))
        }
    }
    
    func drawCircle(radius: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: centerScreen, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor

        view.layer.addSublayer(shapeLayer)
    }

}
