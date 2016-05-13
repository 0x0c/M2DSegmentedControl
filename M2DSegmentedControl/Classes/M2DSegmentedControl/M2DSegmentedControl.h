//
//  M2DSegmentedControl.h
//  M2DSegmentedControl
//
//  Created by Akira Matsuda on 5/14/16.
//  Copyright © 2016 Akira Matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, M2DSegmentedControlBadgeAlignment) {
	M2DSegmentedControlBadgeAlignmentLeft = 0,
	M2DSegmentedControlBadgeAlignmentRight = 1
};

@class M2DSegmentedControl;

@interface M2DSegmentedControlBadgeView : UIView

@property (nonatomic, weak) M2DSegmentedControl *segmentedControl;
@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) M2DSegmentedControlBadgeAlignment badgeAlignmnet;

- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title;

@end

@interface M2DSegmentedControl : UISegmentedControl

@property (nonatomic, assign) M2DSegmentedControlBadgeAlignment badgeAlignmnet;
@property (nonatomic, assign) CGFloat badgeBorderWidth;
@property (nonatomic, strong) UIColor *badgeBorderColor;
@property (nonatomic, strong) UIColor *badgeBackgroundColor;
@property (nonatomic, strong) UIColor *badgeTextColor;

- (void)addBadgeViewWithTitle:(NSString *)title index:(NSInteger)index;

@end
