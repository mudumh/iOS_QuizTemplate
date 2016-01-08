//
//  SettingsLogOutTableViewCell.m
//  QuizRun
//
//       3/11/15.
//     
//

#import "SettingsLogOutTableViewCell.h"
#import "AppDelegate.h"

@implementation SettingsLogOutTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Actions

- (IBAction)onLogOut:(id)sender {
    [[AppDelegate sharedDelegate] logOut];
}


@end
