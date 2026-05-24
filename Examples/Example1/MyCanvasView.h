#import <UIKit/UIKit.h>

@interface MyCanvasView : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (nonatomic) CGPoint lastPoint;

- (void)drawLinearPathFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;

@end
