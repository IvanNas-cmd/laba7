#import "DrawingViewController.h"

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentColor = [UIColor systemRedColor];
    self.currentWidth = 5.0f;
    self.canvas.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch != nil) {
        [self setLastPoint:[touch locationInView:self.view]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
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
    NSString *alertMessage = (error == nil) ? @"Изображение успешно сохранено в библиотеку!" : error.localizedDescription;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
