import UIKit

class PrimitivesView: UIView {
    
    override func draw(_ rect: CGRect) {
        // 1. Рисование сплошного прямоугольника
        let rectPath = UIBezierPath(rect: CGRect(x: 20, y: 20, width: 100, height: 80))
        UIColor.systemBlue.setFill()
        rectPath.fill()
        
        // 2. Рисование окружности (эллипса в квадрате)
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 150, y: 20, width: 80, height: 80))
        UIColor.systemGreen.setFill()
        ovalPath.fill()
        UIColor.black.setStroke()
        ovalPath.lineWidth = 2.0
        ovalPath.stroke()
        
        // 3. Рисование произвольной ломаной линии
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 20, y: 150))
        linePath.addLine(to: CGPoint(x: 100, y: 220))
        linePath.addLine(to: CGPoint(x: 200, y: 130))
        UIColor.systemRed.setStroke()
        linePath.lineWidth = 4.0
        linePath.stroke()
    }
}
