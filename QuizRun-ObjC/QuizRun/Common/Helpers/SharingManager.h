//
//  SharingManager.h
//  QuizRun
//
//       2/19/15.
//     
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface SharingManager : NSObject <MFMailComposeViewControllerDelegate>

+ (void)shareViaFacebookWithController:(UIViewController *)contoller;
+ (void)shareViaTwitterWithController:(UIViewController *)contoller;
+ (void)contactUsWithController:(UIViewController *)contoller;

+ (SharingManager *)sharedManager;
- (void)inviteByMailFromViewController:(UIViewController *)controller withSubject:(NSString *)subject;

@end
