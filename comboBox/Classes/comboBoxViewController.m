//
//  comboBoxViewController.m
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "comboBoxViewController.h"

@implementation comboBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSArray *comboBoxDatasource = [[NSArray alloc] initWithObjects:@"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight", nil];
	_comboBox = [[ComboBoxView alloc] initWithFrame:CGRectMake(20, 20, 280, 140)];
	_comboBox.comboBoxDatasource = comboBoxDatasource;
	_comboBox.backgroundColor = [UIColor clearColor];
	[_comboBox setContent:[comboBoxDatasource objectAtIndex:0]];
	[self.view addSubview:_comboBox];
	[_comboBox release];
	[comboBoxDatasource release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}

@end
