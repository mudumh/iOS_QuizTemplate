//
//  QQuestion.m
//  QuizRun
//

//

#import "QQuestion.h"

#define kQuestionID @"questionId"
#define kQuestion @"question"
#define kAnswers @"answers"
#define kCorrectAnswer @"correctanswer"

@implementation QQuestion

- (id)init {
    self = [super init];
    
    if (self != nil) {
        self.answers = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.questionId forKey:kQuestionID];
    [aCoder encodeObject:self.question forKey:kQuestion];
    [aCoder encodeObject:self.answers forKey:kAnswers];
    [aCoder encodeObject:self.correctAnswer forKey:kCorrectAnswer];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self != nil) {
        self.questionId = [coder decodeObjectForKey:kQuestionID];
        self.question = [coder decodeObjectForKey:kQuestion];
        self.answers = [coder decodeObjectForKey:kAnswers];
        self.correctAnswer = [coder decodeObjectForKey:kCorrectAnswer];
    }
    return self;
}


@end
