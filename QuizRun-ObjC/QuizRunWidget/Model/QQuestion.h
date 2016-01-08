//
//  QQuestion.h
//  QuizRun
//

//

#import <Foundation/Foundation.h>

#define kAnswerInterval 20.0f;
#define kTimeToPlayHeartBeat 5.0f;

@interface QQuestion : NSObject <NSCoding>

@property (nonatomic,copy) NSString *questionId;
@property (nonatomic,copy) NSString *question;
@property (nonatomic,strong) NSMutableArray *answers;
@property (nonatomic,copy) NSString *correctAnswer;

- (id)init;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end