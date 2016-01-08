//
//  TodayViewController.m
//  QuizRunWidget
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "QQuestion.h"
#import "QGameManager.h"
#import "ColorCustomizer.h"

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic,strong) QQuestion *currentQuestion;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[QGameManager sharedManager] initGame];
    [self nextQuestion];
}

- (void)nextQuestion {
    self.currentQuestion = [[QGameManager sharedManager] nextQuestion];
    [self.questionLabel setNumberOfLines:0];
    self.questionLabel.text = self.currentQuestion.question;
    [self.questionLabel sizeThatFits:CGSizeMake(self.questionLabel.frame.size.width, self.questionLabel.frame.size.height)];
    
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
    
    self.answer1Btn.backgroundColor = [UIColor clearColor];
    self.answer2Btn.backgroundColor = [UIColor clearColor];
    self.answer3Btn.backgroundColor = [UIColor clearColor];
    self.answer4Btn.backgroundColor = [UIColor clearColor];
}

#pragma mark - User Actions

- (IBAction)onAnswer1:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

- (IBAction)onAnswer2:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

- (IBAction)onAnswer3:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

- (IBAction)onAnswer4:(id)sender {
    NSString *answer = [[(UIButton *)sender titleLabel] text];
    
    BOOL isCorrect = [self.currentQuestion.correctAnswer isEqualToString:answer];
    
    if (isCorrect) {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    } else {
        [(UIButton *)sender setBackgroundColor:[ColorCustomizer wrongAnswerColor]];
        [self showCorrectAnswer];
    }
    
    [self answeredCorrectly:isCorrect];
}

#pragma mark - Private methods

- (void)showCorrectAnswer {
    if ([self.answer1Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
        [ self.answer1Btn setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    }
    if ([self.answer2Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
        [ self.answer2Btn setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    }
    if ([self.answer3Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
        [ self.answer3Btn setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    }
    if ([self.answer4Btn.titleLabel.text isEqualToString:self.currentQuestion.correctAnswer]) {
        [ self.answer4Btn setBackgroundColor:[ColorCustomizer correctAnswerColor]];
    }
}

- (void)answeredCorrectly:(BOOL)correct {
    self.answer1Btn.userInteractionEnabled = NO;
    self.answer2Btn.userInteractionEnabled = NO;
    self.answer3Btn.userInteractionEnabled = NO;
    self.answer4Btn.userInteractionEnabled = NO;
    
    [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:1.0f];
}

#pragma mark - NCWidgetProviding

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    defaultMarginInsets.right = defaultMarginInsets.left;
    [self.view needsUpdateConstraints];
    return defaultMarginInsets;
}

@end
