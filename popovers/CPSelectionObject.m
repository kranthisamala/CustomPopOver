//
//  CPSelectionObject.m
//  Almond
//
//  Created by kranthi-samala on 01/03/18.
//  Copyright © 2018 Securifi Ltd. All rights reserved.
//

#import "CPSelectionObject.h"

@implementation CPSelectionObject
-(CPSelectionObject*)init{
    self.view = nil;
    self.message = nil;
    self.nextBtnAlignment = ALIGN_TO_BOTTOM_LEFT_MESSAGE;
    self.skipBtnAlignment = ALIGN_TO_TOP_RIGHT_SCREEN;
    self.textVerticalAlignment = ALIGN_ABOVE_TO_SELECTION;
    self.textHorizontalAlignment = ALIGN_LEFT;
    self.nextBtnTitle  = @"Next";
    self.skipBtnTitle = @"Skip";
    self.hideNext = NO;
    self.hideSkip = NO;
    return self;
}
-(CPSelectionObject*)initWithView:(UIView*)view message:(NSString*)msg{
    self = [self init];
    self.view = view;
    self.message = msg;
    return self;
}
@end
