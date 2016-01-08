//
//  QQuizViewController.m
//  QuizRun
//
 
//

#import "QQuizViewController.h"
#import "QGameManager.h"
#import "QProgressView.h"
#import "GCHelper.h"
#import <GameKit/GameKit.h>
#import <AVFoundation/AVFoundation.h>
#import "QScoreViewController.h"
#import "AppDelegate.h"
#import "QQuestion.h"
#import "QCustomizer.h"
#import "QuestionsManager.h"

@interface QQuizViewController ()

@property (nonatomic,strong) QProgressView *progressCircle;
@property float progress;
@property (nonatomic,strong) QQuestion *currentQuestion;
@property CGFloat timeSpentForAnswer;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) AVAudioPlayer *player;
@property BOOL isSoundOn;
@property BOOL shouldAdjust;

@end

@implementation QQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    //QQuestion *q = [[QGameManager sharedManager] nextQuestion];

    CGPoint progressPosition = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/3);
    self.progressCircle = [[QProgressView alloc] init];
    [self.progressCircle addToView:self.view andPosition:progressPosition andRadius:self.view.frame.size.height/7];
    
    self.progressCircle.autoresizingMask = NSLayoutAttributeBaseline | NSLayoutAttributeTop;
    
    self.progressCircle.translatesAutoresizingMaskIntoConstraints = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeGame:) name:@"shouldResumeGame" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseGame:) name:@"shouldPauseGame" object:nil];

    [self setNeedsStatusBarAppearanceUpdate];
    [self initGame];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    [self.questionNumberBtn setTitle:[NSString stringWithFormat:@"QUESTION 1/%i",totalQuestionsToAsk] forState:UIControlStateNormal];
    
    NSNumber *isSoundOnN = [[NSUserDefaults standardUserDefaults] valueForKey:@"sound"];
    
    if (isSoundOnN == nil) {
        self.isSoundOn = YES;
    } else {
        self.isSoundOn = isSoundOnN.boolValue;
    }
    
    //self.navigationController.viewControllers = @[[self.navigationController.viewControllers lastObject]];
}

- (void)viewWillAppear:(BOOL)animated {
    /*self.navigationController.viewControllers = @[[self.navigationController.viewControllers lastObject]];*/
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Notifications

- (void)resumeGame:(NSNotification *)notification {
    [self.progressCircle resume];

    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:self.timer forMode: NSDefaultRunLoopMode];
}

- (void)pauseGame:(NSNotification *)notification {
    [self.progressCircle pause];
    [self.timer invalidate];
}

- (void)tick:(NSUserDefaults *)info {
    self.timeSpentForAnswer++;
    CGFloat timeToAnswer = kAnswerInterval;
    int timeToDisplay = timeToAnswer - self.timeSpentForAnswer;
    self.progressCircle.timeLabel.text = [NSString stringWithFormat:@"%d",timeToDisplay];
    CGFloat timeToPlayHeartBeat = kTimeToPlayHeartBeat;
    
    if (timeToDisplay == timeToPlayHeartBeat) {
        if (self.isSoundOn) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"heartbeat" ofType:@"wav"];
            NSURL * url = [NSURL fileURLWithPath:path];
            NSError *error1;
            NSError *error2;
            NSData *songFile = [[NSData alloc] initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error1 ];
            
            self.player = [[AVAudioPlayer alloc] initWithData:songFile error:&error2];
            [self.player setVolume:1.0];
            [self.player play];
        }
        
    }
    
    if (self.timeSpentForAnswer == timeToAnswer) {
        if ([QGameManager sharedManager].numberOfTotalQuestionsAsked == totalQuestionsToAsk) {
            [self performSegueWithIdentifier:@"showScore" sender:nil];
        } else {
            [self nextQuestion];
        }
    }
}

#pragma mark - Game Logic

- (void)initGame {
    [[QGameManager sharedManager] initGame];
    [self nextQuestion];
}

- (void)nextQuestion {
    self.currentQuestion = [[QGameManager sharedManager] nextQuestion];
    [self.questionLabel setNumberOfLines:0];
    self.questionLabel.text = self.currentQuestion.question;
    [self.questionLabel sizeThatFits:CGSizeMake(self.questionLabel.frame.size.width, self.questionLabel.frame.size.height)];
    self.timeSpentForAnswer = 0;
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:self.timer forMode: NSDefaultRunLoopMode];
    
    [self.progressCircle resume];
    [self.progressCircle reset];
    
   // NSInteger askedQuestions = [[QGameManager sharedManager] numberOfTotalQuestionsAsked];
    
   // self.title = [NSString stringWithFormat:@"Question %ld/%d",(long)askedQuestions,totalQuestionsToAsk];
    
    NSMutableArray *answers = [NSMutableArray arrayWithArray:self.currentQuestion.answers];
    
    NSString *answer = answers[arc4random()%answers.count];
    [self.answer1Btn setTitle:answer forState:UIControlStateNormal];
    [answers removeObject:answer];
    
    answer = answers[arc4random()%answers.count];
    [self.answer2Btn setTitle:answer forState:UIControlStateNormal];
    [answers removeObject:answer];
    
    answer = answers[arc4random()%answers.count];
    [self.answer3Btn setTitle:answer forState:UIControlStateNormal];
    [answers removeObject:answer];
    
    answer = answers[arc4random()%answers.count];
    [self.answer4Btn setTitle:answer forState:UIControlStateNormal];
    [answers removeObject:answer];
    
    self.answer1Btn.userInteractionEnabled = YES;
    self.answer2Btn.userInteractionEnabled = YES;
    self.answer3Btn.userInteractionEnabled = YES;
    self.answer4Btn.userInteractionEnabled = YES;

    self.answer1Btn.backgroundColor = [QCustomizer buttonColor];
    self.answer2Btn.backgroundColor = [UIColor clearColor];
    self.answer3Btn.backgroundColor = [QCustomizer buttonColor];
    self.answer4Btn.backgroundColor = [UIColor clearColor];
    
    CGFloat timeToAnswer = kAnswerInterval;
    int timeToDisplay = timeToAnswer - self.timeSpentForAnswer;
    self.progressCircle.timeLabel.text = [NSString stringWithFormat:@"%d",timeToDisplay];
    
    [self.questionNumberBtn setTitle:[NSString stringWithFormat:@"QUESTION %li/%i",(long)[QGameManager sharedManager].numberOfTotalQuestionsAsked ,totalQuestionsToAsk] forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)onAnswer1:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[QCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[QCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

- (IBAction)onAnswer2:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[QCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[QCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

- (IBAction)onAnswer3:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[QCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[QCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

- (IBAction)onAnswer4:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[QCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[QCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

- (IBAction)onMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showCorrectAnswer {
    if ([self.answer1Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
       [ self.answer1Btn setBackgroundColor:[QCustomizer correctAnswerColor]];
    }
    if ([self.answer2Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
        [ self.answer2Btn setBackgroundColor:[QCustomizer correctAnswerColor]];
    }
    if ([self.answer3Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
        [ self.answer3Btn setBackgroundColor:[QCustomizer correctAnswerColor]];
    }
    if ([self.answer4Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
        [ self.answer4Btn setBackgroundColor:[QCustomizer correctAnswerColor]];
    }
}

#pragma mark - Private methods

- (void)answeredCorrectly:(BOOL)correct {
    self.answer1Btn.userInteractionEnabled = NO;
    self.answer2Btn.userInteractionEnabled = NO;
    self.answer3Btn.userInteractionEnabled = NO;
    self.answer4Btn.userInteractionEnabled = NO;
    
    if (self.isSoundOn) {
        NSString *path;
        
        if (correct) {
            path =[[NSBundle mainBundle] pathForResource:@"right_answer" ofType:@"wav"];
        } else {
            path =[[NSBundle mainBundle] pathForResource:@"wrong_answer" ofType:@"wav"];
        }
        
        NSURL * url = [NSURL fileURLWithPath:path];
        
        NSError *error1;
        NSError *error2;
        NSData *songFile = [[NSData alloc] initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error1 ];
        
        self.player = [[AVAudioPlayer alloc] initWithData:songFile error:&error2];
        [self.player setVolume:1.0];
        [self.player play];
    }
    
    QGameManager *gameManager = [QGameManager sharedManager];
    [gameManager answeredCorrectly:correct andTime:self.timeSpentForAnswer];
    
    if (gameManager.numberOfTotalQuestionsAsked == totalQuestionsToAsk) {
        [self performSegueWithIdentifier:@"showScore" sender:nil];
    } else {
        [self.progressCircle pause];
        [self.timer invalidate];
        [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:2.0f];
    }
}

@end