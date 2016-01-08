//
//  QCustomizer.m
//  QuizRun
//
//    
//     
//

#import "QCustomizer.h"

@implementation QCustomizer

+ (UIColor *)buttonColor {
    return [UIColor colorWithRed:36.0f/255.0f green:46.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
}

+ (UIColor *)circleCenterColor {
    return [UIColor colorWithRed:29.0f/255.0f green:98.0f/255.0f blue:74.0f/255.0f alpha:1.0f];
}

+ (UIColor *)progressColor {
    return [UIColor whiteColor];
}

+ (UIColor *)correctAnswerColor {
    return [UIColor colorWithRed:34.0f/255.0f green:141.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
}

+ (UIColor *)wrongAnswerColor {
    return [UIColor colorWithRed:208.0f/255.0f green:55.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
}

@end