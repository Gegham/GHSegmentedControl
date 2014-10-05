//
//  ViewController.m
//  GHSegmentedControl
//
//  Created by Gegham Harutyunyan on 10/5/14.
//  Copyright (c) 2014 WAY4APP. All rights reserved.
//

#import "ViewController.h"
#import "GHSegmanetedControl.h"

@interface ViewController ()

@end

@implementation ViewController
{
    IBOutlet GHSegmanetedControl *segmentControl_1;
    IBOutlet GHSegmanetedControl *segmentControl_2;
    IBOutlet GHSegmanetedControl *segmentControl_3;
    IBOutlet GHSegmanetedControl *segmentControl_4;
    IBOutlet GHSegmanetedControl *segmentControl_5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //************* Create *************//
    segmentControl_1.elements = @[@"element_1", @"ele_2", @"element3"];
    segmentControl_1.selectedIndex = 0;
    
    //************* Create *************//
    segmentControl_2.segmentFont = [UIFont fontWithName:@"HelveticaNeue-Light" size: 16.];
    segmentControl_2.elements = @[@"ele_1", @"element_long_2"];
    segmentControl_2.selectedIndex = 0;
    
    //************* Create *************//
    segmentControl_3.segmentFont = [UIFont fontWithName:@"HelveticaNeue-Light" size: 16.];
    segmentControl_3.movableViewColor = [UIColor colorWithRed:64/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    segmentControl_3.elements = @[@"element_1", @"element_long_2", @"ele_3", @"ele_4"];
    segmentControl_3.selectedIndex = 0;
    
    //************* Create *************//
    segmentControl_4.segmentFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 16.];
    segmentControl_4.backgroundColor = [UIColor redColor];
    segmentControl_4.unselectedLabelTextColor = [UIColor whiteColor];
    segmentControl_4.borderColor = [UIColor blackColor];
    segmentControl_4.borderRadius = 3.;
    segmentControl_4.movableViewColor = [UIColor colorWithRed:64/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    segmentControl_4.elements = @[@"element_1", @"element_long_2", @"ele_3", @"element_long_4"];
    segmentControl_4.selectedIndex = 0;
    
    //************* Create *************//
    segmentControl_5.segmentFont = [UIFont fontWithName:@"HelveticaNeue-Light" size: 16.];
    segmentControl_5.movableViewColor = [UIColor colorWithRed:64/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    segmentControl_5.elements = @[@"element_long_1", @"element_long_2", @"ele_3", @"element_4"];
    segmentControl_5.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
