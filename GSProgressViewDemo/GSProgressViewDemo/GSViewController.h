//
//  GSViewController.h
//  GSProgressViewDemo
//
//  Created by Simon Whitaker on 25/11/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSProgressView.h"

@interface GSViewController : UIViewController

@property (nonatomic, strong) IBOutletCollection(GSProgressView) NSArray *progressViews;
@property (nonatomic, weak) IBOutlet UISlider *slider;
- (IBAction)setProgress:(id)sender;

@end
