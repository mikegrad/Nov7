//
//  View1.m
//  Nov7
//
//  Created by Michael Gradilone on 11/7/13.
//  Copyright (c) 2013 FintechSolutions. All rights reserved.
//

#import "View1.h"
#import "Nov7AppDelegate.h"

//Macro to convert fahrenheit to celsius.
#define CELSIUS(fahrenheit) (((fahrenheit) - 32.0) * 100 / (212 - 32))

@implementation View1

@synthesize control;

#define XPERCENT .10
#define YPERCENT .10

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	
    if (self) {
        
        //segmented control
        NSArray *items = [NSArray arrayWithObjects:
                          @"Video",
                          @"Audio",
                          nil
                          ];
        
        control = [[UISegmentedControl alloc] initWithItems: items];
		control.momentary = YES;
        
		//Can't play until we have recorded something.
		//[control setEnabled: YES forSegmentAtIndex: 0];
        
		//Center the control in the SegmentedView.
		CGRect b = self.bounds;
        
		control.center = CGPointMake(
                                     b.origin.x + b.size.width / 4,
                                     b.origin.y + (b.size.height - (YPERCENT * b.size.height)) + 10
                                     );
        
		[control addTarget: [UIApplication sharedApplication].delegate
                    action: @selector(valueChanged:)
          forControlEvents: UIControlEventValueChanged
         ];
        
		[self addSubview: control];
        
		self.backgroundColor = [UIColor whiteColor];
		float minimumValue = 0 ;	//freezing point of water in Fahrenheit
		float maximumValue = 100;
        

		CGSize s = CGSizeMake(maximumValue - minimumValue, 16);
        
		CGRect f = CGRectMake(
                              b.origin.x + (b.size.width - s.width) - (b.size.width * XPERCENT),
                              b.origin.y + (b.size.height - (YPERCENT * b.size.height))  ,
                              s.width,
                              s.height
                              );
        
		slider = [[UISlider alloc] initWithFrame: f];
		slider.minimumValue = minimumValue;
		slider.maximumValue = maximumValue;
		slider.value = 100;
		slider.continuous = YES;
        
        
        
		[slider addTarget: [UIApplication sharedApplication].delegate
                   action: @selector(valueChanged:)
         forControlEvents: UIControlEventValueChanged];

		[self addSubview: slider];
        
	}
	return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
