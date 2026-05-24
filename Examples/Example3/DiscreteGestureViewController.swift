import UIKit

class DiscreteGestureViewController: UIViewController {
    
    @IBOutlet weak var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDiscreteRecognizers()
    }
    
    private func setupDiscreteRecognizers() {
        targetView.isUserInteractionEnabled = true
        
        // Создание распознавателя одинарного клика
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTarget(_:)))
        tapGesture.numberOfTapsRequired = 1
        targetView.addGestureRecognizer(tapGesture)
        
        // Создание распознавателя свайпа вправо
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeTarget(_:)))
        swipeGesture.direction = .right
        targetView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func didTapTarget(_ sender: UITapGestureRecognizer) {
        // Логика визуального отклика на касание
        targetView.backgroundColor = .systemOrange
    }
    
    @objc func didSwipeTarget(_ sender: UISwipeGestureRecognizer) {
        // Логика визуального отклика на свайп
        targetView.backgroundColor = .systemPurple
    }
}
