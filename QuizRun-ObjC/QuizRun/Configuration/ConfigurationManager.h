//
//  ConfigurationManager.h
//  QuizRun
//


#import <Foundation/Foundation.h>

@interface ConfigurationManager : NSObject

@property (nonatomic,readonly,copy) NSString *appId;
@property (nonatomic,readonly,copy) NSString *contactMail;
@property (nonatomic,readonly,copy) NSNumber *rateAppDelay;
@property (nonatomic,readonly,copy) NSString *flurrySessionID;
@property (nonatomic,readonly,copy) NSString *leaderBoardIdentifier;
@property (nonatomic,readonly,copy) NSString *mailSubject;

+ (ConfigurationManager *)sharedManager;

@end
