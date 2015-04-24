//
//  UCarButton.h
//  mvvm
//
//  Created by timbao on 15/4/24.
//  Copyright (c) 2015年 szzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarButton : UIButton

@property (nonatomic, copy) NSString *name;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (UIColor *)backgroundColorForState:(UIControlState)state;

@end
