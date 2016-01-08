//
//  QScoreViewController.h
//  QuizRun
//
//    
//     
//

#import <UIKit/UIKit.h>

typedef enum {
    RActionSheetFacebook = 0,
    RActionSheetTwitter,
    RActionSheetEmail,
    RActionSheetCancel
}RActionSheet;

@interface QScoreViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic,assign) IBOutlet UILabel *scoreLabel;
@property (nonatomic,assign) IBOutlet UILabel *bestLabel;
@property (nonatomic,assign) IBOutlet UILabel *rightAnswersLabel;
@property (nonatomic,assign) IBOutlet UILabel *wrongAnswersLabel;
@property (nonatomic,assign) IBOutlet UIButton *leaderBoard;
@property (nonatomic,assign) IBOutlet UIButton *leaderBoard1;
@property (nonatomic,assign) IBOutlet UIButton *restart;
@property (nonatomic,assign) IBOutlet UIButton *restart1;
@property (nonatomic,assign) IBOutlet UIScrollView *scoresScroll;
@property NSInteger totalScore;

- (IBAction)onLeaderBoard:(id)sender;
- (IBAction)onRestartGame:(id)sender;
- (IBAction)onMenu:(id)sender;
- (IBAction)onShare:(id)sender;

- (IBAction)onRightRight:(id)sender;
- (IBAction)onLeftRight:(id)sender;

- (IBAction)onRightLeft:(id)sender;
- (IBAction)onLeftLeft:(id)sender;

@end
