//
//  QMainMenuViewController.m
//  QuizRun
//

//

#import "MainMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GCHelper.h"
#import "QCustomizer.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLeaderBoard:) name:@"showLeaderboard" object:nil];
    
    //[[GCHelper defaultHelper] authenticateLocalUserOnViewController:self setCallbackObject:nil withPauseSelector:nil];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.viewControllers = @[[self.navigationController.viewControllers lastObject]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.viewControllers = @[[self.navigationController.viewControllers lastObject]];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)authenticationRequired {
    //if the game is open, it should be paused
    [[GCHelper defaultHelper] showLeaderboardOnViewController:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Notifications

- (void)continueGame:(NSNotification *)notification {
    self.playButton.userInteractionEnabled = YES;
    self.settingsButton.userInteractionEnabled = YES;
    [[GCHelper defaultHelper] showLeaderboardOnViewController:self];
}

#pragma mark - Actions

- (IBAction)onLeaderBoard:(id)sender {
    if ([[self.navigationController.viewControllers.lastObject class] isSubclassOfClass:[self class]]) {
        [[GCHelper defaultHelper] showLeaderboardOnViewController:self];
    }
}

@end