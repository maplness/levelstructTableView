//
//  TreeTableView.m
//  LevelStructTableView
//
//  Created by Shuai Zhu on 2020/8/13.
//  Copyright © 2020 Shuai Zhu. All rights reserved.
//

#import "TreeTableView.h"
#import "Node.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface TreeTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) NSArray *data;//传递过来已经组织好的数据（全量数据）

@property (nonatomic , strong) NSMutableArray *tempData;//用于存储数据源（部分数据）

@property (nonatomic , strong , readwrite) NSMutableArray *navArray;


@end

@implementation TreeTableView

-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _data = data;
        _tempData = [self createTempData:data];
    }
    return self;
}

/**
 * 初始化数据源
 */
-(NSMutableArray *)createTempData : (NSArray *)data{
    NSMutableArray *tempArray = [NSMutableArray array];
    Node *node = [_data objectAtIndex:0];
    [tempArray addObject:node];
    //初始化navArray
    _navArray = [NSMutableArray array];
    
    return tempArray;
}


#pragma mark - UITableViewDataSource

#pragma mark - Required

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *NODE_CELL_ID = @"node_cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
    }
    
    Node *node = [_tempData objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = node.name;
    
    return cell;
}


#pragma mark - Optional


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - UITableViewDelegate

#pragma mark - Optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //先修改数据源
    Node *parentNode = [_tempData objectAtIndex:indexPath.row];
    if (_treeTableCellDelegate && [_treeTableCellDelegate respondsToSelector:@selector(cellClick:)]) {
        [_treeTableCellDelegate cellClick:parentNode];
    }
    
    [_navArray addObject:parentNode];
    
    [_tempData removeAllObjects];
    for (int i=0; i<_data.count; i++) {
        Node *node = [_data objectAtIndex:i];
        if (node.parentId == parentNode.nodeId) {
            [_tempData addObject:node];
        }
    }
    [self reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 50)];
//    headerView.backgroundColor = [UIColor redColor];
    float offset = 0;
    NSInteger i = 0;
    for (Node *node in _navArray) {
        //如果是第一个不创建箭头
        UILabel *curLable = [[UILabel alloc] initWithFrame:CGRectZero];
        curLable.text = node.name;
        [curLable sizeToFit];
        [curLable setTag:i];
        curLable.frame = CGRectMake(offset + 20, 10, curLable.frame.size.width, curLable.frame.size.height);
        offset += curLable.frame.size.width + 50;
        [headerView addSubview:curLable];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        [curLable addGestureRecognizer:recognizer];
        curLable.userInteractionEnabled = YES;
        i++;
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0;
}

-(void)labelClick:(UITapGestureRecognizer *)recognizer{
    
    UIView *view = recognizer.view;
    NSInteger index = view.tag;
    if (!(index == _navArray.count - 1)) {
        Node *curNode = _navArray[index];
        [_tempData removeAllObjects];
        for (int i=0; i<_data.count; i++) {
                Node *node = [_data objectAtIndex:i];
                if (node.parentId == curNode.nodeId) {
                    [_tempData addObject:node];
                }
            }
        for (int i = (int)_navArray.count - 1; i >= 0 ; i--) {
            if (i > index) {
                [_navArray removeObjectAtIndex:i];
            }
        }
        [self reloadData];
    }
    NSLog(@"点击label:%@",recognizer.view);
}

@end
