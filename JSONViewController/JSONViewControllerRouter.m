//
//  JSONViewControllerRouter.m
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/30/18.
//

#import "JSONViewControllerRouter.h"

@interface JSONViewControllerRouter ()
@property (nonatomic) NSMutableArray<UIViewController*>* navigationStack;
@end

@implementation JSONViewControllerRouter
+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static JSONViewControllerRouter *_router;
    dispatch_once(&onceToken, ^{
        _router = [JSONViewControllerRouter new];
    });
    return _router;
}
    
- (NSMutableArray*) navigationStack {
    if (!_navigationStack) {
        _navigationStack = [NSMutableArray new];
    }
    return _navigationStack;
}
    
- (void) removedFromStack:(UIViewController*) viewController {
    if ([self.navigationStack lastObject] == viewController) {
        [self.navigationStack removeObject:viewController];
    }
}
    
- (UINavigationController*) rootNavigationController {
    if (!_rootNavigationController) {
        _rootNavigationController = (UINavigationController*)UIApplication.sharedApplication.delegate.window.rootViewController;
        if (![_rootNavigationController isKindOfClass:[UINavigationController class]]) {
            NSLog(@"WARNING: Root view controller is not a UINavigationController. Routing might not work.");
        }
    }
    return _rootNavigationController;
}
    
- (void) pushViewController:(UIViewController*)viewController modal:(BOOL)modal animated:(BOOL)animated {
    if (modal) {
        UIViewController* presenter = [self.navigationStack lastObject];
        if (!presenter) {
            presenter = self.rootNavigationController;
        }
        [presenter presentViewController:viewController animated:animated completion:nil];
    }
    else {
        [self.rootNavigationController pushViewController:viewController animated:animated];
    }
    [self.navigationStack addObject:viewController];
}

- (void) popViewControllerAnimated:(BOOL)animated {
    UIViewController *viewController = [self.navigationStack lastObject];
    if (viewController.presentingViewController) {
        [viewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.rootNavigationController popViewControllerAnimated:YES];
    }
    [self.navigationStack removeObject:viewController];
}

@end
