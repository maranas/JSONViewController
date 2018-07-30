//
//  JSONActionPayloadMap.m
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/30/18.
//

#import "JSONActionPayloadMap.h"
#import "JSONFileActionPayload.h"

@implementation JSONActionPayloadMap
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
@end
