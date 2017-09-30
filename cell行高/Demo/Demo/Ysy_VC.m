//
//  Ysy_VC.m
//  Demo
//
//  Created by Runa on 2017/9/29.
//  Copyright © 2017年 forkingdog. All rights reserved.
//

#import "Ysy_VC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Ysy_Cell.h"
#import "KeFuAddImg_Cell.h"
@interface Ysy_VC ()
@property NSMutableArray *dataArr;
@end

@implementation Ysy_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr =  [NSMutableArray arrayWithObjects:@"评论评论评论评论评论评论1"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论2"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评3"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论4"
                 ,@"评论评论评论评论评论评论5"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论6"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论7"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论8"
                 ,@"评论评论评论评论评论评论9"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论10"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论11"
                 ,@"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论12", nil];

//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 100;
//    [self.tableView registerNib:[UINib nibWithNibName:@"Ysy_Cell" bundle:nil] forCellReuseIdentifier:@"re"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KeFuAddImg_Cell" bundle:nil] forCellReuseIdentifier:@"KeFuAddImg_Cell"];
    [self.tableView reloadData];

}
- (IBAction)pop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0)
//    {
        KeFuAddImg_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"KeFuAddImg_Cell"];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
//    }
//    Ysy_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"re"];
//    [self configureCell:cell atIndexPath:indexPath];
//    return cell;
}
- (void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0)
//    {
    
        KeFuAddImg_Cell *cell1 = cell;
        cell1.RefreshBlock = ^{
            NSLog(@"1111111");
            [self.tableView reloadData];
        };
//    }
//    else
//    {
//        NSLog(@"222222222");
//        Ysy_Cell *cell2 = cell;
//        cell2.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//        if (indexPath.row % 2 == 0) {
//            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        else
//        {
//            cell2.accessoryType = UITableViewCellAccessoryNone;
//        }
//        cell2.selectionStyle =  UITableViewCellSelectionStyleNone;
//        cell2.contentLab.text = _dataArr[indexPath.row];
//    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    return [tableView fd_heightForCellWithIdentifier:@"re" cacheByIndexPath:indexPath configuration:^(id cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
    
    return [tableView ysy_heightForCellWithIdentifier:@"KeFuAddImg_Cell" cacheByIndexPath:indexPath configuration:^(id cell) {
       [self configureCell:cell atIndexPath:indexPath];
    }];
}
@end
