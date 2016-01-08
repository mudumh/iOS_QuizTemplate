//
//  SettingsLogOutTableViewCell.h
//  QuizRun
//
//       3/11/15.
//     
//

#import <UIKit/UIKit.h>

@interface SettingsLogOutTableViewCell : UITableViewCell

@property (assign,nonatomic) IBOutlet UIView *backgroundColorView;
@property (assign,nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)onLogOut:(id)sender;

@end