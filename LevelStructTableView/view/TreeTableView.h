//
//  TreeTableView.h
//  LevelStructTableView
//
//  Created by Shuai Zhu on 2020/8/13.
//  Copyright © 2020 Shuai Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Node;

@protocol TreeTableCellDelegate <NSObject>

-(void)cellClick : (Node *)node;

@end

@interface TreeTableView : UITableView

@property (nonatomic , weak) id<TreeTableCellDelegate> treeTableCellDelegate;

-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data;

@end

NS_ASSUME_NONNULL_END
