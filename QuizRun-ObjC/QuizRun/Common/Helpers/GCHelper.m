//
//  GCHelper.m
//  QuizRun
//


#import "GCHelper.h"
#import "AppDelegate.h"
#import "ConfigurationManager.h"

@implementation GCHelper

@synthesize gameCenterAvailable;

static GCHelper *_sharedHelper = nil;

+ (GCHelper*)defaultHelper {
    
    // dispatch_once will ensure that the method is only called once (thread-safe)
    
    static dispatch_once_t pred = 0;
    
    dispatch_once(&pred, ^{
        
        _sharedHelper = [[GCHelper alloc] init];
        
    });
    
    return _sharedHelper;
    
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    // check if the device is running iOS 4.1 or later
    
    NSString *reqSysVer = @"4.1";
    
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                
                                           options:NSNumericSearch] != NSOrderedAscending);
    return (gcClass && osVersionSupported);
    
}

- (id)init {
    if ((self = [super init])) {
        
        gameCenterAvailable = [self isGameCenterAvailable];
        
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
    }
    return self;
}

- (void)authenticateLocalUserOnViewController:(UIViewController*)viewController
                            setCallbackObject:(id)obj
                            withPauseSelector:(SEL)selector {
    if (!gameCenterAvailable) return;

    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    NSLog(@"Authenticating local user...");
    
    if (localPlayer.authenticated == NO) {
        [localPlayer setAuthenticateHandler:^(UIViewController* authViewController, NSError *error) {
            if (authViewController != nil) {
                if (obj) {
                    
                    [obj performSelector:selector withObject:nil afterDelay:0];
                    
                }
                [viewController presentViewController:authViewController animated:YES completion:^ {
                    //[[NSNotificationCenter defaultCenter] postNotificationName:@"continueGame" object:nil];
                }];
            } else if (error != nil) {
                // process error
            }
        }];
    } else {
        NSLog(@"Already authenticated!");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"continueGame" object:nil];
    }
}

- (void)authenticationChanged {
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        
        userAuthenticated = TRUE;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showLeaderboard" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"submitScore" object:nil];
        // Load the leaderboard info
        
        // Load the achievements
        
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated.");
        userAuthenticated = FALSE;
    }
}

- (void)showLeaderboardOnViewController:(UIViewController*)viewController {
    if (!gameCenterAvailable) {
        return;
    }
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    NSLog(@"Authenticating local user...");
    
    if (localPlayer.authenticated == NO) {
        NSLog(@"localPlayer.authenticated == NO");
        [localPlayer setAuthenticateHandler:^(UIViewController* authViewController, NSError *error) {
            if (authViewController != nil) {
                [viewController presentViewController:authViewController animated:YES completion:^ {
                    NSLog(@"LOLOLO");
                }];
            } else if (error != nil) {
                NSLog(@"errrrooooor");
            }
        }];
    } else {
        NSLog(@"localPlayer.authenticated == YES");
        NSLog(@"Already authenticated!");
        
        GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
        if (gameCenterController != nil) {
            gameCenterController.gameCenterDelegate = self;
            gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
            gameCenterController.leaderboardIdentifier = [[ConfigurationManager sharedManager] leaderBoardIdentifier];
            
            [viewController presentViewController: gameCenterController animated: YES completion:nil];
        }
    }
    /*GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil) {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardIdentifier = [[ConfigurationManager sharedManager] leaderBoardIdentifier];
        
        [viewController presentViewController: gameCenterController animated: YES completion:nil];
    } else {
        [self authenticateLocalUserOnViewController:viewController setCallbackObject:nil withPauseSelector:nil];
    }*/
}
- (void)showLeaderboardOnViewController1:(UIViewController *)viewController {
    
}

/*
- (void)showLeaderboardOnViewController:(UIViewController*)viewController {
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil) {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardIdentifier = _kLeaderBoardIdentifier;
        
        [viewController presentViewController: gameCenterController animated: YES completion:nil];
    }
}*/

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
- (void)reportScore:(int64_t)score forLeaderboardID:(NSString*)identifier andController:(UIViewController *)viewController{
    if (!gameCenterAvailable) return;
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    NSLog(@"Authenticating local user...");
    
    if (localPlayer.authenticated == NO) {
        [localPlayer setAuthenticateHandler:^(UIViewController* authViewController, NSError *error) {
            if (authViewController != nil) {
                [viewController presentViewController:authViewController animated:YES completion:^ {
                    NSLog(@"LOLOLO");
                    [self reportScore:score forLeaderboardID:_kLeaderBoardIdentifier];
                }];
            } else if (error != nil) {
                // process error
            }
        }];
    } else {
        NSLog(@"Already authenticated!");
        [self reportScore:score forLeaderboardID:_kLeaderBoardIdentifier];
    }
}*/

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString*)identifier {
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: [[ConfigurationManager sharedManager] leaderBoardIdentifier]];
    scoreReporter.value = score;
    scoreReporter.context = 0;
    
    [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Score reported successfully!");
        } else {
            NSLog(@"Unable to report score!");
        }
    }];
}

@end
