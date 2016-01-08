//
//  QuestionsManager.m
//  QuizRun
//
//       3/18/15.
//     
//

#import "QuestionsManager.h"
#import "QQuestion.h"

@implementation QuestionsManager

#pragma mark - Singleton method

+ (QuestionsManager *)sharedManager {
    static dispatch_once_t predicate = 0;
    static QuestionsManager *sharedObject;
    
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

#pragma mark - Public methods

- (NSArray *)loadData {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    NSDictionary *dataDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return [self constructDataFromDict:dataDictionary];
}

#pragma mark - Private methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSArray *values = [dict allValues];
    
    for (int i = 0; i< values.count; i++) {
        NSDictionary *obj = values[i];
        QQuestion *loadedData = [[QQuestion alloc] init];
        loadedData.question = obj[@"Question"];
        loadedData.questionId = [NSString stringWithFormat:@"%u",i];
        loadedData.correctAnswer = obj[@"CorrectAnswer"];
        
        loadedData.answers = [NSMutableArray array];
        [loadedData.answers addObject:obj[@"CorrectAnswer"]];
        [loadedData.answers addObject:obj[@"WrongAnswer1"]];
        [loadedData.answers addObject:obj[@"WrongAnswer2"]];
        [loadedData.answers addObject:obj[@"WrongAnswer3"]];
        
        [resultArray addObject:loadedData];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

@end
