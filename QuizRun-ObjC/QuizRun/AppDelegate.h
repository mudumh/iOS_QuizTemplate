//
//  AppDelegate.h
//  QuizRun
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedDelegate;
- (void)showLogin;
- (void)hideLogin;

//Actions
- (void)logOut;

@end