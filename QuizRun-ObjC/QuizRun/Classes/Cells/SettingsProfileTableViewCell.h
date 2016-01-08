//
//  SettingsProfileTableViewCell.h
//  QuizRun
//
//       3/11/15.
//     
//

#import <UIKit/UIKit.h>

@interface SettingsProfileTableViewCell : UITableViewCell

@property (assign,nonatomic) IBOutlet UIView *backgroundColorView;
@property (assign,nonatomic) IBOutlet UIImageView *profileImageView;
@property (assign,nonatomic) IBOutlet UILabel *profileNameLabel;

@end