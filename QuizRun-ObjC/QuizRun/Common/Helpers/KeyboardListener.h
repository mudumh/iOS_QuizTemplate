//
//  KeyboardListener.h
//  QuizRun
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KeyboardListener : NSObject

@property (assign,nonatomic) UIScrollView *scrollView;
@property (assign,nonatomic) NSLayoutConstraint *contraint;

- (id)initWithScrollView:(UIScrollView *)scrollView andConstraint:(NSLayoutConstraint *)contraint;

@end
