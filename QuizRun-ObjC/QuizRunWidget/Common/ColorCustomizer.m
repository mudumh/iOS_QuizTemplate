//
//  ColorCustomizer.m
//  QuizRun
//


#import "ColorCustomizer.h"

@implementation ColorCustomizer

+ (UIColor *)correctAnswerColor {
    return [UIColor colorWithRed:45.0f/255.0f green:158.0f/255.0f blue:43.0f/255.0f alpha:1.0f];
}

+ (UIColor *)wrongAnswerColor {
    return [UIColor colorWithRed:217.0f/255.0f green:71.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
}

@end