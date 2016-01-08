//
//  QQuizViewController.h
//  QuizRun
//
 
//

#import <UIKit/UIKit.h>

@interface QQuizViewController : UIViewController

@property (nonatomic,assign) IBOutlet UIButton *questionNumberBtn;
@property (nonatomic,assign) IBOutlet UILabel *questionLabel;
@property (nonatomic,assign) IBOutlet UIButton *answer1Btn;
@property (nonatomic,assign) IBOutlet UIButton *answer2Btn;
@property (nonatomic,assign) IBOutlet UIButton *answer3Btn;
@property (nonatomic,assign) IBOutlet UIButton *answer4Btn;

- (IBAction)onAnswer1:(id)sender;
- (IBAction)onAnswer2:(id)sender;
- (IBAction)onAnswer3:(id)sender;
- (IBAction)onAnswer4:(id)sender;
- (IBAction)onMenu:(id)sender;

@end