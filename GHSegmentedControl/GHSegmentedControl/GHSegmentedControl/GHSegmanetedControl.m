//
//  GHSegmanetedControl.m
//  GHSegmentedControl
//
//  Created by Gegham Harutyunyan on 9/7/14.
//  Copyright (c) 2014 WAY4APP. All rights reserved.
//

#import "GHSegmanetedControl.h"
#import "UIView+Frame.h"

#define kDefaultFontSize    ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )?12:24
#define kDefaultFont        [UIFont systemFontOfSize:kDefaultFontSize]
#define kDefaultSelecteLabelTextColor [UIColor whiteColor]
#define kDefaultUnselecteLabelTextColor [UIColor lightGrayColor]

@implementation GHSegmanetedControl
{
    //View
    UIView *movableView;
    
    //Created Labels Array
    NSMutableArray *labelsArray;
}

#pragma mark - Init -
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self defaultPreparation];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self defaultPreparation];
    }
    return self;
}

-(void) defaultPreparation
{
    //Init Arrays
    labelsArray = [NSMutableArray array];
    
    //Self
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 1.0;
    _borderColor = [UIColor colorWithRed:64/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.masksToBounds = YES;
    
    //Font
    _segmentFont = kDefaultFont;
    
    //Label
    _selectedLabelTextColor = kDefaultSelecteLabelTextColor;
    _unselectedLabelTextColor = kDefaultUnselecteLabelTextColor;
    
    //View
    movableView = [[UIView alloc] init];
    movableView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:movableView];
}



#pragma mark - Data Setters

- (void) setElements:(NSArray *)elements
{
    //Reset Labels Array
    for (UILabel *label in labelsArray)
    {
        [label removeFromSuperview];
    }
    [labelsArray removeAllObjects];
    
    _elements = elements;
    
    for (int i =0; i < elements.count; i++)
    {
        UILabel *label = [[UILabel alloc] init];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = _unselectedLabelTextColor;
        label.font = _segmentFont;
        label.minimumScaleFactor = 0.5;
        label.adjustsFontSizeToFitWidth = YES;
        label.backgroundColor = [UIColor clearColor];
        
        label.width = self.width/elements.count;
        label.height = self.height;
        label.x = i*(self.width/elements.count);
        
        label.text = elements[i];
        [self addSubview:label];
        
        [labelsArray addObject:label];
    }
    
    [self resizeLabelsIfNeeded];
    
    [self setNeedsDisplay];
}

- (void) setSegmentFont:(UIFont *)segmentFont
{
    _segmentFont = segmentFont;
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    //Add Movable view to selected label
    UILabel *label = labelsArray[selectedIndex];
    label.textColor = _selectedLabelTextColor;
    movableView.frame = label.frame;
}

- (void) setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}

- (void) setBorderRadius:(CGFloat)borderRadius
{
    self.layer.cornerRadius = borderRadius;
}

- (void) setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void) setSelectedLabelTextColor:(UIColor *)selectedLabelTextColor
{
    _selectedLabelTextColor = selectedLabelTextColor;
}

- (void) setUnselectedLabelTextColor:(UIColor *)unselectedLabelTextColor
{
    _unselectedLabelTextColor = unselectedLabelTextColor;
}

- (void) setMovableViewColor:(UIColor *)movableViewColor
{
    movableView.backgroundColor = movableViewColor;
}

- (void) resizeLabelsIfNeeded
{
    NSMutableArray *largeLabels = [NSMutableArray array];
    NSMutableArray *smallLabels = [NSMutableArray array];
    
    CGFloat freeSpace = 0.0;
    CGFloat neededSpace = 0.0;
    //Find large and small spaces
    for (int i = 0; i < labelsArray.count; i++)
    {
        UILabel *label = labelsArray[i];
        CGSize labelSize = [label.text sizeWithFont:_segmentFont];
        
        if (labelSize.width > label.width)
        {
            [smallLabels addObject:label];
            neededSpace = labelSize.width - label.width;
        }
        else if (labelSize.width < label.width)
        {
            [largeLabels addObject:label];
            freeSpace += label.width - labelSize.width;
            
            //Reduce large label's width
            label.width = labelSize.width;
        }
    }
    
    //If we have enough free space
    if(freeSpace >= neededSpace)
    {
        //Add space to small labels
        for (int i = 0; i < smallLabels.count; i++)
        {
            UILabel *label = smallLabels[i];
            CGSize labelSize = [label.text sizeWithFont:_segmentFont];
            
            freeSpace -= labelSize.width - label.width;
            label.width = labelSize.width;
        }
        
        //If we still have free space add on all labels
        for (int i = 0; i < labelsArray.count; i++)
        {
            UILabel *label = labelsArray[i];
            label.width += freeSpace/labelsArray.count;
        }
        
        [self correctLabelsXpositions];
        
        freeSpace = 0.0;
        neededSpace = 0.0;
        
    }
    else //If we haven't enough free space
    {
        //reset FreeSpace and NeededSapce
        freeSpace = 0.0;
        neededSpace = 0.0;
        
        //Get most smaller label
        UILabel *smallerLabel;
        CGFloat scalePercentage = 100.0;//100 means that the label is not small
        for (int i = 0; i < smallLabels.count; i++)
        {
            UILabel *label = smallLabels[i];
            CGFloat currentLabelScalePercentage = [self getScalePercentage:label];
            if (scalePercentage > currentLabelScalePercentage)
            {
                scalePercentage = currentLabelScalePercentage;
                smallerLabel = label;
            }
        }
        
        //There we have smallest label
        //We are going to reduce all labels to this label size
        CGFloat fullLengthOfLabels = 0.0;
        for (int i = 0; i < labelsArray.count; i++)
        {
            UILabel *label = labelsArray[i];
            CGSize labelSize = [label.text sizeWithFont:_segmentFont];
            label.width = (scalePercentage * labelSize.width)/100.0;
            
            //Add free space
            fullLengthOfLabels += label.width;
        }
        
        //Get free space in this situation
        freeSpace = self.width - fullLengthOfLabels;
        
        //Add the resulting free space on all labels
        for (int i = 0; i < labelsArray.count; i++)
        {
            UILabel *label = labelsArray[i];
            label.width += freeSpace/labelsArray.count;
        }
        
        [self correctLabelsXpositions];
        
        freeSpace = 0.0;
    }
}

- (void) correctLabelsXpositions
{
    CGFloat xOfNextLabel = 0.0;
    for (int i = 0; i < labelsArray.count; i++)
    {
        UILabel *label = labelsArray[i];
        label.x = xOfNextLabel;
        xOfNextLabel += label.width;
    }
}

#pragma mark - Touch

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch= [touches anyObject];
    for (int i = 0; i < labelsArray.count; i++)
    {
        UILabel *label = labelsArray[i];
        CGPoint touchLocation = [touch locationInView:self];

        if (CGRectContainsPoint(label.frame, touchLocation))
        {
            label.textColor = _selectedLabelTextColor;
            _selectedIndex = i;
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            
            [UIView animateWithDuration:0.3 animations:^{
                movableView.frame = label.frame;
            }];
            
            
        }
        else
        {
            if (CGRectContainsPoint(self.bounds, touchLocation))
            {
                label.textColor = _unselectedLabelTextColor;
            }
        }
    }
}

#pragma mark - Helpers

- (CGFloat) getScalePercentage:(UILabel *) label
{
    CGFloat scalePercentage;
    CGSize labelSize = [label.text sizeWithFont:_segmentFont];
    scalePercentage = (label.width*100.0)/labelSize.width;
    
    return scalePercentage;
}

#pragma mark - Draw

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat xOfNextLine = 0.0f;
    for (int i = 0; i < labelsArray.count - 1; i++)
    {
        UILabel *label = labelsArray[i];
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
        CGContextMoveToPoint(context,xOfNextLine + label.width, 0);
        
        //Vertical Line
        CGContextAddLineToPoint(context,xOfNextLine + label.width, self.height);
        CGContextStrokePath(context);
        
        //Add labels width for nex line
        xOfNextLine += label.width;
    }
}


@end
