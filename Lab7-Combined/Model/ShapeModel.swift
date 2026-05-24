import UIKit

struct ShapeModel {
    private(set) var availableBackgrounds: [UIImage] = []
    private(set) var currentBackgroundIndex: Int = 0
    
    init() {
        for index in 1...5 {
            if let image = UIImage(named: "bg\(index)") {
                availableBackgrounds.append(image)
            } else {
                let color: UIColor
                switch index {
                case 1: color = .systemBlue
                case 2: color = .systemRed
                case 3: color = .systemGreen
                case 4: color = .systemOrange
                default: color = .systemGray
                }
                availableBackgrounds.append(createDummyImage(color: color))
            }
        }
    }
    
    mutating func setBackground(for index: Int) -> UIImage? {
        guard index >= 0 && index < availableBackgrounds.count else { return nil }
        currentBackgroundIndex = index
        return availableBackgrounds[index]
    }
    
    private func createDummyImage(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
