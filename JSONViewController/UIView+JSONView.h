//
//  UIView+JSONView.h
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/30/18.
//

#import <UIKit/UIKit.h>

@interface UIView (JSONView)
@property (nonatomic, readonly) NSString *title;
- (void) configureWithDictionary:(NSDictionary *)dictionary;
@end
