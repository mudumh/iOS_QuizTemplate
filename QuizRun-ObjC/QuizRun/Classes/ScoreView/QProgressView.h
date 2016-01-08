//
//  QProgressView.h
//  QuizRun
//
//       1/13/14.
//     
//

#import <UIKit/UIKit.h>

static int radius = 65;

@interface QProgressView : UIView

@property (nonatomic,strong) UILabel *timeLabel;

- (void)addToView:(UIView *)viewToAdd andPosition:(CGPoint)framePosition andRadius:(float)circleRadius;
- (void)pause;
- (void)resume;
- (void)reset;

@end