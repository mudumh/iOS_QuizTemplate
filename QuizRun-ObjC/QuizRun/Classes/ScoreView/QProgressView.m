//
//  QProgressView.m
//  QuizRun
//
//       1/13/14.
//     
//

#import "QProgressView.h"
#import "QCustomizer.h"
#import "QQuestion.h"

@interface QProgressView () {
    CAShapeLayer *_circle;
    CAShapeLayer *_progressCircle;
    CAShapeLayer *_outSideCircle;
    CABasicAnimation *_drawAnimation;
}

@end

@implementation QProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addToView:(UIView *)viewToAdd andPosition:(CGPoint)framePosition andRadius:(float)circleRadius {
    
    radius = circleRadius;
    
    _circle = [CAShapeLayer layer];
    // Make a circular shape
    _circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                              cornerRadius:radius].CGPath;
    // Center the shape in self.view
    _circle.position = CGPointMake(framePosition.x-radius,
                                   framePosition.y-radius);
    
    // Configure the apperence of the circle
    _circle.fillColor = [QCustomizer circleCenterColor].CGColor;
    _circle.strokeColor = [UIColor clearColor].CGColor;
    _circle.lineWidth = 10;
    
    _circle.strokeEnd = 0.0f;
    
    radius = radius + 5;
    _progressCircle = [CAShapeLayer layer];
    // Make a circular shape
    _progressCircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                      cornerRadius:radius].CGPath;
    // Center the shape in self.view
    _progressCircle.position = CGPointMake(framePosition.x-radius ,
                                           framePosition.y-radius);
    
    // Configure the apperence of the circle
    _progressCircle.fillColor = [UIColor clearColor].CGColor;
    _progressCircle.strokeColor = [QCustomizer progressColor].CGColor;
    _progressCircle.lineWidth = 5;
    
    _progressCircle.strokeEnd = 1.0f;
    
    radius = radius + 7;
    _outSideCircle = [CAShapeLayer layer];
    // Make a circular shape
    _outSideCircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                      cornerRadius:radius].CGPath;
    // Center the shape in self.view
    _outSideCircle.position = CGPointMake(framePosition.x-radius ,
                                           framePosition.y-radius);
    
    // Configure the apperence of the circle
    _outSideCircle.fillColor = [UIColor clearColor].CGColor;
    _outSideCircle.strokeColor = [QCustomizer circleCenterColor].CGColor;
    _outSideCircle.lineWidth = 5;
    
    _outSideCircle.strokeEnd = 1.0f;
    
    
    // Add to parent layer
    [self.layer addSublayer:_circle];
    [self.layer addSublayer:_progressCircle];
    [self.layer addSublayer:_outSideCircle];
    
    
    
    [self addAnimation];
    
    self.clipsToBounds = NO;
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(framePosition.x-radius,framePosition.y-radius - 4, 2.0*radius, 2.0*radius)];
    
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:75.0f];
    
    self.timeLabel.backgroundColor = [UIColor clearColor];
    //self.timeLabel.text = @"20";
    [self addSubview:self.timeLabel];
    
    [viewToAdd addSubview:self];
}

- (void)addAnimation {
    // Configure animation
    _drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _drawAnimation.duration            = kAnswerInterval; // "animate over 10 seconds or so.."
    _drawAnimation.repeatCount         = 1.0;  // Animate only once..
    _drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation...
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    _drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    _drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    _drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation to the circle
    [_progressCircle addAnimation:_drawAnimation forKey:@"drawCircleAnimation"];
}

- (void)resume {
    [self resumeLayer:_progressCircle];
}

- (void)pause {
    [self pauseLayer:_progressCircle];
}

- (void)reset {
    [_progressCircle removeAllAnimations];
    [self addAnimation];
}

- (void)pauseLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end