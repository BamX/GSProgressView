//
//  GSViewController.m
//  GSProgressViewDemo
//
//  Created by Simon Whitaker on 25/11/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import "GSViewController.h"

@interface GSViewController ()

@end

@implementation GSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    sranddev();

    float x = 1.0;
    for (GSProgressView *progressView in self.progressViews)
    {
        UIColor *color = [UIColor colorWithHue:0.0
                                    saturation:x
                                    brightness:x
                                         alpha:1.0];
        progressView.color = color;
        x -= 0.1;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setProgress:nil];
}

- (void)setProgress:(id)sender
{
    for (GSProgressView *progressView in self.progressViews) {
        progressView.progress = self.slider.value;
    }
}

@end
