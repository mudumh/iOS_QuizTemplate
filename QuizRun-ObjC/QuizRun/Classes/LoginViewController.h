//
//  LoginViewController.h
//  QuizRun
//


#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtFld;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainScrollViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)onSignInBtnClicked:(id)sender;
- (IBAction)onSignInWithFacebookClicked:(id)sender;
- (IBAction)onSignInWithTwitterClicked:(id)sender;
- (IBAction)onForgotPasswordBtnClicked:(id)sender;
- (IBAction)onSignUpBtnClicked:(id)sender;

@end
