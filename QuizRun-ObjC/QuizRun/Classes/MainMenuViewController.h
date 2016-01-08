//
//  QMainMenuViewController.h
//  QuizRun
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface MainMenuViewController : UIViewController

@property (nonatomic,assign) IBOutlet UIButton *playButton;
@property (nonatomic,assign) IBOutlet UIButton *settingsButton;
@property (nonatomic,assign) IBOutlet UIButton *soundBtn;

- (IBAction)onLeaderBoard:(id)sender;

@end