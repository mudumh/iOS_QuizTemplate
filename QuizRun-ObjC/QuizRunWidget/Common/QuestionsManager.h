//
//  QuestionsManager.h
//  QuizRun
//
//       3/18/15.
//     
//

#import <Foundation/Foundation.h>

@interface QuestionsManager : NSObject

+ (QuestionsManager *)sharedManager;
- (NSArray *)loadData;

@end