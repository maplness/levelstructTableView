//
//  Node.m
//  LevelStructTableView
//
//  Created by Shuai Zhu on 2020/8/13.
//  Copyright © 2020 Shuai Zhu. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithParentId : (int)parentId nodeId : (int)nodeId name : (NSString *)name{
    self = [self init];
    if (self) {
        self.parentId = parentId;
        self.nodeId = nodeId;
        self.name = name;
    }
    return self;
}

@end
