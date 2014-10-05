//
//  UIView+Frame.h
//  TruthOrDare Party
//
//  Created by Gegham Harutyunyan on 06/26/14.
//  Copyright (c) 2014 WAY4APP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat xRight;
@property (nonatomic, assign) CGFloat yBottom;


-(void) sizeToFitSubviews;


@end
