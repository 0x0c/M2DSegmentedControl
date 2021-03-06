//
//  M2DSegmentedControl.m
//  M2DSegmentedControl
//
//  Created by Akira Matsuda on 5/14/16.
//  Copyright © 2016 Akira Matsuda. All rights reserved.
//

#import "M2DSegmentedControl.h"

@interface M2DSegmentedControlBadgeView ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation M2DSegmentedControlBadgeView


CGFloat badgeSize = 20;
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title
{
	self = [self initWithFrame:CGRectMake(-badgeSize / 2.0 + index * 15, -badgeSize / 2.0, badgeSize, badgeSize)];
	self.index = index;
	self.title = title;
	
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.layer.cornerRadius = CGRectGetWidth(frame) / 2.0;
		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
		self.titleLabel.font = [UIFont systemFontOfSize:13];
		[self addSubview:self.titleLabel];
	}
	
	return self;
}

- (void)setTitle:(NSString *)title
{
	self.titleLabel.text = title;
	if (self.titleLabel.text.length > 0) {
		[self sizeToFit];
	}
	else {
		self.hidden = YES;
	}
}

- (void)sizeToFit
{
	[super sizeToFit];
	[self.titleLabel sizeToFit];
	CGFloat size = CGRectGetWidth(self.titleLabel.frame) > badgeSize ? CGRectGetWidth(self.titleLabel.frame) + 10 : badgeSize;
	self.frame = CGRectMake(0, 0, size, badgeSize);
	UISegmentedControl * _Nullable segmentedControl = (UISegmentedControl * _Nullable)self.segmentedControl;
	if (segmentedControl) {
		NSInteger offset = self.badgeAlignmnet == M2DSegmentedControlBadgeAlignmentLeft ? 0 : 1;
		self.center = CGPointMake((self.index + offset) * CGRectGetWidth(segmentedControl.frame) / segmentedControl.numberOfSegments + CGRectGetMinX(self.segmentedControl.frame), CGRectGetMinY(self.segmentedControl.frame));
	}
	self.titleLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0);
}

- (NSString *)title
{
	return self.titleLabel.text;
}

- (void)setBadgeAlignmnet:(M2DSegmentedControlBadgeAlignment)badgeAlignmnet
{
	_badgeAlignmnet = badgeAlignmnet;
	[self sizeToFit];
}

- (void)setTextColor:(UIColor *)textColor
{
	self.titleLabel.textColor = textColor;
}

- (UIColor *)textColor
{
	return self.titleLabel.textColor;
}

@end

@interface M2DSegmentedControl ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, M2DSegmentedControlBadgeView *> *badgeViews;

@end

@implementation M2DSegmentedControl

- (instancetype)initWithItems:(NSArray *)items
{
	self = [super initWithItems:items];
	if (self) {
		self.badgeViews = [NSMutableDictionary new];
		[self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
		[self setBadgeBackgroundColor:[UIColor redColor]];
		[self setBadgeTextColor:[UIColor whiteColor]];
	}
	
	return self;
}

- (void)setBadgeBorderWidth:(CGFloat)badgeBorderWidth
{
	_badgeBorderWidth = badgeBorderWidth;
	[self.badgeViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, M2DSegmentedControlBadgeView * _Nonnull obj, BOOL * _Nonnull stop) {
		obj.layer.borderWidth = badgeBorderWidth;
	}];
}

- (void)setBadgeBorderColor:(UIColor *)badgeBorderColor
{
	_badgeBorderColor = badgeBorderColor;
	[self.badgeViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, M2DSegmentedControlBadgeView * _Nonnull obj, BOOL * _Nonnull stop) {
		obj.layer.borderColor = badgeBorderColor.CGColor;
	}];
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
	_badgeBackgroundColor = badgeBackgroundColor;
	[self.badgeViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, M2DSegmentedControlBadgeView * _Nonnull obj, BOOL * _Nonnull stop) {
		obj.backgroundColor = badgeBackgroundColor;
	}];
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
	_badgeTextColor = badgeTextColor;
	[self.badgeViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, M2DSegmentedControlBadgeView * _Nonnull obj, BOOL * _Nonnull stop) {
		obj.textColor = badgeTextColor;
	}];
}

- (void)setBadgeAlignmnet:(M2DSegmentedControlBadgeAlignment)badgeAlignmnet
{
	_badgeAlignmnet = badgeAlignmnet;
	[self.badgeViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, M2DSegmentedControlBadgeView * _Nonnull obj, BOOL * _Nonnull stop) {
		obj.badgeAlignmnet = badgeAlignmnet;
	}];
}

- (void)addBadgeViewWithTitle:(NSString *)title index:(NSInteger)index
{
	M2DSegmentedControlBadgeView *view = self.badgeViews[@(index)];
	
	if (view == nil) {
		view = [[M2DSegmentedControlBadgeView alloc] initWithIndex:index title:title];
		self.badgeViews[@(index)] = view;
		view.segmentedControl = self;
		[self setBadgeAlignmnet:self.badgeAlignmnet];
		[self setBadgeTextColor:self.badgeTextColor];
		[self setBadgeBorderColor:self.badgeBorderColor];
		[self setBadgeBorderWidth:self.badgeBorderWidth];
		[self setBadgeBackgroundColor:self.badgeBackgroundColor];
		[self.superview addSubview:view];
	}
	
	view.title = title;
}

- (void)badgeViewsHidden:(BOOL)hidden
{
	[self.badgeViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, M2DSegmentedControlBadgeView * _Nonnull obj, BOOL * _Nonnull stop) {
		obj.hidden = hidden;
		[obj sizeToFit];
	}];
}

- (void)valueChanged:(id)sender
{
	[self.badgeViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, M2DSegmentedControlBadgeView * _Nonnull obj, BOOL * _Nonnull stop) {
		[self.superview addSubview:obj];
		[obj sizeToFit];
	}];
}

@end
