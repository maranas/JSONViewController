//
//  JSONLayout.h
//  JSONViewExample
//
//  Created by moises on 7/26/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@import YogaKit;

@interface JSONLayout : NSObject
- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

// size
@property (nonatomic, readonly) YGValue width;
@property (nonatomic, readonly) YGValue height;
@property (nonatomic, readonly) YGValue minWidth;
@property (nonatomic, readonly) YGValue minHeight;
@property (nonatomic, readonly) YGValue maxWidth;
@property (nonatomic, readonly) YGValue maxHeight;

// flex
@property (nonatomic, readonly) YGDirection direction;
@property (nonatomic, readonly) YGFlexDirection flexDirection;
@property (nonatomic, readonly) YGJustify justifyContent;
@property (nonatomic, readonly) YGAlign alignContent;
@property (nonatomic, readonly) YGAlign alignItems;
@property (nonatomic, readonly) YGAlign alignSelf;
@property (nonatomic, readonly) YGPositionType position;
@property (nonatomic, readonly) YGWrap flexWrap;
@property (nonatomic, readonly) YGOverflow overflow;
@property (nonatomic, readonly) YGDisplay display;
@property (nonatomic, readonly) CGFloat flexGrow;
@property (nonatomic, readonly) CGFloat flexShrink;
@property (nonatomic, readonly) YGValue flexBasis;

// edges
@property (nonatomic, readonly) YGValue left;
@property (nonatomic, readonly) YGValue top;
@property (nonatomic, readonly) YGValue right;
@property (nonatomic, readonly) YGValue bottom;
@property (nonatomic, readonly) YGValue start;
@property (nonatomic, readonly) YGValue end;

// margins
@property (nonatomic, readonly) YGValue marginLeft;
@property (nonatomic, readonly) YGValue marginTop;
@property (nonatomic, readonly) YGValue marginRight;
@property (nonatomic, readonly) YGValue marginBottom;
@property (nonatomic, readonly) YGValue marginStart;
@property (nonatomic, readonly) YGValue marginEnd;
@property (nonatomic, readonly) YGValue marginHorizontal;
@property (nonatomic, readonly) YGValue marginVertical;
@property (nonatomic, readonly) YGValue margin;

// padding
@property (nonatomic, readonly) YGValue paddingLeft;
@property (nonatomic, readonly) YGValue paddingTop;
@property (nonatomic, readonly) YGValue paddingRight;
@property (nonatomic, readonly) YGValue paddingBottom;
@property (nonatomic, readonly) YGValue paddingStart;
@property (nonatomic, readonly) YGValue paddingEnd;
@property (nonatomic, readonly) YGValue paddingHorizontal;
@property (nonatomic, readonly) YGValue paddingVertical;
@property (nonatomic, readonly) YGValue padding;

// border
@property (nonatomic, readonly) CGFloat borderLeftWidth;
@property (nonatomic, readonly) CGFloat borderTopWidth;
@property (nonatomic, readonly) CGFloat borderRightWidth;
@property (nonatomic, readonly) CGFloat borderBottomWidth;
@property (nonatomic, readonly) CGFloat borderStartWidth;
@property (nonatomic, readonly) CGFloat borderEndWidth;
@property (nonatomic, readonly) CGFloat borderWidth;

@end
