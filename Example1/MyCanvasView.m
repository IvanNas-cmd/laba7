#import "MyCanvasView.h"

@implementation MyCanvasView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainImage.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch != nil) {
        self.lastPoint = [touch locationInView:self.view];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch == nil) return;
    
    CGPoint currentPoint = [touch locationInView:self.view];
    [self drawLinearPathFromPoint:self.lastPoint toPoint:currentPoint];
    self.lastPoint = currentPoint;
}

- (void)drawLinearPathFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context != NULL) {
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 4.0);
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0); // Черный цвет по умолчанию
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
        CGContextStrokePath(context);
    }
    
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
