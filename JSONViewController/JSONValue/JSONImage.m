//
//  JSONImage.m
//  JSONViewExample
//
//  Created by moises on 7/27/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import "JSONImage.h"

@interface JSONImage ()
@property (nonatomic) UIImage* image;
@end

@implementation JSONImage
- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    if ((self = [super init])) {
        if (![dictionary[@"type"] isEqualToString:@"image"]) {
            return nil;
        }
        id value = dictionary[@"value"];
        if ([value isKindOfClass:[NSString class]]) {
            // check bundle
            _image = [UIImage imageNamed:(NSString*)value];
        }
    }
    return self;
}

- (id) valueObject {
    return self.image;
}

@end
