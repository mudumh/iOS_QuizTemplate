//
//  CategoriesManager.m
//  QuizRun
//
//       3/4/15.
//     
//

#import "QuizCategoriesManager.h"
#import "QuizCategory.h"


@implementation QuizCategoriesManager

#pragma mark - Singleton method

+ (QuizCategoriesManager *)sharedManager {
    static dispatch_once_t predicate = 0;
    static QuizCategoriesManager *sharedObject;
    
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

#pragma mark - Public methods

- (NSArray *)loadData {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];
    NSDictionary *dataDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return [self constructDataFromDict:dataDictionary];
}

#pragma mark - Private methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *obj in [dict allValues]) {
        QuizCategory *loadedData = [[QuizCategory alloc] init];
        loadedData.title = obj[@"Title"];
        loadedData.imageURL = obj[@"Image"];
        [resultArray addObject:loadedData];
    }
    
    return [NSArray arrayWithArray:resultArray];
}


@end
