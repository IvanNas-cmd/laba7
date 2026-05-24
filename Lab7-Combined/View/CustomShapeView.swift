import UIKit

class CustomShapeView: UIView {
    var fillImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        
        // Добавление тени к рисунку (Контрольный вопрос 6)
        context.setShadow(offset: CGSize(width: 6, height: 6), blur: 8, color: UIColor.black.withAlphaComponent(0.45).cgColor)
        
        let padding: CGFloat = 20
        let figureWidth = rect.width - (padding * 2)
        let figureHeight = rect.height - (padding * 2)
        
        // 1. Фигура: Прямоугольная трапеция
        let trapezoidPath = UIBezierPath()
        let topLeft = CGPoint(x: padding, y: padding + figureHeight * 0.2)
        let topRight = CGPoint(x: padding + figureWidth * 0.7, y: padding + figureHeight * 0.2)
        let bottomRight = CGPoint(x: padding + figureWidth, y: padding + figureHeight)
        let bottomLeft = CGPoint(x: padding, y: padding + figureHeight)
        
        trapezoidPath.move(to: topLeft)
        trapezoidPath.addLine(to: topRight)
        trapezoidPath.addLine(to: bottomRight)
        trapezoidPath.addLine(to: bottomLeft)
        trapezoidPath.close()
        
        // 2. Фигура: Круговой сегмент
        let segmentPath = UIBezierPath()
        let segmentCenter = CGPoint(x: rect.midX, y: rect.midY + figureHeight * 0.1)
        let segmentRadius = min(figureWidth, figureHeight) * 0.25
        segmentPath.addArc(withCenter: segmentCenter, radius: segmentRadius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
        segmentPath.close()
        
        // 3. Вычитание одной фигуры из другой через EvenOdd (Контрольный вопрос 9)
        let combinedPath = UIBezierPath()
        combinedPath.append(trapezoidPath)
        combinedPath.append(segmentPath)
        combinedPath.usesEvenOddFillRule = true
        combinedPath.addClip()
        
        if let image = fillImage, image.size != .zero {
            image.draw(in: rect)
        } else {
            // Градиентная заливка контура (Контрольный вопрос 3)
            let colors = [UIColor.systemIndigo.cgColor, UIColor.systemPurple.cgColor] as CFArray
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: [0.0, 1.0]) else { return }
            context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: padding), end: CGPoint(x: 0, y: rect.height - padding), options: [])
        }
        
        context.restoreGState()
        UIColor.systemTeal.setStroke()
        combinedPath.lineWidth = 4.5
        combinedPath.stroke()
    }
}
