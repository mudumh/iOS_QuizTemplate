//
//  QQuizReader.m
//  QuizRun
//
 
//

#import "QQuizReader.h"
#import "QuestionsManager.h"

#define kQuestionsKey @"Questions"

@implementation QQuizReader

#pragma mark - Singleton implementation

static QQuizReader *sharedReader = nil;

+ (QQuizReader *)sharedReader {
    static dispatch_once_t _singletonPredicate;
    
    dispatch_once(&_singletonPredicate, ^{
        sharedReader = [[QQuizReader alloc] init];
        [sharedReader loadQuestions];
    });
    
    return sharedReader;
}

#pragma - Public methods

- (void)loadQuestions {
    if (self.questions == nil) {
        self.questions = [NSMutableArray arrayWithArray:[[QuestionsManager sharedManager] loadData]];
    }
}

@end