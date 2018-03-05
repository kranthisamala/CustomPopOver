//
//  CustomPopOver.h
//  Almond
//
//  Created by kranthi-samala on 27/02/18.
//  Copyright © 2018 Securifi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(unsigned int, CustomPopOverReason) {
    SKIPPED,
    LIST_COMPLETED
};
@protocol customPopOverDelegate
-(void)closePopOver:(CustomPopOverReason)reason;
@end
@interface CustomPopOver : UIView
{
    NSArray *rectsArray;
    CGRect hitAbleArea;
    UIColor *backgroundColor;
    int index;
}
- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)color andTransparentRects:(NSArray*)rects;
-(void)updateList:(NSArray*)arr;
@property (weak,nonatomic) id<customPopOverDelegate> delegate;
@end

