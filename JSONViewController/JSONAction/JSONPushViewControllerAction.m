//
//  JSONPushViewControllerAction.m
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/29/18.
//

#import "JSONPushViewControllerAction.h"
#import "JSONActionPayload.h"
#import "JSONFileActionPayload.h"
// TODO: not needed once router is implemented
@import UIKit;
#import "JSONViewController.h"

@interface JSONPushViewControllerAction ()
@property (nonatomic) id <JSONActionPayload> payload;
@end

@implementation JSONPushViewControllerAction
@synthesize triggerType = _triggerType;

// TODO move mapping to separate object
+ (Class) classForPayloadType:(NSString*)type {
    static NSDictionary *lookup;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lookup = @{
                   @"file": [JSONFileActionPayload class]
                   };
    });
    return lookup[type];
}
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        _triggerType = dictionary[@"trigger"];
        _payload = [self parsePayload:dictionary[@"payload"]];
    }
    return self;
}
    
- (id <JSONActionPayload>) parsePayload:(NSDictionary*)payload {
    NSString *type = payload[@"type"];
    Class class = [JSONPushViewControllerAction classForPayloadType:type];
    if (class) {
        return [[class alloc] initWithDictionary:payload];
    }
    return nil;
}
    
- (void)performAction {
    NSDictionary *parsedJSON = self.payload.jsonDictionary;
    // push
    // TODO: manual pushing will disappear once router is implemented
    dispatch_async(dispatch_get_main_queue(), ^{
        JSONViewController *newViewController = [[JSONViewController alloc] initWithJSONDictionary:parsedJSON];
        [(UINavigationController*)UIApplication.sharedApplication.delegate.window.rootViewController
            pushViewController:newViewController animated:YES];
    });
}
    
@end
