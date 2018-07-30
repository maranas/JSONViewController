//
//  JSONValue.h
//  JSONViewExample
//
//  Created by moises on 7/27/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONValue <NSObject>
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;
@property (nonatomic, readonly) id valueObject;
@end
