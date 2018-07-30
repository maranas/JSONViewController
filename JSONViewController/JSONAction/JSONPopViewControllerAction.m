//
//  JSONPopViewControllerAction.m
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/31/18.
//

#import "JSONPopViewControllerAction.h"
#import "JSONActionPayload.h"
#import "JSONViewControllerRouter.h"

@implementation JSONPopViewControllerAction
@synthesize triggerType = _triggerType;
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        _triggerType = dictionary[@"trigger"];
    }
    return self;
}
    
- (id <JSONActionPayload>) parsePayload:(NSDictionary*)payload {
    /*
     TODO: payload may be needed for popTo...
     */
    return nil;
}
    
- (void)performAction {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[JSONViewControllerRouter sharedInstance] popViewControllerAnimated:YES];
    });
}
@end
