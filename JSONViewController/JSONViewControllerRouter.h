//
//  JSONViewControllerRouter.h
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/30/18.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface JSONViewControllerRouter : NSObject
+ (instancetype) sharedInstance;
@property (nonatomic) UINavigationController *rootNavigationController;
- (void) removedFromStack:(UIViewController*)viewController;
- (void) pushViewController:(UIViewController*)viewController modal:(BOOL)modal animated:(BOOL)animated;
- (void) popViewControllerAnimated:(BOOL)animated;
/*
- (void) popToViewControllerNamed:(NSString*)animated;
- (void) popToRootViewControlleAnimated:(BOOL)animated;
 */
@end
