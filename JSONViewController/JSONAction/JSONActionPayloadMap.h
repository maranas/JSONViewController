//
//  JSONActionPayloadMap.h
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/30/18.
//

#import <Foundation/Foundation.h>

@interface JSONActionPayloadMap : NSObject
+ (Class) classForPayloadType:(NSString*)type;
@end
