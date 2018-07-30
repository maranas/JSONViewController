//
//  JSONViewController.h
//  JSONViewExample
//
//  Created by moises on 7/26/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSONViewController : UIViewController
- (instancetype) initWithJSONDictionary:(NSDictionary*)jsonDictionary;
- (void) updateWithJSONDictionary:(NSDictionary*)jsonDictionary;
@end
