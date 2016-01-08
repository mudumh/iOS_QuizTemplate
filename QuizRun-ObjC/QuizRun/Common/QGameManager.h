//
//  QGameManager.h
//  QuizRun
//
    
//     
//

#import <Foundation/Foundation.h>

@class QQuestion;

#define totalQuestionsToAsk 5
#define correctAnswerWeight 10

@interface QGameManager : NSObject

@property NSInteger numberOfTotalQuestionsAsked;
@property NSInteger correctAnsweredQuestions;
@property NSInteger score;
@property NSMutableArray *alreadyAskedQuestionsIds;
@property NSInteger numberOfTimesAppClosed;

+ (QGameManager*)sharedManager;
- (void)initGame;
- (QQuestion *)nextQuestion;
- (void)answeredCorrectly:(BOOL)correct andTime:(NSInteger)time;
- (void)closedApp;
- (QQuestion *)questionWithId:(NSString *)qustId;

@end
