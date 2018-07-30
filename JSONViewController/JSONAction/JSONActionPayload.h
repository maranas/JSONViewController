//
//  JSONActionPayload.h
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/29/18.
//

#import <Foundation/Foundation.h>

@protocol JSONActionPayload <NSObject>
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;
- (NSDictionary*) jsonDictionary;
@end
