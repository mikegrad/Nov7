//
//  View1.h
//  Nov7
//
//  Created by Michael Gradilone on 11/7/13.
//  Copyright (c) 2013 FintechSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View1 : UIView {
    
    UISlider *slider;
	UILabel *label;
    UISegmentedControl *control;
    
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *control;


@end
