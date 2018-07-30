//
//  JSONPresentViewControllerAction.m
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/30/18.
//

#import "JSONPresentViewControllerAction.h"
#import "JSONActionPayload.h"
#import "JSONActionPayloadMap.h"
#import "JSONViewController.h"
#import "JSONViewControllerRouter.h"

@interface JSONPresentViewControllerAction ()
@property (nonatomic) id <JSONActionPayload> payload;
@end

@implementation JSONPresentViewControllerAction
@synthesize triggerType = _triggerType;
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        _triggerType = dictionary[@"trigger"];
        _payload = [self parsePayload:dictionary[@"payload"]];
    }
    return self;
}
    
- (id <JSONActionPayload>) parsePayload:(NSDictionary*)payload {
    NSString *type = payload[@"type"];
    Class class = [JSONActionPayloadMap classForPayloadType:type];
    if (class) {
        return [[class alloc] initWithDictionary:payload];
    }
    return nil;
}
    
- (void)performAction {
    NSDictionary *parsedJSON = self.payload.jsonDictionary;
    dispatch_async(dispatch_get_main_queue(), ^{
        JSONViewController *newViewController = [[JSONViewController alloc] initWithJSONDictionary:parsedJSON];
        [[JSONViewControllerRouter sharedInstance] pushViewController:newViewController modal:YES animated:YES];
    });
}
    
@end
