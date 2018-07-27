//
//  JSONColor.m
//  JSONViewExample
//
//  Created by moises on 7/27/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import "JSONColor.h"
@interface JSONColor ()
@property (nonatomic) UIColor* color;
@end

@implementation JSONColor
- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    if ((self = [super init])) {
        if (![dictionary[@"type"] isEqualToString:@"color"]) {
            return nil;
        }
        id value = dictionary[@"value"];
        if ([value isKindOfClass:[NSString class]]) {
            // assume this is a color on UIColor
            _color = [UIColor valueForKey:value];
        }
    }
    return self;
}

- (id) valueObject {
    return self.color;
}
@end
