import UIKit

class GeometryViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var shapeView: CustomShapeView!
    private var model = ShapeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        guard shapeView != nil else { return }
        shapeView.isUserInteractionEnabled = true
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        
        rotationGesture.delegate = self
        pinchGesture.delegate = self
        
        shapeView.addGestureRecognizer(rotationGesture)
        shapeView.addGestureRecognizer(pinchGesture)
        shapeView.addGestureRecognizer(tapGesture)
        shapeView.addGestureRecognizer(longPressGesture)
        shapeView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleRotation(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .began { shapeView.fillImage = model.setBackground(for: 0) }
        shapeView.transform = shapeView.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began { shapeView.fillImage = model.setBackground(for: 1) }
        shapeView.transform = shapeView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        shapeView.fillImage = model.setBackground(for: 2)
        UIView.animate(withDuration: 0.4, animations: {
            self.shapeView.alpha = 0.4
            self.shapeView.transform = self.shapeView.transform.translatedBy(x: 0, y: -40)
        }) { _ in
            UIView.animate(withDuration: 0.4) {
                self.shapeView.alpha = 1.0
                self.shapeView.transform = self.shapeView.transform.translatedBy(x: 0, y: 40)
            }
        }
    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            shapeView.fillImage = model.setBackground(for: 3)
            UIView.animate(withDuration: 0.2, animations: {
                self.shapeView.transform = self.shapeView.transform.scaledBy(x: 1.12, y: 1.12)
            }) { _ in
                UIView.animate(withDuration: 0.2) { self.shapeView.transform = .identity }
            }
        }
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        shapeView.fillImage = model.setBackground(for: 4)
        UIView.animate(withDuration: 0.5) {
            self.shapeView.transform = self.shapeView.transform.rotated(by: .pi)
            self.shapeView.transform = self.shapeView.transform.rotated(by: .pi)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
