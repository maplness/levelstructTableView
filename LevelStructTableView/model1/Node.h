//
//  Node.h
//  LevelStructTableView
//
//  Created by Shuai Zhu on 2020/8/13.
//  Copyright © 2020 Shuai Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  每个节点类型
 */
@interface Node : NSObject

@property (nonatomic , assign) int parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) int nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称


/**
 *快速实例化该对象模型
 */
- (instancetype)initWithParentId : (int)parentId nodeId : (int)nodeId name : (NSString *)name;

@end

NS_ASSUME_NONNULL_END
