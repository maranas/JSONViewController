//
//  UIView+JSONView.m
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/30/18.
//

#import "UIView+JSONView.h"
#import "JSONLayout.h"
#import "JSONColor.h"
#import "JSONImage.h"
#import "JSONAction.h"
#import "JSONPushViewControllerAction.h"
#import "JSONPresentViewControllerAction.h"
#import "JSONPopViewControllerAction.h"
#import <objc/runtime.h>
@import YogaKit;

@implementation UIView (JSONView)

+ (Class) classForValueType:(NSString*)type {
    static dispatch_once_t onceToken;
    static NSDictionary *classLookup;
    dispatch_once(&onceToken, ^{
        classLookup = @{
                        @"color" : [JSONColor class],
                        @"image" : [JSONImage class]
                        };
    });
    return classLookup[type];
}
    
+ (Class<JSONAction>) classForActionType:(NSString*)type {
    static dispatch_once_t onceToken;
    static NSDictionary *classLookup;
    dispatch_once(&onceToken, ^{
        classLookup = @{
                        @"push" : [JSONPushViewControllerAction class],
                        @"present": [JSONPresentViewControllerAction class],
                        @"pop": [JSONPopViewControllerAction class]
                        };
    });
    return classLookup[type];
}
    
- (void) configureWithDictionary:(NSDictionary*)dictionary {
    JSONLayout *jsonLayout = [[JSONLayout alloc] initWithDictionary:dictionary[@"layout"]];
    [self configureAppearanceWithDictionary:dictionary[@"appearance"]];
    [self configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        [self configureForLayout:layout withJsonLayout:jsonLayout];
    }];
    [self configureActions:dictionary[@"actions"]];
    
    [self configureSubviewsWithChildrenInfo:dictionary[@"items"]];
}
    
- (NSString*) title {
    return objc_getAssociatedObject(self, @selector(title));
}
    
- (void) setTitle:(NSString *)title {
    if (title) {
        objc_setAssociatedObject(self, @selector(title), title, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
    
- (void) configureSubviewsWithChildrenInfo:(NSArray*)childrenInfo {
    for (NSDictionary *child in childrenInfo) {
        Class class = NSClassFromString(child[@"class"]);
        if (!class) {
            continue;
        }
        UIView* view = ([(UIView*)[class alloc] initWithFrame:CGRectZero]);
        [view configureWithDictionary:child];
        [self addSubview:view];
    }
}
    
- (void) configureAppearanceWithDictionary:(NSDictionary*)appearanceDictionary {
    for (NSString *key in [appearanceDictionary allKeys]) {
        id rawValue = appearanceDictionary[key];
        // String or number
        if ([rawValue isKindOfClass:[NSString class]] ||
            [rawValue isKindOfClass:[NSNumber class]]) {
            [self setValue:rawValue forKey:key];
        }
        else if ([rawValue isKindOfClass:[NSDictionary class]]) {
            NSDictionary *valueDescription = (NSDictionary*)rawValue;
            NSString *valueType = valueDescription[@"type"];
            Class valueClass = [UIView classForValueType:valueType];
            id <JSONValue> jsonValue = [[valueClass alloc] initWithDictionary:valueDescription];
            [self setValue:jsonValue.valueObject forKey:key];
        }
        else {
            NSLog(@"Unknown value type in appearance payload!");
        }
    }
}
    
- (void) configureForLayout:(YGLayout*)layout withJsonLayout:(JSONLayout*)jsonLayout {
    layout.isEnabled = YES;
    layout.direction = jsonLayout.direction;
    layout.flexDirection = jsonLayout.flexDirection;
    layout.justifyContent = jsonLayout.justifyContent;
    layout.alignContent = jsonLayout.alignContent;
    layout.alignItems = jsonLayout.alignItems;
    layout.alignSelf = jsonLayout.alignSelf;
    layout.position = jsonLayout.position;
    layout.flexWrap = jsonLayout.flexWrap;
    layout.overflow = jsonLayout.overflow;
    layout.display = jsonLayout.display;
    
    layout.flexGrow = jsonLayout.flexGrow;
    layout.flexShrink = jsonLayout.flexShrink;
    layout.flexBasis = jsonLayout.flexBasis;
    
    layout.left = jsonLayout.left;
    layout.top = jsonLayout.top;
    layout.right = jsonLayout.right;
    layout.bottom = jsonLayout.bottom;
    layout.start = jsonLayout.start;
    layout.end = jsonLayout.end;
    
    layout.margin = jsonLayout.margin;
    layout.marginLeft = jsonLayout.marginLeft;
    layout.marginTop = jsonLayout.marginTop;
    layout.marginRight = jsonLayout.marginRight;
    layout.marginBottom = jsonLayout.marginBottom;
    layout.marginStart = jsonLayout.marginStart;
    layout.marginEnd = jsonLayout.marginEnd;
    layout.marginHorizontal = jsonLayout.marginHorizontal;
    layout.marginVertical = jsonLayout.marginVertical;
    
    layout.padding = jsonLayout.padding;
    layout.paddingLeft = jsonLayout.paddingLeft;
    layout.paddingTop = jsonLayout.paddingTop;
    layout.paddingRight = jsonLayout.paddingRight;
    layout.paddingBottom = jsonLayout.paddingBottom;
    layout.paddingStart = jsonLayout.paddingStart;
    layout.paddingEnd = jsonLayout.paddingEnd;
    layout.paddingHorizontal = jsonLayout.paddingHorizontal;
    layout.paddingVertical = jsonLayout.paddingVertical;
    
    layout.borderWidth = jsonLayout.borderWidth;
    layout.borderLeftWidth = jsonLayout.borderLeftWidth;
    layout.borderTopWidth = jsonLayout.borderTopWidth;
    layout.borderRightWidth = jsonLayout.borderRightWidth;
    layout.borderBottomWidth = jsonLayout.borderBottomWidth;
    layout.borderStartWidth = jsonLayout.borderStartWidth;
    layout.borderEndWidth = jsonLayout.borderEndWidth;
    
    layout.width = jsonLayout.width;
    layout.height = jsonLayout.height;
    if (jsonLayout.minWidth.value > 0) {
        layout.minWidth = jsonLayout.minWidth;
    }
    if (jsonLayout.maxWidth.value > 0) {
        layout.maxWidth = jsonLayout.maxWidth;
    }
    if (jsonLayout.minHeight.value > 0) {
        layout.minHeight = jsonLayout.minHeight;
    }
    if (jsonLayout.maxHeight.value > 0) {
        layout.maxHeight = jsonLayout.maxHeight;
    }
}
    
- (void) configureActions:(NSArray*)actions {
    NSMutableDictionary *actionObjects = [NSMutableDictionary new];
    for (NSDictionary *actionDictionary in actions) {
        Class actionClass = [UIView classForActionType:actionDictionary[@"type"]];
        if (actionClass) {
            id<JSONAction> action = [[actionClass alloc] initWithDictionary:actionDictionary];
            NSString *trigger = action.triggerType;
            if (trigger) {
                actionObjects[trigger] = action;
            }
            if ([trigger isEqualToString:@"tap"]) {
                UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                [self addGestureRecognizer:recognizer];
            }
        }
    }
    if (actionObjects.count) {
        objc_setAssociatedObject(self, @selector(configureActions:), actionObjects, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.userInteractionEnabled = YES;
    }
}
    
#pragma mark - action handlers
- (void) tapAction:(UITapGestureRecognizer*)sender {
    if (sender.view == self) {
        NSDictionary *actionObjects = objc_getAssociatedObject(self, @selector(configureActions:));
        id<JSONAction> actionObject = actionObjects[@"tap"];
        [actionObject performAction];
    }
}
    
@end
