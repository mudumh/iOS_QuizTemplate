//
//  SharingManager.m
//  QuizRun
//
//       2/19/15.
//     
//

#import "SharingManager.h"
#import "ConfigurationManager.h"

@implementation SharingManager

+ (void)shareViaFacebookWithController:(UIViewController *)contoller {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [mySLComposerSheet setInitialText:@"Posted from iOS app template"];
        [mySLComposerSheet addURL:[NSURL URLWithString:@""]];
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [contoller presentViewController:mySLComposerSheet animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please log in to your Facebook account" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}

+ (void)shareViaTwitterWithController:(UIViewController *)contoller {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [mySLComposerSheet setInitialText:@"Posted from iOS app template"];
        [mySLComposerSheet addURL:[NSURL URLWithString:@""]];
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [contoller presentViewController:mySLComposerSheet animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please log in to your Facebook account" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}

+ (void)contactUsWithController:(UIViewController<UINavigationControllerDelegate> *)contoller {
    ConfigurationManager *manager = [ConfigurationManager sharedManager];
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        [mailComposer setToRecipients:[NSArray arrayWithObject:manager.contactMail]];
        mailComposer.delegate = contoller;
        [contoller presentViewController:mailComposer animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can't send mail on this device" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - Singleton method

+ (SharingManager *)sharedManager {
    static dispatch_once_t predicate = 0;
    static SharingManager *sharedObject;
    
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

#pragma mark - Public methods

- (void)inviteByMailFromViewController:(UIViewController *)controller withSubject:(NSString *)subject; {
    ConfigurationManager *manager = [ConfigurationManager sharedManager];
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    
    //set delegate
    if([controller conformsToProtocol:@protocol(MFMailComposeViewControllerDelegate)]) {
        mailComposer.mailComposeDelegate = (id<MFMailComposeViewControllerDelegate>)controller;
    } else {
        mailComposer.mailComposeDelegate = self;
    }
    
    if ([MFMailComposeViewController canSendMail]) {
        [mailComposer setToRecipients:[NSArray arrayWithObject:manager.contactMail]];
        [mailComposer setSubject:subject];
        [controller presentViewController:mailComposer animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed");
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end
