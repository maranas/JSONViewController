//
//  JSONAction.h
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/29/18.
//

#import <Foundation/Foundation.h>

@protocol JSONAction <NSObject>
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;
- (void) performAction;
@property (nonatomic, readonly) NSString* triggerType;
@end
