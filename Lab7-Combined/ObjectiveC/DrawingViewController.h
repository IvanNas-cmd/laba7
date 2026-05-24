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
