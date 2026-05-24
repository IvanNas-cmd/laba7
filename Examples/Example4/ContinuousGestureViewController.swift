import UIKit

class ContinuousGestureViewController: UIViewController {
    
    @IBOutlet weak var animatedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContinuousRecognizers()
    }
    
    private func setupContinuousRecognizers() {
        animatedView.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(processPinch(_:)))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(processRotation(_:)))
        
        animatedView.addGestureRecognizer(pinchGesture)
        animatedView.addGestureRecognizer(rotationGesture)
    }
    
    @objc func processPinch(_ sender: UIPinchGestureRecognizer) {
        guard let viewToScale = sender.view else { return }
        
        // Применение масштабирования к текущей матрице трансформации
        viewToScale.transform = viewToScale.transform.scaledBy(x: sender.scale, y: sender.scale)
        // Важно: сброс коэффициента для линейного изменения размеров
        sender.scale = 1.0
    }
    
    @objc func processRotation(_ sender: UIRotationGestureRecognizer) {
        guard let viewToRotate = sender.view else { return }
        
        // Применение вращения на угол в радианах
        viewToRotate.transform = viewToRotate.transform.rotated(by: sender.rotation)
        // Важно: сброс угла для предотвращения рывков анимации
        sender.rotation = 0
    }
}
