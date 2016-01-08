//
//  QScoreView.m
//  QuizRun
//
//       3/25/14.
//     
//

#import "QScoreView.h"
#import "QCustomizer.h"

@implementation QScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (QScoreView *)loadView {
    return [[[NSBundle mainBundle]
             loadNibNamed:@"QScoreView_iPhone"
             owner:self options:nil]
            firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UIImage *)snapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
}


@end
