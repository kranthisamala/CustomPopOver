//
//  CustomPopOver.m
//  Almond
//
//  Created by kranthi-samala on 27/02/18.
//  Copyright © 2018 Securifi Ltd. All rights reserved.
//

#import "CustomPopOver.h"
#import "UICommonMethods.h"
#import "CPSelectionObject.h"
#define FONT @"Avenir-Light"
#define FONTSIZE 22
#define PADDING 10
@interface CustomPopOver()
@property CAShapeLayer *fillLayer;
@property CATextLayer *nextBtn;
@property CGRect nextBtnRect;
@property CATextLayer *skipBtn;
@property CATextLayer *messageLyr;
@property CGRect skipBtnRect;
@property CGPoint lastEventOrigin;
@property CPSelectionObject *currentCPObj;
@end
@implementation CustomPopOver
- (id)initWithFrame:(CGRect)frame bgColor:(UIColor*)color andTargetViews:(NSArray*)rects
{
    index = 0;
    backgroundColor = color;
    rectsArray = rects;
    self.lastEventOrigin = CGPointZero;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
    }
    self.skipBtnRect = CGRectMake(self.frame.size.width-80, 20, 60, 40);
    self.nextBtnRect = CGRectMake(self.frame.size.width-80, self.frame.size.height-60, 60, 40);
    return self;
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
 if(CGRectContainsPoint(self.skipBtnRect,point)&&event.type==UIEventTypeTouches&&
       event.subtype == UIEventSubtypeNone){
         if(CGPointEqualToPoint(self.lastEventOrigin,point)){
             self.lastEventOrigin = CGPointZero;
             return YES;
         }else{
             self.lastEventOrigin = point;
         }
        [self skipClicked];
        return YES;
    }else if(CGRectContainsPoint(self.nextBtnRect,point) && event.type == UIEventTypeTouches && event.subtype == UIEventSubtypeNone){
        if(CGPointEqualToPoint(self.lastEventOrigin,point)){
            self.lastEventOrigin = CGPointZero;
            return YES;
        }else{
            self.lastEventOrigin = point;
        }
        [self nextClicked];
        return YES;
    }else if(CGRectContainsPoint(hitAbleArea,point)) {
        return NO;
    }
    return YES;
}
- (void)nextClicked{
    if(index+1<rectsArray.count){
        index++;
        [self drawPopOver];
    }else{
        [self.delegate closePopOver:LIST_COMPLETED];
    }
}
- (void)skipClicked{
    [self.delegate closePopOver:SKIPPED];
}
- (void)drawRect:(CGRect)rect
{
//    [self addPrevAndNext];
    if(index+1<rectsArray.count){
        [self drawPopOver];
    }else{
        [self.delegate closePopOver:LIST_COMPLETED];
    }
}
-(void)updateList:(NSArray*)arr{
    index = 0;
    rectsArray = arr.copy;
    [self drawPopOver];
}
-(void)drawPopOver{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
    self.currentCPObj = (CPSelectionObject*)[rectsArray objectAtIndex:index];
    UIView *view = self.currentCPObj.view;
    CGRect holeRect = [view.superview convertRect:view.frame toView:nil];
    CGFloat xOrigin = holeRect.origin.x-(PADDING/2);
    CGFloat yOrigin = holeRect.origin.y-(PADDING/2);
    CGFloat width = CGRectGetWidth(view.frame)+PADDING;
    CGFloat height = CGRectGetHeight(view.frame)+PADDING;
    CGFloat maxDiameter = width>height?width:height;
    xOrigin = xOrigin-(maxDiameter-width)/2;
    yOrigin = yOrigin-(maxDiameter-height)/2;
    holeRect = CGRectMake(xOrigin,yOrigin,maxDiameter,maxDiameter);
    hitAbleArea = holeRect;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:holeRect cornerRadius:holeRect.size.width];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    self.nextBtnRect = [self frameWithAlignment:self.currentCPObj.nextBtnAlignment string:self.currentCPObj.nextBtnTitle];
    self.skipBtnRect = [self frameWithAlignment:self.currentCPObj.skipBtnAlignment string:self.currentCPObj.skipBtnTitle];
    if(self.fillLayer==nil){
        self.fillLayer = [CAShapeLayer layer];
        self.fillLayer.path = path.CGPath;
        self.fillLayer.fillRule = kCAFillRuleEvenOdd;
        self.fillLayer.fillColor = [UIColor blackColor].CGColor;
        self.fillLayer.opacity = 0.8;
        [self.layer addSublayer:self.fillLayer];
        self.nextBtn = [CATextLayer layer];
        [self.nextBtn setFont:FONT];
        [self.nextBtn setFontSize:FONTSIZE];
        [self.nextBtn setFrame:self.nextBtnRect];
        [self.nextBtn setString:self.currentCPObj.nextBtnTitle];
        [self.nextBtn setAlignmentMode:kCAAlignmentCenter];
        [self.nextBtn setForegroundColor:[[UIColor whiteColor] CGColor]];
        [self.nextBtn setBackgroundColor:[[UIColor blueColor] CGColor]];
        [self.layer addSublayer:self.nextBtn];
        self.skipBtn = [CATextLayer layer];
        [self.skipBtn setFont:FONT];
        [self.skipBtn setFontSize:FONTSIZE];
        [self.skipBtn setFrame:self.skipBtnRect];
        [self.skipBtn setString:self.currentCPObj.skipBtnTitle];
        [self.skipBtn setAlignmentMode:kCAAlignmentCenter];
        [self.skipBtn setForegroundColor:[[UIColor whiteColor] CGColor]];
        [self.layer addSublayer:self.skipBtn];
        self.messageLyr = [CATextLayer layer];
        [self.messageLyr setFont:FONT];
        [self.messageLyr setFontSize:FONTSIZE];
        self.messageLyr.wrapped = YES;
        [self.messageLyr setFrame:[self frameForMessage]];
        [self.messageLyr setString:self.currentCPObj.message];
        [self.messageLyr setAlignmentMode:[self textHorizontalAlignment]];
        [self.messageLyr setForegroundColor:[[UIColor whiteColor] CGColor]];
        [self.layer addSublayer:self.messageLyr];
    }else{
        [self.nextBtn setFrame:self.nextBtnRect];
        self.fillLayer.path = path.CGPath;
        [self.skipBtn setFrame:self.skipBtnRect];
        [self.messageLyr setAlignmentMode:[self textHorizontalAlignment]];
        [self.messageLyr setFrame:[self frameForMessage]];
        [self.messageLyr setString:self.currentCPObj.message];
    }
    
}
-(CGRect)frameForMessage{
    CGRect frame = hitAbleArea;
    float width = self.frame.size.width-(PADDING*2);
    NSString *message = self.currentCPObj.message;
    UIFont *font = [UIFont fontWithName:FONT size:FONTSIZE];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName: font}];
    CGRect tempRect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                                 context:nil];
    frame.origin.x = PADDING;
    CGFloat messageHeight = ceilf(tempRect.size.height);
    frame.origin.y = self.currentCPObj.textVerticalAlignment == ALIGN_ABOVE_TO_SELECTION?(frame.origin.y-PADDING-messageHeight):(frame.origin.y+frame.size.width+PADDING);
    frame.size.width = ceilf(tempRect.size.width);
    frame.size.height = messageHeight;
    return frame;
}
-(NSString*)textHorizontalAlignment{
    NSString *alignment;
    if(self.currentCPObj.textHorizontalAlignment == ALIGN_RIGHT){
        alignment = kCAAlignmentRight;
    }else if(self.currentCPObj.textHorizontalAlignment == ALIGN_LEFT){
        alignment = kCAAlignmentLeft;
    }else{
        alignment = kCAAlignmentCenter;
    }
    return alignment;
}
-(CGRect)frameForText:(NSString*)msg withSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:FONT size:(fontSize)];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:msg attributes:@{NSFontAttributeName:font}];
    CGRect tempRect = [attributedText boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
    tempRect.size.width = ceilf(tempRect.size.width);
    tempRect.size.height = ceilf(tempRect.size.height);
    return tempRect;
}
-(CGRect)frameWithAlignment:(CPViewAlignment)align string:(NSString*)msg{
    CGRect frame = [self frameForText:msg withSize:FONTSIZE];
    CGFloat width = frame.size.width;
    CGFloat lineHeight = frame.size.height;
    if(align == ALIGN_TO_TOP_LEFT_SCREEN){
        frame = CGRectMake(PADDING, PADDING, width, lineHeight);
    }else if(align == ALIGN_TO_TOP_RIGHT_SCREEN){
        frame = CGRectMake(self.frame.size.width-width-PADDING, PADDING, width, lineHeight);
    }else if(align == ALIGN_TO_BOTTOM_LEFT_SCREEN){
        frame = CGRectMake(PADDING, self.frame.size.height-lineHeight-PADDING, width, lineHeight);
    }else if(align == ALIGN_TO_BOTTOM_RIGHT_SCREEN){
        frame = CGRectMake(self.frame.size.width-width-PADDING, self.frame.size.height-lineHeight-PADDING, width, lineHeight);
        
    }else if(align == ALIGN_TO_TOP_LEFT_MESSAGE){
        
        CGRect messageFrame = [self frameForMessage];
        frame = CGRectMake(messageFrame.origin.x, messageFrame.origin.y-lineHeight-PADDING, width, lineHeight);
        
    }else if(align == ALIGN_TO_TOP_RIGHT_MESSAGE){
        
        CGRect messageFrame = [self frameForMessage];
        frame = CGRectMake(messageFrame.origin.x+messageFrame.size.width-width,messageFrame.origin.y-lineHeight-PADDING, width, lineHeight);
        
    }else if(align == ALIGN_TO_BOTTOM_LEFT_MESSAGE){
       
        CGRect messageFrame = [self frameForMessage];
        frame = CGRectMake(messageFrame.origin.x,messageFrame.origin.y+messageFrame.size.height+PADDING, width, lineHeight);
        
    }else if(align == ALIGN_TO_BOTTOM_RIGHT_MESSAGE){
        
        CGRect messageFrame = [self frameForMessage];
        frame = CGRectMake(messageFrame.origin.x+messageFrame.size.width-width, messageFrame.origin.y+messageFrame.size.height+PADDING, width, lineHeight);
        
    }
    return frame;
}
@end
