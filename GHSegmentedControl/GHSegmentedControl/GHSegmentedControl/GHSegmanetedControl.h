//
//  GHSegmanetedControl.h
//  GHSegmentedControl
//
//  Created by Gegham Harutyunyan on 9/7/14.
//  Copyright (c) 2014 WAY4APP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHSegmanetedControl : UIControl

@property(nonatomic, strong) UIFont *segmentFont;
@property(nonatomic, strong) NSArray *elements;// of type NSStrings
@property(nonatomic) NSInteger selectedIndex;

//Self view
@property(nonatomic, strong) UIColor *borderColor;
@property(nonatomic) CGFloat borderRadius;
@property(nonatomic) CGFloat borderWidth;

//Label
@property(nonatomic, strong) UIColor *selectedLabelTextColor;
@property(nonatomic, strong) UIColor *unselectedLabelTextColor;

//Movable View
@property(nonatomic, strong) UIColor *movableViewColor;

@end
