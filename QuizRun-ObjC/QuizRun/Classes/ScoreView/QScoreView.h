//
//  QScoreView.h
//  QuizRun
//
//       3/25/14.
//     
//

#import <UIKit/UIKit.h>

@interface QScoreView : UIView

@property (nonatomic,assign) IBOutlet UILabel *questionLabel;
@property (nonatomic,assign) IBOutlet UIButton *answBtn1;
@property (nonatomic,assign) IBOutlet UIButton *answBtn2;
@property (nonatomic,assign) IBOutlet UIButton *answBtn3;
@property (nonatomic,assign) IBOutlet UIButton *answBtn4;

+ (QScoreView *)loadView;
- (UIImage *)snapshot;

@end
