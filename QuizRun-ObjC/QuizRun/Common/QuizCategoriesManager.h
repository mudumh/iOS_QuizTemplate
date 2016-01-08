//
//  CategoriesManager.h
//  QuizRun
//
//       3/4/15.
//     
//

#import <Foundation/Foundation.h>

@interface QuizCategoriesManager : NSObject

+ (QuizCategoriesManager *)sharedManager;
- (NSArray *)loadData;

@end