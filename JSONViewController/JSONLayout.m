//
//  JSONLayout.m
//  JSONViewExample
//
//  Created by moises on 7/26/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import "JSONLayout.h"
@implementation JSONLayout
- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        [self setupSizeWithData:dictionary];
        [self setupFlexingWithData:dictionary];
        [self setupMarginsWithData:dictionary];
        
    }
    return self;
}

- (void) setupSizeWithData:(NSDictionary*)dictionary {
    _width = ygValueFromValueObject(dictionary[@"width"]);
    _height = ygValueFromValueObject(dictionary[@"height"]);
    if (dictionary[@"min-width"]) {
        _minWidth = ygValueFromValueObject(dictionary[@"min-width"]);
    }
    if (dictionary[@"min-height"]) {
        _minHeight = ygValueFromValueObject(dictionary[@"min-height"]);
    }
    if (dictionary[@"max-width"]) {
        _maxWidth = ygValueFromValueObject(dictionary[@"max-width"]);
    }
    if (dictionary[@"max-height"]) {
        _maxHeight = ygValueFromValueObject(dictionary[@"max-height"]);
    }
}

- (void) setupFlexingWithData:(NSDictionary*)dictionary {
    /*
     // TODO: direction
     @property (nonatomic, readonly) YGDirection direction;
     @property (nonatomic, readonly) YGPositionType position;
     @property (nonatomic, readonly) YGOverflow overflow;
     @property (nonatomic, readonly) YGDisplay display;

     */
    // TODO: flex-flow shorthand for direction + wrap
    _flexDirection = ygFlexDirectionFromString(dictionary[@"flex-direction"]);
    _flexWrap = ygWrapFromString(dictionary[@"flex-wrap"]);
    
    // TODO: flex shorthands (grow shrink basis, and initial auto none (some number))
    _flexGrow = [dictionary[@"flex-grow"] doubleValue];
    _flexShrink = [dictionary[@"flex-shrink"] doubleValue];
    _flexBasis = ygValueFromValueObject(dictionary[@"flex-basis"]);
    
    _alignContent = ygAlignFromString(dictionary[@"align-content"]);
    _alignItems = ygAlignFromString(dictionary[@"align-items"]);
    _alignSelf = ygAlignFromString(dictionary[@"align-self"]);
    
    _justifyContent = ygJustifyFromString(dictionary[@"justify-content"]);
}

- (void) setupMarginsWithData:(NSDictionary*)dictionary {
    if (dictionary[@"margin-left"]) {
        _marginLeft = ygValueFromValueObject(dictionary[@"margin-left"]);
    }
    if (dictionary[@"margin-top"]) {
        _marginTop = ygValueFromValueObject(dictionary[@"margin-top"]);
    }
    if (dictionary[@"margin-right"]) {
        _marginRight = ygValueFromValueObject(dictionary[@"margin-right"]);
    }
    if (dictionary[@"margin-bottom"]) {
        _marginBottom = ygValueFromValueObject(dictionary[@"margin-bottom"]);
    }
    if (dictionary[@"margin-start"]) {
        _marginStart = ygValueFromValueObject(dictionary[@"margin-start"]);
    }
    if (dictionary[@"margin-end"]) {
        _marginEnd = ygValueFromValueObject(dictionary[@"margin-end"]);
    }
    if (dictionary[@"margin-horizontal"]) {
        _marginHorizontal = ygValueFromValueObject(dictionary[@"margin-horizontal"]);
    }
    if (dictionary[@"margin-vertical"]) {
        _marginVertical = ygValueFromValueObject(dictionary[@"margin-vertical"]);
    }
    if (dictionary[@"margin"]) {
        _margin = ygValueFromValueObject(dictionary[@"margin"]);
    }
}

#pragma mark -

YGValue ygValueFromValueObject(NSObject *object) {
    if ([object isKindOfClass:[NSNumber class]]) {
        return YGPointValue(((NSNumber*)object).doubleValue);
    }
    else if ([object isKindOfClass:[NSString class]]) {
        NSString *stringObject = (NSString*)object;
        if ([stringObject rangeOfString:@"%"].location == NSNotFound) {
            return YGPointValue(stringObject.doubleValue);
        }
        else {
            return YGPercentValue(stringObject.doubleValue);
        }
    }
    else {
        return YGValueAuto;
    }
}

YGFlexDirection ygFlexDirectionFromString(NSString* directionString) {
    if ([directionString isEqualToString:@"column"]) {
        return YGFlexDirectionColumn;
    }
    else if ([directionString isEqualToString:@"column-reverse"]) {
        return YGFlexDirectionColumnReverse;
    }
    else if ([directionString isEqualToString:@"row"]) {
        return YGFlexDirectionRow;
    }
    else if ([directionString isEqualToString:@"row-reverse"]) {
        return YGFlexDirectionRowReverse;
    }
    else {
        // default
        return YGFlexDirectionColumn;
    }
}

YGWrap ygWrapFromString(NSString* wrapString) {
    if ([wrapString isEqualToString:@"wrap"]) {
        return YGWrapWrap;
    }
    else if ([wrapString isEqualToString:@"wrap-reverse"]) {
        return YGWrapWrapReverse;
    }
    return YGWrapNoWrap;
}

YGAlign ygAlignFromString(NSString* alignString) {
    if ([alignString isEqualToString:@"flex-start"]) {
        return YGAlignFlexStart;
    }
    else if ([alignString isEqualToString:@"center"]) {
        return YGAlignCenter;
    }
    else if ([alignString isEqualToString:@"flex-end"]) {
        return YGAlignFlexEnd;
    }
    else if ([alignString isEqualToString:@"stretch"]) {
        return YGAlignStretch;
    }
    else if ([alignString isEqualToString:@"baseline"]) {
        return YGAlignBaseline;
    }
    else if ([alignString isEqualToString:@"space-between"]) {
        return YGAlignSpaceBetween;
    }
    else if ([alignString isEqualToString:@"space-around"]) {
        return YGAlignSpaceAround;
    }
    return YGAlignAuto;
}

YGJustify ygJustifyFromString(NSString* justifyString) {
    if ([justifyString isEqualToString:@"flex-start"]) {
        return YGJustifyFlexStart;
    }
    else if ([justifyString isEqualToString:@"center"]) {
        return YGJustifyCenter;
    }
    else if ([justifyString isEqualToString:@"flex-end"]) {
        return YGJustifyFlexEnd;
    }
    else if ([justifyString isEqualToString:@"space-between"]) {
        return YGJustifySpaceBetween;
    }
    else if ([justifyString isEqualToString:@"space-around"]) {
        return YGJustifySpaceAround;
    }
    else if ([justifyString isEqualToString:@"space-evenly"]) {
        return YGJustifySpaceEvenly;
    }
    return YGJustifyFlexStart;
}
@end
