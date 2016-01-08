//
//  AppDelegate.m
//  QuizRun

#import "AppDelegate.h"
#import "ThemeManager.h"
#import "Appirater.h"
#import "ConfigurationManager.h"
#import "Flurry.h"

static NSInteger secondsInHour = 60;

typedef enum {
    RateAppDeclined = 0,
    RateAppConfirmed
}RateApp;


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Remove comments to add Flurry Analytics more information here - www.flurry.com
    // NSString *flurrySessionID = [[ConfigurationManager sharedManager] flurrySessionID];
    //[Flurry startSession:@"PY8QGYRKC9HTBH8MX2SJ"];
    
    [self initAppiRater];
    [self initRateAppTimer];
    
    [ThemeManager applyNavigationBarTheme];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
	
    return YES;
}


#pragma mark - Pubic methods

+ (AppDelegate *)sharedDelegate {
    return (AppDelegate *)([UIApplication sharedApplication]).delegate;
}

- (void)showLogin {
    NSLog(@"Show login");
}

- (void)hideLogin {
    NSLog(@"Show login");
}

- (void)logOut {
    NSLog(@"Log Out");
}

#pragma mark - Private methods

- (void)initAppiRater {
    [Appirater appLaunched:YES];
    [Appirater setAppId:[[ConfigurationManager sharedManager] appId]];
    [Appirater setOpenInAppStore:YES];
}

- (void)initRateAppTimer {
    NSNumber *didShowAppRate = [[NSUserDefaults standardUserDefaults] valueForKey:@"showedAppRate"];
    if (!didShowAppRate.boolValue) {
        NSInteger showRateDelay = [[[ConfigurationManager sharedManager] rateAppDelay] integerValue] * secondsInHour;
        [NSTimer scheduledTimerWithTimeInterval:showRateDelay target:self
                                       selector:@selector(showAppRate)
                                       userInfo:nil repeats:NO];
    }
}

- (void)showAppRate {
    NSNumber *didShowAppRate = [[NSUserDefaults standardUserDefaults] valueForKey:@"showedAppRate"];
    if (![didShowAppRate boolValue]) {
        [self rateApp];
        [[NSUserDefaults standardUserDefaults] setValue:@YES forKey:@"showedAppRate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)rateApp {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Rate the App" message:@"Do you like app?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"No",@"Yes",nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Rate the App"]) {
        switch (buttonIndex) {
            case RateAppDeclined: {
                break;
            }
            case RateAppConfirmed:
                [Appirater rateApp];
                break;
            default:
                break;
        }
    }
}

@end