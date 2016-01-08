//
//  QScoreViewController.m
//  QuizRun
//
//    
//     
//

#import "QScoreViewController.h"
#import "QGameManager.h"
#import "GCHelper.h"
#import "AppDelegate.h"
#import "QScoreView.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "ConfigurationManager.h"
#import "QCustomizer.h"
#import "QQuestion.h"

#define NumberOfTimesAppWasQuited 2
#define Share_Text @"Do you know correct answer? #dexter"
#define ItunnesLink @"https://itunes.apple.com/us/app/dexter-fan-trivia/id849746008?ls=1&mt=8"
#define MoreApps @"itms-apps://itunes.apple.com/us/artist/ihor-kozachuk/id702817618"

@interface QScoreViewController () <UIActionSheetDelegate,MFMailComposeViewControllerDelegate>

@property BOOL canShowLeaderBoard;
@property (nonatomic,strong) NSMutableArray *scoresViewsArray;
@property (nonatomic,strong) UIImage *imageToPost;

@end

@implementation QScoreViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    QGameManager *gameManager = [QGameManager sharedManager];
    
    if (gameManager.numberOfTimesAppClosed >= NumberOfTimesAppWasQuited) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You have left app during test. You did not cheat did you? Your score is divided by 2" delegate:nil cancelButtonTitle:@"Okay(" otherButtonTitles: nil];
        [alert show];
        gameManager.score = gameManager.score / 2;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)gameManager.score];
    self.rightAnswersLabel.text = [NSString stringWithFormat:@"%ld",(long)gameManager.correctAnsweredQuestions];
    self.wrongAnswersLabel.text = [NSString stringWithFormat:@"%ld",((long)gameManager.numberOfTotalQuestionsAsked - (long)gameManager.correctAnsweredQuestions)];

    [[GCHelper defaultHelper] reportScore:(long)gameManager.score forLeaderboardID:[[ConfigurationManager sharedManager] leaderBoardIdentifier]];
    
    NSNumber *bestScore = [[NSUserDefaults standardUserDefaults] valueForKey:@"bestScore"];
    if (bestScore != nil) {
        self.bestLabel.text = [NSString stringWithFormat:@"BEST RUN: %ld",(long)bestScore.integerValue];
    } else {
        if ((gameManager.score > bestScore.integerValue)&&(gameManager.score != 0)) {
            self.bestLabel.text = [NSString stringWithFormat:@"BEST RUN : %ld",(long)gameManager.score];
        } else {
            self.bestLabel.text = [NSString stringWithFormat:@"BEST RUN : %ld",(long)bestScore.integerValue];
        }
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initScoresScroll];
    
    NSNumber *bestScore = [[NSUserDefaults standardUserDefaults] valueForKey:@"bestScore"];
    
    if (bestScore != nil) {
        NSInteger score = [QGameManager sharedManager].score;
        if ((score > bestScore.integerValue)&&(score != 0)) {
            self.bestLabel.text = [NSString stringWithFormat:@"BEST RUN : %ld",(long)score];
        }
    } else {
        NSInteger score = [QGameManager sharedManager].score;
        if (score != 0) {

        }
        bestScore = [NSNumber numberWithInteger:score];
        
        [[NSUserDefaults standardUserDefaults] setValue:bestScore forKeyPath:@"bestScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)showLeaderBoard {
    [[GCHelper defaultHelper] showLeaderboardOnViewController:self];
}

- (void)initScoresScroll {
    self.scoresViewsArray = [NSMutableArray array];
    [self.scoresScroll setContentSize:CGSizeMake(self.scoresScroll.frame.size.width * totalQuestionsToAsk, 0)];
    
    CGRect rect = self.scoresScroll.bounds;
    
    rect.size.width = rect.size.width;
    
    for (int i = 0; i < totalQuestionsToAsk; i++) {
        QScoreView *view1 = [QScoreView loadView];
        view1.frame = rect;
        view1.backgroundColor = [UIColor clearColor];
        [self.scoresScroll addSubview:view1];
        rect.origin.x += rect.size.width;
        
        QQuestion *question = [[QGameManager sharedManager] questionWithId:[[[QGameManager sharedManager] alreadyAskedQuestionsIds] objectAtIndex:i]];
        [view1.questionLabel setNumberOfLines:0];
        view1.questionLabel.text = question.question;
        [view1.questionLabel sizeThatFits:CGSizeMake(view1.questionLabel.frame.size.width, view1.questionLabel.frame.size.height)];
        
        NSMutableArray *answers = [NSMutableArray arrayWithArray:question.answers];
        
        NSString *answer = answers[arc4random()%answers.count];
        [view1.answBtn1 setTitle:answer forState:UIControlStateNormal];
        if ([answer isEqualToString:question.correctAnswer]) {
            view1.answBtn1.backgroundColor = [QCustomizer correctAnswerColor];
        }
        [answers removeObject:answer];
        
        answer = answers[arc4random()%answers.count];
        [view1.answBtn2 setTitle:answer forState:UIControlStateNormal];
        if ([answer isEqualToString:question.correctAnswer]) {
            view1.answBtn2.backgroundColor = [QCustomizer correctAnswerColor];
        }
        [answers removeObject:answer];
        
        answer = answers[arc4random()%answers.count];
        [view1.answBtn3 setTitle:answer forState:UIControlStateNormal];
        if ([answer isEqualToString:question.correctAnswer]) {
            view1.answBtn3.backgroundColor = [QCustomizer correctAnswerColor];
        }
        [answers removeObject:answer];
        
        answer = answers[arc4random()%answers.count];
        [view1.answBtn4 setTitle:answer forState:UIControlStateNormal];
        if ([answer isEqualToString:question.correctAnswer]) {
            view1.answBtn4.backgroundColor = [QCustomizer correctAnswerColor];
        }
        [answers removeObject:answer];
        
        [self.scoresViewsArray addObject:view1];
    }
}

#pragma mark - Actions

- (IBAction)onLeaderBoard:(id)sender {
    if (([[self.navigationController.viewControllers.lastObject class] isSubclassOfClass:[self class]])) {
        self.canShowLeaderBoard = YES;
        [[GCHelper defaultHelper] showLeaderboardOnViewController:self];
    }
}

- (IBAction)onRestartGame:(id)sender {
    self.navigationController.viewControllers = @[[self.navigationController.viewControllers lastObject]];
    [self performSegueWithIdentifier:@"restart" sender:nil];
}

- (IBAction)onMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onShare:(id)sender {
    int i = self.scoresScroll.contentOffset.x / self.scoresScroll.frame.size.width;
    QScoreView *scoreView = [self.scoresViewsArray objectAtIndex:i];
    self.imageToPost = [scoreView snapshot];
    
    NSString *actionSheetTitle = @"Share";
    NSString *facebook = @"Facebook";
    NSString *twitter = @"Twitter";
    NSString *email = @"Email";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:facebook, twitter,email, nil];
    [actionSheet showInView:self.view];
}

- (IBAction)onRightRight:(id)sender {
    CGPoint point = self.scoresScroll.contentOffset;
    point.x += self.scoresScroll.frame.size.width;
    
    if (point.x <= self.scoresScroll.contentSize.width - self.scoresScroll.frame.size.width) {
        [self.scoresScroll setContentOffset:point animated:YES];
    }
}

- (IBAction)onLeftRight:(id)sender {
    CGPoint point = self.scoresScroll.contentOffset;
    point.x -= self.scoresScroll.frame.size.width;
    
    if (point.x >= 0) {
        [self.scoresScroll setContentOffset:point animated:YES];
    }
}

- (IBAction)onRightLeft:(id)sender {
    CGPoint point = self.scoresScroll.contentOffset;
    point.x += self.scoresScroll.frame.size.width;
    
    if (point.x <= self.scoresScroll.contentSize.width - self.scoresScroll.frame.size.width) {
        [self.scoresScroll setContentOffset:point animated:YES];
    }
}

- (IBAction)onLeftLeft:(id)sender {
    CGPoint point = self.scoresScroll.contentOffset;
    point.x -= self.scoresScroll.frame.size.width;
    
    if (point.x >= 0) {
        [self.scoresScroll setContentOffset:point animated:YES];
    }
}

#pragma mark - UiactionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    switch (buttonIndex) {
        case RActionSheetFacebook:
            
            break;
        case RActionSheetTwitter:
            
            break;
        case RActionSheetEmail:
            
            break;
        case RActionSheetCancel:
            break;
        default:
            break;
    }
}

#pragma mark - MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
