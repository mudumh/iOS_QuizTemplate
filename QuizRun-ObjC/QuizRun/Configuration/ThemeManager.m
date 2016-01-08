//
//  ThemeManager.m
//  QuizRun
//


#import "ThemeManager.h"
#import <UIKit/UIKit.h>

@implementation ThemeManager

+ (void)applyNavigationBarTheme {
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
}

@end