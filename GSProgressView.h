//
//  GSProgressView.h
//
//  Created by Simon Whitaker on 14/11/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSProgressView : UIView

@property (nonatomic) CGFloat progress;
@property (strong, nonatomic) UIColor *color UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *tickColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, getter=isDoneIconHidden) BOOL doneIconHidden;
@property (nonatomic, getter=isFailure) BOOL failure;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
