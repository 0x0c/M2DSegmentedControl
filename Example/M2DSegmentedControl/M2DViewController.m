//
//  M2DViewController.m
//  M2DSegmentedControl
//
//  Created by Akira Matsuda on 05/14/2016.
//  Copyright (c) 2016 Akira Matsuda. All rights reserved.
//

#import "M2DViewController.h"
#import "M2DSegmentedControl.h"

@interface M2DViewController ()

@end

@implementation M2DViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	M2DSegmentedControl *segmentedControl = [[M2DSegmentedControl alloc] initWithItems:@[@"A", @"B", @"C"]];
	segmentedControl.frame = CGRectMake(0, 0, 200, CGRectGetHeight(segmentedControl.frame));
	segmentedControl.center = self.view.center;
	[self.view addSubview:segmentedControl];
	[segmentedControl setSelectedSegmentIndex:0];
	segmentedControl.badgeAlignmnet = M2DSegmentedControlBadgeAlignmentRight;
	segmentedControl.badgeBorderColor = [UIColor whiteColor];
	segmentedControl.badgeBorderWidth = 1;
	[segmentedControl addBadgeViewWithTitle:@"hoge" index:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
