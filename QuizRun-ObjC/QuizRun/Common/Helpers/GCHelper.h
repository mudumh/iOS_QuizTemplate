//
//  GCHelper.h
//  QuizRun
//


#import <Foundation/Foundation.h>

@import Foundation;
@import GameKit;

@interface GCHelper : NSObject <GKGameCenterControllerDelegate> {
    
    BOOL gameCenterAvailable;
    
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCHelper*)defaultHelper;
- (BOOL)isGameCenterAvailable;
- (void)showLeaderboardOnViewController:(UIViewController*)viewController;
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController;
- (void)authenticateLocalUserOnViewController:(UIViewController*)viewController
                            setCallbackObject:(id)obj
                            withPauseSelector:(SEL)selector;
- (void)reportScore:(int64_t)score forLeaderboardID:(NSString*)identifier;

@end
