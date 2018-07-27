//
//  JSONView.m
//  JSONViewExample
//
//  Created by moises on 7/26/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import "JSONView.h"
#import "JSONLayout.h"
#import "JSONColor.h"
#import "JSONImage.h"
@import YogaKit;

@implementation JSONView

+ (Class) classForType:(NSString*)type {
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

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super initWithFrame:CGRectZero])) {
        JSONLayout *jsonLayout = [[JSONLayout alloc] initWithDictionary:dictionary[@"layout"]];
        [self configureAppearance:self withDictionary:dictionary[@"appearance"]];
        _title = dictionary[@"appearance"][@"title"];
        [self configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            [self configureView:self forLayout:layout withJsonLayout:jsonLayout];
        }];
        
        [self configureSubviewsForView:self childrenInfo:dictionary[@"items"]];
    }
    return self;
}

- (void) configureSubviewsForView:(UIView*)parentView childrenInfo:(NSArray*)childrenInfo {
    for (NSDictionary *child in childrenInfo) {
        Class class = NSClassFromString(child[@"class"]);
        if (!class) {
            continue;
        }
        UIView* view = ([(UIView*)[class alloc] initWithFrame:CGRectZero]);
        JSONLayout *jsonLayout = [[JSONLayout alloc] initWithDictionary:child[@"layout"]];
        [self configureAppearance:view withDictionary:child[@"appearance"]];
        [view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            [self configureView:view forLayout:layout withJsonLayout:jsonLayout];
        }];
        [self configureSubviewsForView:view childrenInfo:child[@"items"]];
        [parentView addSubview:view];
    }
}

- (void) configureAppearance:(UIView*)view withDictionary:(NSDictionary*)appearanceDictionary {
    for (NSString *key in [appearanceDictionary allKeys]) {
        id rawValue = appearanceDictionary[key];
        // String or number
        if ([rawValue isKindOfClass:[NSString class]] ||
            [rawValue isKindOfClass:[NSNumber class]]) {
            [view setValue:rawValue forKey:key];
        }
        else if ([rawValue isKindOfClass:[NSDictionary class]]) {
            NSDictionary *valueDescription = (NSDictionary*)rawValue;
            NSString *valueType = valueDescription[@"type"];
            Class valueClass = [JSONView classForType:valueType];
            id <JSONValue> jsonValue = [[valueClass alloc] initWithDictionary:valueDescription];
            [view setValue:jsonValue.valueObject forKey:key];
        }
        else {
            NSLog(@"Unknown value type in appearance payload!");
        }
    }
}

- (void) configureView:(UIView*)view forLayout:(YGLayout*)layout withJsonLayout:(JSONLayout*)jsonLayout {
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

@end
