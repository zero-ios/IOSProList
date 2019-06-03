#import <Foundation/Foundation.h>


@interface DefaultInstance : NSObject

@property (nonatomic, strong) NSString *str;

+(instancetype)sharedInstance;

@end
