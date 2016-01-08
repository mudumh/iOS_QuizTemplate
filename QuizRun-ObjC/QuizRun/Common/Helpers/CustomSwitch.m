//
//  CustomSwitch.m
//  QuizRun
//

#import "CustomSwitch.h"

const float shrinkValue = 0.7f;

@implementation CustomSwitch

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.transform = CGAffineTransformMakeScale(shrinkValue, shrinkValue);
    }
    return self;
}

@end