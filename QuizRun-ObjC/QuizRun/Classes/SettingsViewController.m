//
//  SettingsViewController.m
//  QuizRun
//
//       3/11/15.
//     
//

#import "SettingsViewController.h"
#import "SharingManager.h"

//cells
#import "SettingsProfileTableViewCell.h"
#import "SettingsSwitcherTableViewCell.h"
#import "SettingsActionTableViewCell.h"
#import "SettingsLogOutTableViewCell.h"

typedef enum {
    SettingsRowProfile,
    SettingsRowSounds,
    SettingsRowDelay,
    SettingsRowContactUS,
    SettingsRowReport,
    SettingsRowInviteFriend,
    SettingsRowLogOut,
    SettingsRowCount,
}SettingsRow;

@interface SettingsViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.backButton;
}

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return SettingsRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case SettingsRowProfile: {
            cell = (SettingsProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsProfileCell"];
            [(SettingsProfileTableViewCell *) cell backgroundColorView].backgroundColor = [UIColor clearColor];
            break;
        }
        case SettingsRowSounds:{
            cell = (SettingsSwitcherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsSwitcherCell"];
            [(SettingsSwitcherTableViewCell *)cell titleLabel].text = @"In App Sounds";
            break;
        }
        case SettingsRowDelay:{
            cell = (SettingsSwitcherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsSwitcherCell"];
            [(SettingsSwitcherTableViewCell *)cell backgroundColorView].backgroundColor = [UIColor clearColor];
            [(SettingsSwitcherTableViewCell *)cell titleLabel].text = @"Questions Delay";
            break;
        }
        case SettingsRowContactUS:{
            cell = (SettingsActionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsActionCell"];
            [(SettingsActionTableViewCell *)cell titleLabel].text = @"Contact Us";
            break;
        }
        case SettingsRowReport:{
            cell = (SettingsActionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsActionCell"];
            [(SettingsActionTableViewCell *)cell backgroundColorView].backgroundColor = [UIColor clearColor];
            [(SettingsActionTableViewCell *)cell titleLabel].text = @"Report Wrong Answer";
            break;
        }
        case SettingsRowInviteFriend:{
            cell = (SettingsActionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsActionCell"];
            [(SettingsActionTableViewCell *)cell titleLabel].text = @"Invite Friend";
            break;
        }
        case SettingsRowLogOut:{
            cell = (SettingsLogOutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"settingsLogOutCell"];
            [(SettingsLogOutTableViewCell *)cell backgroundColorView].backgroundColor = [UIColor clearColor];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case SettingsRowProfile: {
            return 126;
        }
        case SettingsRowSounds:{
            return 70;
        }
        case SettingsRowDelay:{
            return 70;
        }
        case SettingsRowContactUS:{
            return 70;
        }
        case SettingsRowReport:{
            return 70;
        }
        case SettingsRowInviteFriend:{
            return 70;
        }
        case SettingsRowLogOut:{
            return 96;
        }
        default:
            break;
    }
    
    return 0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case SettingsRowContactUS:{
            [[SharingManager sharedManager] inviteByMailFromViewController:self.navigationController withSubject:@"Support"];
            break;
        }
        case SettingsRowReport:{
            [[SharingManager sharedManager] inviteByMailFromViewController:self.navigationController withSubject:@"Report"];
            break;
        }
        case SettingsRowInviteFriend:{
            [[SharingManager sharedManager] inviteByMailFromViewController:self.navigationController withSubject:@"Invitation"];
            break;
        }
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end