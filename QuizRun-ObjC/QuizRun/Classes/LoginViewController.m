//
//  LoginViewController.m
//  QuizRun
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (assign, nonatomic) BOOL isKeyboardShown;

- (void)keyboardWillChangeFrame:(NSNotification *)notification;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    //add observers for keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //placeholders texts
    NSAttributedString *emailPlaceholderText = [[NSAttributedString alloc] initWithString:@"E N T E R  N A M E" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    self.emailTxtFld.attributedPlaceholder = emailPlaceholderText;
    
    NSAttributedString *passwordPlaceholderText = [[NSAttributedString alloc] initWithString:@"E N T E R  P A S S W O R D" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    self.passwordTxtFld.attributedPlaceholder = passwordPlaceholderText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)onSignInBtnClicked:(id)sender {
    NSLog(@"Button \"Sign in\" was clicked");
    [self performSegueWithIdentifier:@"showMenu" sender:self];
}

- (IBAction)onSignInWithFacebookClicked:(id)sender {
    NSLog(@"Button \"Sign in with facebook\" was clicked");
    [self performSegueWithIdentifier:@"showMenu" sender:self];
}

- (IBAction)onSignInWithTwitterClicked:(id)sender {
    NSLog(@"Button \"Sign in with twitter\" was clicked");
    [self performSegueWithIdentifier:@"showMenu" sender:self];
}

- (IBAction)onForgotPasswordBtnClicked:(id)sender {
    NSLog(@"Button \"Forgot Password?\" was clicked");    
}

- (IBAction)onSignUpBtnClicked:(id)sender {
    NSLog(@"Button \"Sign up\" was clicked");
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.emailTxtFld) { //move to "password" text field
        [self.passwordTxtFld becomeFirstResponder];
    } else if(textField == self.passwordTxtFld) {
        self.isKeyboardShown = NO;
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.isKeyboardShown = YES;
    return YES;
}

#pragma mark - Observer methods

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect keyboardBounds = [notification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    self.mainScrollViewBottomConstraint.constant = self.isKeyboardShown ? keyboardBounds.size.height : 0;
    [self.view updateConstraints];
}

@end
