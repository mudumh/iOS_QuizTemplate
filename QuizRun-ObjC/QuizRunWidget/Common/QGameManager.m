//
//  QGameManager.m
//  QuizRun
//
    
//     
//

#import "QGameManager.h"
#import "QQuestion.h"
#import "QQuizReader.h"

@implementation QGameManager

static QGameManager *_sharedHelper = nil;

+ (QGameManager*)sharedManager {
    
    // dispatch_once will ensure that the method is only called once (thread-safe)
    
    static dispatch_once_t pred = 0;
    
    dispatch_once(&pred, ^{
        
        _sharedHelper = [[QGameManager alloc] init];
        
    });
    
    return _sharedHelper;
    
}

#pragma mark - Public methods

- (void)initGame {
    self.numberOfTotalQuestionsAsked = 0;
    self.correctAnsweredQuestions = 0;
    self.score = 0;
    self.alreadyAskedQuestionsIds = [NSMutableArray array];
    self.numberOfTimesAppClosed = 0;
}

- (QQuestion *)nextQuestion {
    QQuizReader * reader = [QQuizReader sharedReader];
    NSInteger numberOfQuestions = [[reader questions] count];
    int randI = arc4random() % numberOfQuestions;
    
    QQuestion *nextQuestion = reader.questions[randI];
    
//    for (NSString *questionId in self.alreadyAskedQuestionsIds) {
//        if ([questionId isEqualToString:nextQuestion.questionId]) {
//            return [self nextQuestion];
//        }
//    }
    
//    [self.alreadyAskedQuestionsIds addObject:nextQuestion.questionId];
    self.numberOfTotalQuestionsAsked ++;
    return nextQuestion;
}

- (QQuestion *)questionWithId:(NSString *)qustId {
    QQuizReader * reader = [QQuizReader sharedReader];
    
    for (QQuestion *q in reader.questions) {
        if ([q.questionId isEqualToString:qustId]) {
            return q;
        }
    }
    
    return nil;
}

- (void)answeredCorrectly:(BOOL)correct andTime:(NSInteger)time {
    if (correct) {
        self.correctAnsweredQuestions++;
        int timeLeft = time - kAnswerInterval;

        self.score += abs(timeLeft) * correctAnswerWeight;
    } else {
        
    }
}

- (void)closedApp {
    self.numberOfTimesAppClosed++;
}

@end
