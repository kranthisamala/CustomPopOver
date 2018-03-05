//
//  CPSelectionObject.h
//  Almond
//
//  Created by kranthi-samala on 01/03/18.
//  Copyright © 2018 Securifi Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(unsigned int, CPHorizontalTextAlignment) {
    ALIGN_CENTER,
    ALIGN_LEFT,
    ALIGN_RIGHT
};
typedef NS_ENUM(unsigned int, CPVerticalTextAlignment) {
    ALIGN_ABOVE_TO_SELECTION,
    ALIGN_BELOW_TO_SELECTION
};
typedef NS_ENUM(unsigned int, CPViewAlignment) {
    ALIGN_TO_TOP_LEFT_SCREEN,
    ALIGN_TO_TOP_RIGHT_SCREEN,
    ALIGN_TO_BOTTOM_LEFT_SCREEN,
    ALIGN_TO_BOTTOM_RIGHT_SCREEN,
    ALIGN_TO_TOP_LEFT_MESSAGE,
    ALIGN_TO_TOP_RIGHT_MESSAGE,
    ALIGN_TO_BOTTOM_LEFT_MESSAGE,
    ALIGN_TO_BOTTOM_RIGHT_MESSAGE,
};
@interface CPSelectionObject : NSObject

    @property UIView *view;
    @property NSString *message;
    @property CPHorizontalTextAlignment textHorizontalAlignment;
    @property CPVerticalTextAlignment textVerticalAlignment;
    @property CPViewAlignment nextBtnAlignment;
    @property CPViewAlignment skipBtnAlignment;
    @property BOOL hideSkip;
    @property BOOL hideNext;
    @property NSString *nextBtnTitle;
    @property NSString *skipBtnTitle;
    -(CPSelectionObject*)init;
    -(CPSelectionObject*)initWithView:(UIView*)view message:(NSString*)msg;
@end
