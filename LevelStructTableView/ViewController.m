//
//  ViewController.m
//  LevelStructTableView
//
//  Created by Shuai Zhu on 2020/8/13.
//  Copyright © 2020 Shuai Zhu. All rights reserved.
//

#import "ViewController.h"
#import "Node.h"
#import "TreeTableView.h"

@interface ViewController ()<TreeTableCellDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
}

-(void)initData{

    Node *country1 = [[Node alloc] initWithParentId:-1 nodeId:0 name:@"总经理室" ];
    Node *province1 = [[Node alloc] initWithParentId:0 nodeId:1 name:@"部长1室" ];
    Node *city1 = [[Node alloc] initWithParentId:1 nodeId:2 name:@"小兵A" ];
    Node *city2 = [[Node alloc] initWithParentId:1 nodeId:3 name:@"小兵B" ];
    Node *city3 = [[Node alloc] initWithParentId:1 nodeId:4 name:@"小兵C" ];
    Node *province2 = [[Node alloc] initWithParentId:0 nodeId:5 name:@"部长2室" ];
    Node *city4 = [[Node alloc] initWithParentId:5 nodeId:6 name:@"小兵D" ];
    Node *city5 = [[Node alloc] initWithParentId:5 nodeId:7 name:@"小兵E" ];
    Node *province3 = [[Node alloc] initWithParentId:0 nodeId:8 name:@"部长3室" ];
    Node *city6 = [[Node alloc] initWithParentId:8 nodeId:9 name:@"小兵F" ];
    NSArray *data = [NSArray arrayWithObjects:country1,province1,city1,city2,city3,province2,city4,city5,province3,city6, nil];
    
    
    TreeTableView *tableview = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20) withData:data];
    tableview.treeTableCellDelegate = self;
    [self.view addSubview:tableview];
}

#pragma mark - TreeTableCellDelegate
-(void)cellClick:(Node *)node{
    NSLog(@"%@",node.name);
}

@end
