//
//  CategoriesViewController.h
//  QuizRun
//

#import <UIKit/UIKit.h>

@interface CategoriesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (assign,nonatomic) IBOutlet UITableView *tableView;

- (IBAction)onBack:(id)sender;

@end