//
//  CategoriesViewController.m
//  QuizRun
//
#import "CategoriesViewController.h"
#import "CategoryTableViewCell.h"
#import "QuizCategoriesManager.h"
#import "QuizCategory.h"

@interface CategoriesViewController ()

@property (strong,nonatomic) NSArray *categories;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categories = [[QuizCategoriesManager sharedManager] loadData];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    
    QuizCategory *category = self.categories[indexPath.row];
    
    cell.titleLabel.text = category.title;
    cell.categoryImageView.image = [UIImage imageNamed:category.imageURL];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"startGame" sender:nil];
}

#pragma mark - Actions

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end