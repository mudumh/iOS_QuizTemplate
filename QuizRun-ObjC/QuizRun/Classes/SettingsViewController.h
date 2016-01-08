//
//  SettingsViewController.h
//  QuizRun
//
//       3/11/15.
//     
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (assign,nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) IBOutlet UIBarButtonItem *backButton;

- (IBAction)onBack:(id)sender;

@end