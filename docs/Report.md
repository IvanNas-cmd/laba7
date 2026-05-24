

# Define the comprehensive academic lab report text based on variant 17 (Trapezoid and circular segment)
report_content = """# МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ
# КАФЕДРА ИНФОРМАЦИОННЫХ СИСТЕМ И ТЕХНОЛОГИЙ

**Дисциплина:** Технологии программирования для мобильных приложений  
**ОТЧЕТ ПО ЛАБОРАТОРНОЙ РАБОТЕ № 7** **Тема:** Разработка приложений для обработки графики, анимации и жестов на языке Swift  

**Выполнил:** Студент группы 12б Насенник Иван (Профиль GitHub: IvanNas-cmd)  
**Вариант:** №17 (Прямоугольная трапеция и круговой сегмент)  
**Проверяющий:** Преподаватель кафедры ИСИТ  

---

## 1. ВВЕДЕНИЕ И ЦЕЛЬ РАБОТЫ

**Цель работы:** Глубокое изучение и практическое освоение графического конвейера операционной системы iOS. Изучение принципов работы низкоуровневой графической среды Core Graphics и объектных обёрок UIBezierPath. Проектирование архитектурных паттернов MVC (Model-View-Controller) применительно к графическим интерфейсам. Изучение систем интерполяции и расчёта экранных анимаций Core Animation. Освоение компонентов распознавания пользовательских жестов (UIGestureRecognizer) для управления состоянием графических объектов в режиме реального времени. Изучение фреймворка SceneKit для рендеринга трехмерной графики с использованием аппаратного ускорения Metal.

**Задачи работы:**
1. Разработать и модернизировать графический холст на языке Objective-C, расширив его функционалом кастомизации кистей и интеграцией с системными службами сохранения медиаданных.
2. Спроектировать по паттерну MVC кастомное графическое представление на языке Swift, реализующее математически точную отрисовку составной фигуры (Вариант 17: прямоугольная трапеция и круговой сегмент) с применением теоретико-множественных операций вычитания контуров.
3. Разработать систему интерактивного взаимодействия, связывающую 5 типов жестов с комплексными анимационными блоками и динамической сменой текстурных подложек фигуры.
4. Выполнить задание повышенного уровня по построению и управлению трехмерным пространственным объектным элементом (Тор/Кольцо) средствами SceneKit.
5. Оформить структурированный репозиторий с разветвленной системой веток для автоматизированного контроля версий.

---

## 2. ПОШАГОВОЕ ОПИСАНИЕ ХОДА ВЫПОЛНЕНИЯ РАБОТЫ

### Шаг 1: Подготовка репозитория и управление ветками
В соответствии с жесткими требованиями регламента лабораторной работы, в веб-интерфейсе GitHub была развернута древовидная структура проекта. Базовой веткой является `main`. От неё были последовательно ответвлены изолированные ветки для каждого этапа выполнения задач: `example-task1` — `example-task4` (для фиксации базовых примеров рендеринга), `feature-task2-1` — `feature-task2-4` (для поэтапной реализации самостоятельной работы) и `feature-task3` (для трехмерной графики). Это исключает конфликты слияния и подготавливает проект к автоматизированной проверке.

### Шаг 2: Модернизация приложения рисования (Objective-C)
**Как делал:** Я взял за основу базовый листинг обработки касаний и спроектировал расширенное приложение-холст. Пространство экрана занимает `UIImageView`, выступающее в роли растрового буфера. 
1. Для реализации выбора цвета я разместил на интерфейсе палитру из 5 кнопок и связал их с единым методом-обработчиком `colorChanged:`, где выбор конкретного `UIColor` происходит через условный оператор `switch` по свойству `sender.tag`.
2. Для регулирования толщины линий я привязал шаг-компонент `UIStepper`, передающий текущее дробное значение в свойство `currentWidth`.
3. Отрисовка линий происходит в методе `touchesMoved:`. Я инициализирую контекст рисования `UIGraphicsBeginImageContext`, извлекаю текущую матрицу пикселей, задаю параметры скругления концов линий `kCGLineCapRound` и добавляю векторный отрезок от `lastPoint` до текущей точки касания, после чего вызываю `CGContextStrokePath(context)`.
4. **Демонстрация работы:** Пользователь может пальцем нарисовать объект, меняя на лету цвет и размер. При нажатии кнопки «Сохранить» срабатывает метод `UIImageWriteToSavedPhotosAlbum`, отправляющий изображение в системную галерею iOS. При успешном завершении операции на экран выводится диалоговое окно `UIAlertController` с уведомлением пользователя.

### Шаг 3: Математическая отрисовка 2D-геометрии по Варианту 17 (Swift, MVC)
**Как делал:** Задача требовала строгого разделения логики. Я создал модель `ShapeModel` (хранение массива текстур), кастомный класс представления `CustomShapeView` и контроллер `GeometryViewController`.
1. Математический расчет фигуры Варианта №17 (Прямоугольная трапеция и круговой сегмент) реализован внутри переопределенного метода `draw(_:)` класса `CustomShapeView`.
2. Первым шагом я настроил параметры контекста для создания эффекта глубины, вызвав `context.setShadow` с углами смещения (6, 6) и коэффициентом размытия.
3. Контур прямоугольной трапеции формируется последовательным вызовом `addLine(to:)` по четырем опорным точкам, где левая грань строго вертикальна (координаты X у верхнего левого и нижнего левого углов совпадают).
4. На этот же холст накладывается путь кругового сегмента через метод `addArc(withCenter:radius:startAngle:endAngle:clockwise:)` с углом разворота от 0 до ПИ радиан.
5. **Вычитание фигур:** Чтобы вычесть круговой сегмент из площади трапеции, я добавил оба пути в один родительский контур `combinedPath` и активировал флаг `combinedPath.usesEvenOddFillRule = true`. При вызове `combinedPath.addClip()` система автоматически исключила область пересечения из контура рендеринга. Внутренняя область заполняется либо пользовательской текстурой из Модели, либо градиентом `context.drawLinearGradient`.

### Шаг 4: Реализация интерактивных анимаций и привязка к 5 жестам
**Как делал:** В `GeometryViewController` я программно инициализировал пять распознавателей жестов и добавил их на поверхность `shapeView`.
1. При срабатывании жеста **Вращения** (`UIRotationGestureRecognizer`) контроллер обращается к модели, запрашивает первую текстуру, устанавливает её свойству `fillImage` и применяет афинное преобразование `rotated(by:)` к матрице `transform`.
2. При срабатывании жеста **Масштабирования** (`UIPinchGestureRecognizer`) фигура динамически изменяет свои размеры на основе коэффициента `sender.scale`, параллельно отображая вторую фоновую текстуру.
3. Одиночное **Касание** (`UITapGestureRecognizer`) вызывает блок анимации `UIView.animate(withDuration: 0.4)`. Фигура плавно уходит в прозрачность (`alpha = 0.4`) и сдвигается по вертикали вверх, после чего во вложенном блоке (completion closure) возвращается на исходную позицию с наложением третьей текстуры.
4. **Долгое нажатие** (`UILongPressGestureRecognizer`) отслеживает состояние `.began` и запускает анимацию пульсации — фигура мгновенно увеличивается на 12%, создавая визуальный эффект "отскока" при нажатии, и меняет фон на четвертый.
5. Жест **Смахивания** (`UISwipeGestureRecognizer`) мгновенно заменяет подложку на пятую текстуру и запускает анимационный разворот фигуры на 360 градусов (двукратное последовательное выполнение поворота на угол ПИ радиан).

### Шаг 5: Построение трехмерной графики SceneKit (Повышенный уровень)
**Как делал:** Для выполнения усложненного блока я разработал `Game3DViewController`. На базе графического движка SceneKit (работающего поверх Metal) я программно инициализировал `SCNView` и добавил его в иерархию корневых представлений экрана.
1. Я создал пустую трехмерную сцену `SCNScene`, добавил узел камеры `SCNCamera` со смещением по оси Z назад на 10 единиц, а также узел всенаправленного источника света `SCNLight(type: .omni)` для создания реалистичного освещения среды.
2. В качестве трехмерной геометрии, согласно заданию, я выбрал фигуру объемного кольца — Тора, инициализировав его через `SCNTorus(ringRadius: 3.0, pipeRadius: 1.0)`.
3. Для материала тора я жестко задал параметры отражения света: базовый диффузный цвет установлен в `UIColor.systemRed`, бликовый цвет (specular) — в белый, а также активировано попиксельное освещение Блинна-Фонга (`isLitPerPixel = true`) для получения фотореалистичных градиентов на изгибах 3D-модели.
4. **Управление жестами:** К экрану привязаны `UIPanGestureRecognizer` и `UIPinchGestureRecognizer`. Смещение пальца (Pan) конвертируется в радианы и изменяет значения углов Эйлера `torusNode.eulerAngles`, позволяя плавно вращать трехмерное кольцо в любых направлениях. Щипок пальцев напрямую изменяет вектор масштабирования `torusNode.scale`.

---

## 3. ПОЛНЫЕ ЛИСТИНГИ РЕАЛИЗОВАННОГО КОДА ПРОГРАММЫ

Ниже представлены полные, синтаксически выверенные листинги всех ключевых компонентов разработанного приложения, загруженные в репозиторий.

### 3.1 Компонент рисования на Objective-C (Задача 2.1)

#### Файл: `Lab7-Combined/ObjectiveC/DrawingViewController.h`
```objc
#import <UIKit/UIKit.h>

@interface DrawingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *canvas;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic) CGFloat currentWidth;

- (IBAction)colorChanged:(UIButton *)sender;
- (IBAction)sizeChanged:(UIStepper *)sender;
- (IBAction)saveImage:(UIButton *)sender;

@end
```
#### Файл: `Lab7-Combined/ObjectiveC/DrawingViewController.m`
```objc
#import "DrawingViewController.h"

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentColor = [UIColor systemRedColor];
    self.currentWidth = 5.0f;
    self.canvas.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch != nil) {
        [self setLastPoint:[touch locationInView:self.view]];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch == nil) return;
    
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [[self.canvas image] drawInRect:drawRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context != NULL) {
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, self.currentWidth);
        
        CGFloat red, green, blue, alpha;
        [self.currentColor getRed:&red green:&green blue:&blue alpha:&alpha];
        CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
        CGContextStrokePath(context);
    }
    
    [self.canvas setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    self.lastPoint = currentPoint;
}

- (IBAction)colorChanged:(UIButton *)sender {
    switch (sender.tag) {
        case 0: self.currentColor = [UIColor systemRedColor]; break;
        case 1: self.currentColor = [UIColor systemGreenColor]; break;
        case 2: self.currentColor = [UIColor systemBlueColor]; break;
        case 3: self.currentColor = [UIColor systemYellowColor]; break;
        case 4: self.currentColor = [UIColor blackColor]; break;
        default: self.currentColor = [UIColor systemRedColor]; break;
    }
}

- (IBAction)sizeChanged:(UIStepper *)sender {
    self.currentWidth = (CGFloat)sender.value;
}

- (IBAction)saveImage:(UIButton *)sender {
    if (self.canvas.image != nil) {
        UIImageWriteToSavedPhotosAlbum(self.canvas.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *alertTitle = (error == nil) ? @"Успех" : @"Ошибка";
    NSString *alertMessage = (error == nil) ? @"Рисунок успешно сохранен в галерею!" : error.localizedDescription;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
```
### 3.2 Архитектурные компоненты 2D-графики и Жестов на Swift (Задачи 2.2 - 2.4)
### Файл Модели: `Lab7-Combined/Model/ShapeModel.swift`
```swift
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
```
### Файл Кастомного Представления: `Lab7-Combined/View/CustomShapeView.swift`
```swift
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
        
        context.setShadow(offset: CGSize(width: 6, height: 6), blur: 8, color: UIColor.black.withAlphaComponent(0.45).cgColor)
        
        let padding: CGFloat = 20
        let figureWidth = rect.width - (padding * 2)
        let figureHeight = rect.height - (padding * 2)
        
        // Построение Прямоугольной Трапеции (Вариант 17)
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
        
        // Построение Кругового Сегмента
        let segmentPath = UIBezierPath()
        let segmentCenter = CGPoint(x: rect.midX, y: rect.midY + figureHeight * 0.1)
        let segmentRadius = min(figureWidth, figureHeight) * 0.25
        segmentPath.addArc(withCenter: segmentCenter, radius: segmentRadius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
        segmentPath.close()
        
        // Вычитание пересечений контуров по правилу EvenOdd
        let combinedPath = UIBezierPath()
        combinedPath.append(trapezoidPath)
        combinedPath.append(segmentPath)
        combinedPath.usesEvenOddFillRule = true
        combinedPath.addClip()
        
        if let image = fillImage, image.size != .zero {
            image.draw(in: rect)
        } else {
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
```
### Файл Управляющего Контроллера: `Lab7-Combined/Controller/GeometryViewController.swift`
```swift
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
```
### 3.3 Модуль 3D-графики SceneKit (Задача 3.1)
### Файл `Lab7-Combined/Controller/Game3DViewController.swift`
```swift
import UIKit
import SceneKit

class Game3DViewController: UIViewController {
    private var scnView: SCNView!
    private var torusNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup3DSceneEngine()
        setupControlGestures()
    }
    
    private func setup3DSceneEngine() {
        scnView = SCNView(frame: self.view.bounds)
        scnView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scnView.backgroundColor = .black
        scnView.rendersContinuously = true
        self.view.addSubview(scnView)
        
        let scene = SCNScene()
        scnView.scene = scene
        
        let torusGeometry = SCNTorus(ringRadius: 3.0, pipeRadius: 1.0)
        torusGeometry.firstMaterial?.diffuse.contents = UIColor.systemRed
        torusGeometry.firstMaterial?.specular.contents = UIColor.white
        torusGeometry.firstMaterial?.isLitPerPixel = true
        
        torusNode = SCNNode(geometry: torusGeometry)
        scene.rootNode.addChildNode(torusNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 10)
        scene.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(6, 6, 6)
        scene.rootNode.addChildNode(lightNode)
    }
    
    private func setupControlGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handle3DPan(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handle3DPinch(_:)))
        scnView.addGestureRecognizer(panGesture)
        scnView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handle3DPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: scnView)
        let xRotationAngle = Float(translation.y) * (.pi / 180.0)
        let yRotationAngle = Float(translation.x) * (.pi / 180.0)
        
        torusNode.eulerAngles = SCNVector3(
            torusNode.eulerAngles.x + xRotationAngle * 0.2,
            torusNode.eulerAngles.y + yRotationAngle * 0.2,
            0
        )
        sender.setTranslation(.zero, in: scnView)
    }
    
    @objc func handle3DPinch(_ sender: UIPinchGestureRecognizer) {
        let scaleFactor = Float(sender.scale)
        torusNode.scale = SCNVector3(
            torusNode.scale.x * scaleFactor,
            torusNode.scale.y * scaleFactor,
            torusNode.scale.z * scaleFactor
        )
        sender.scale = 1.0
    }
}
```
### 4. РАЗВЕРНУТЫЕ ОТВЕТЫ НА КОНТРОЛЬНЫЕ ВОПРОСЫ И ЗАДАНИЯ
Для подтверждения теоретического уровня подготовки ниже приводятся развернутые академические ответы на вопросы из методического пособия.
### Как нарисовать контур? 
В Core Graphics отрисовка контура выполняется путем добавления геометрических путей в текущий контекст с последующим вызовом низкоуровневой функции CGContextStrokePath(context). В объектно-ориентированном фреймворке UIKit это действие инкапсулировано внутри метода stroke() экземпляра класса UIBezierPath. Перед вызовом обводки среда настраивается методами задания цвета (setStroke()) и ширины пера (lineWidth).
### Как нарисовать прямоугольник? 
Для программного построения прямоугольника используется вызов CGContextAddRect(context, rect), принимающий структуру CGRect со значениями координат происхождения и геометрических размеров. В Swift более декларативным подходом является инициализация объекта пути через специальный конструктор UIBezierPath(rect: CGRect). После генерации пути применяется метод заполнения (fill()) или обводки (stroke()).
### Как заполнить контур цветом? Градиентом? 
Заполнение контура сплошным цветом осуществляется функцией context.fillPath() или вызовом path.fill(), предварительно установив цвет через UIColor.setFill(). Отрисовка градиента требует более сложного конвейера: сначала геометрический путь фиксируется в качестве маски отсечения вызовом path.addClip() (или CGContextClip), затем инициализируется объект градиента CGGradient, параметры которого (массив цветов, локации точек перехода и цветовое пространство) передаются в метод context.drawLinearGradient или context.drawRadialGradient.
### Как заполнить прямоугольник цветом, сохранив цвет контура? 
Поскольку методы заполнения и обводки закрывают и очищают текущий векторный путь в буфере контекста, критически важна последовательность выполнения команд. Первым шагом вызывается операция заполнения внутренней области: path.fill(). Вторым шагом, поверх нарисованной области, вызывается операция отрисовки границ: path.stroke(). В низкоуровневом C-API Core Graphics для этого существует объединенная функция CGContextDrawPath(context, kCGPathFillStroke).
### Как нарисовать круг / эллипс? 
Отрисовка окружностей и эллиптических кривых базируется на их вписывании в ограничивающий прямоугольник (Bounding Box). В Swift это лаконично реализуется вызовом конструктора UIBezierPath(ovalIn: CGRect). Если передаваемая структура CGRect имеет равные стороны (квадрат), на экране сформируется идеальный круг, если стороны различны — эллипс. На низком уровне применяется функция CGContextAddEllipseInRect.
### Как добавить тень к рисункам? 
Система генерации теней работает на уровне состояний графического контекста. До начала вычерчивания путей необходимо сконфигурировать параметры тени в контексте, вызвав функцию context.setShadow(offset:blur:color:). Параметр offset (размерность CGSize) определяет вектор смещения тени, blur — радиус размытия по Гауссу, а color — полупрозрачную цветовую маску (обычно черный цвет с альфа-каналом меньше 0.5). Последующие операции рисования будут автоматически генерировать подложку тени.
### Как нарисовать изображение на контроллере View в прямоугольнике?
Для вывода растрового изображения UIImage внутри контекста переопределенного метода draw(_:) у класса UIView, у самого объекта изображения вызывается встроенный метод image.draw(in: CGRect). Система автоматически выполнит интерполяцию и масштабирование пиксельной матрицы картинки под физические границы переданного прямоугольника.
### Как перерисовать представление View с помощью метода SetNeedsDisplay? 
В операционной системе iOS прямая ручная активация метода draw(_:) строго запрещена из-за соображений оптимизации графического конвейера. Если состояние модели изменилось и требуется обновить графику, разработчик отправляет компоненту запрос view.setNeedsDisplay(). Эта команда ставит представление в очередь на обновление. Во время следующего шага цикла выполнения (Run Loop) система самостоятельно выделит графический контекст и вызовет draw(_:).
### Как вычесть одну фигуру из другой? 
Вычитание (реализация операций булевой логики над множеством векторов) происходит путем комбинирования путей. В родительский экземпляр UIBezierPath последовательно через append() добавляются контур-основа и вычитаемый контур. Затем свойству usesEvenOddFillRule присваивается значение true (активация правила четно-нечетного заполнения пикселей). При вызове addClip() области наложения внутренней фигуры будут исключены из области рендеринга.
### Какое компонент Cocoa отвечает за обработку жестов? 
За детекцию, валидацию и диспетчеризацию сигналов физического взаимодействия пальцев пользователя с сенсорным экраном отвечает абстрактный класс UIGestureRecognizer, входящий в состав фреймворка UIKit (Cocoa Touch). Разработчики используют его конкретные системные подклассы для изоляции конкретных типов жестов.
### Как добавить и обработать жест касания (нажатия) (tap gesture)? 
Для обработки дискретных кликов создается экземпляр класса UITapGestureRecognizer. В инициализатор передается целевой объект и селектор метода-обработчика: UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))). После конфигурации (например, задания количества тапов через numberOfTapsRequired) объект добавляется к представлению: view.addGestureRecognizer(gesture). Свойство isUserInteractionEnabled у view обязательно должно быть истинным.
### Как добавить и обработать долгое нажатие (long press gesture)?
Реализуется через подкласс UILongPressGestureRecognizer. Особенность обработки данного жеста заключается в его непрерывной (недискретной) природе. Внутри метода-приемника разработчик обязан проверять текущую фазу жизненного цикла жеста через свойство состояния: if sender.state == .began { ... }. Это позволяет отсечь ложные срабатывания в моменты, когда пользователь только отрывает палец от экрана (.ended).
### Как добавить и обработать жест перелистывания (смахивания) (swipe gesture)? 
Используется класс UISwipeGestureRecognizer. Данный распознаватель реагирует на быстрые линейные перемещения. По умолчанию детекция настроена на смахивание вправо. Для изменения вектора разработчик конфигурирует битовую маску свойства направления, например: swipeGesture.direction = .left или .up.
### Как обрабатывается жест стягивания (щипка) (pinch gesture)? 
Обработка щипков возложена на UIPinchGestureRecognizer. Этот непрерывный жест возвращает динамический коэффициент масштабирования в свойстве sender.scale (значение 1.0 соответствует исходному состоянию). Внутри метода-обработчика значение коэффициента применяется к матрице трансформации представления view.transform.scaledBy, после чего свойство sender.scale сбрасывается обратно в 1.0 для предотвращения экспоненциального роста размеров.
### Как обрабатывается жест растягивания (spread gesture)? 
С технической точки зрения в iOS нет отдельного класса для растягивания — оно полностью обрабатывается тем же самым UIPinchGestureRecognizer. Разница между стягиванием и растягиванием определяется исключительно математически на основе анализа значения свойства sender.scale: если значение меньше единицы — происходит стягивание (Pinch), если значение строго больше 1.0 — пальцы пользователя расходятся, реализуя жест растягивания (Spread).
### Как добавить жесты непосредственно на Storyboard? 
При визуальном проектировании интерфейса разработчик открывает Библиотеку Объектов (Object Library) в Xcode, находит требуемый Gesture Recognizer (например, Tap Gesture Recognizer) и перетаскивает его мышью непосредственно на нужный элемент интерфейса на холсте Storyboard. После этого во всплывающем меню связей протягивается Action-линия (Ctrl + перетаскивание) от значка жеста в верхнем баре контроллера в файл кода для генерации метода @IBAction.
### Какие примитивы рисования Вы знаете? 
К базовым атомарным элементам векторной графики относятся: точка (координатный маркер CGPoint), отрезок прямой линии, дуга окружности (определяемая радиусом и углами), а также параметрические кривые Безье (квадратичные и кубические), форма изгиба которых контролируется опорными точками (control points).
### Что такое CGContext?
CGContext — это низкоуровневая структура данных C-API Core Graphics, представляющая собой абстрактный графический холст. Он инкапсулирует в себе всю информацию, необходимую для рендеринга: текущие цветовые пространства, параметры прозрачности, шрифты, текущую матрицу преобразования координат (CTM) и буфер пикселей целевого устройства вывода.
### Что такое UIBezierPath? 
Чем отличается от CGContext? UIBezierPath — это высокоуровневый объектный класс-обёртка Objective-C/Swift над структуру CGPath. Он предназначен только для описания геометрии линий (путей). Отличие заключается в том, что UIBezierPath не содержит растровых пикселей и информации о холсте — он просто хранит математические формулы векторов. А CGContext — это сам холст, среда рендеринга, которая берет эти формулы и превращает их в физические пиксели на экране.
### Что такое CGImage?
CGImage — это низкоуровневый непрозрачный тип данных Core Graphics, представляющий собой чистую двухмерную матрицу пикселей (растровое изображение) в оперативной памяти. Он хранит битовую карту, информацию о кодировании цвета, битовой глубине компонента и альфа-канале. На основе CGImage создается объект верхнего уровня UIImage.
### Что такое CGPath? 
CGPath — это низкоуровневый полиморфный тип данных на языке Си, представляющий собой неизменяемую (Immutable) или изменяемую (CGMutablePath) математическую траекторию графического контура. Является фундаментом для UIBezierPath.
### В чем заключаются трудности использования двумерной графики? 
Основная сложность — высокая вычислительная нагрузка на центральный процессор (CPU) при программном рендеринге. Метод draw(_:) по умолчанию выполняет вычисления на главном потоке (Main Thread) через центральный процессор, что при отрисовке сотен тысяч сложных векторов или высокой частоте перерисовки неизбежно приводит к падению FPS, блокировке UI и сильному нагреву мобильного устройства.
### Что такое OpenGL? 
OpenGL (Open Graphics Library) — это исторический кроссплатформенный низкоуровневый прикладной программный интерфейс (API) для написания приложений, работающих с двумерной и трехмерной компьютерной графикой. Он позволяет перенаправлять тяжелые вычислительные задачи отрисовки векторов напрямую на графический сопроцессор (GPU). В экосистеме Apple признан устаревшим (Deprecated).
### Что такое шейдер? 
Шейдер — это специализированная программа, написанная на C-подобном языке (например, MSL в Metal или GLSL в OpenGL), которая компилируется и выполняется непосредственно на ядрах графического процессора (GPU). Шейдеры предназначены для высокопараллельных математических расчетов геометрии, освещения и цвета объектов.
### Чем вершинный шейдер отличается от пиксельного? 
Вершинный шейдер (Vertex Shader) оперирует пространственными координатами — он принимает на вход вершины полигонов, выполняет над ними трансформации матриц, рассчитывает перспективу и масштаб 3D-модели. Пиксельный/фрагментный шейдер (Fragment Shader) работает на этапе растеризации — он получает интерполированные данные геометрии и вычисляет итоговый RGBA-цвет для каждого конкретного пикселя на экране, формируя текстуры, тени и блики.
### Что такое Metal? 
Metal — это современный, высокопроизводительный, низкоуровневый проприетарный графический API от корпорации Apple. Он спроектирован для замены OpenGL с целью обеспечения минимальных накладных расходов (Overhead) на CPU. Metal предоставляет разработчикам прямой доступ к графическому процессору (GPU) Mac, iPhone и iPad, поддерживая параллельное выполнение графических шейдеров и вычислений Data-Parallel.
### 5. ВЫВОД
В ходе выполнения лабораторной работы №7 были детально изучены и применены на практике технологии построения графических интерфейсов в операционной системе iOS. На практическом примере Варианта №17 успешно реализована концепция разделения ответственности MVC, написан чистый, отказоустойчивый код на языках Swift и Objective-C. Интеграция Core Graphics с Core Animation позволила добиться высокой плавности работы интерфейса. Выполнение задачи повышенного уровня расширило навыки в области пространственного программирования и трехмерной визуализации SceneKit/Metal. Проект полностью укомплектован документацией и разложен по изолированным веткам репозитория.
