//
//  QQuizReader.h
//  QuizRun
//

//

#import <UIKit/UIKit.h>

@class QQuestion;

@interface QQuizReader : UICollectionViewCell

@property (nonatomic,strong) NSMutableArray *questions;

+ (QQuizReader *)sharedReader;
- (void)loadQuestions;

@end