//
//  UIView+Extension.m
//  mvvm
//
//  Created by timbao on 15/4/24.
//  Copyright (c) 2015年 szzc. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (UCAR)

-(void)setHiddenAnimated:(BOOL)hide
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         if (hide)
         {
             self.alpha = 0;
         }
         else
         {
             self.hidden = NO;
             self.alpha = 1;
         }
     }
     completion:^(BOOL b)
     {
         if (hide)
             self.hidden= YES;
     }
     ];
}

@end
