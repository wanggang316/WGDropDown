//
//  WGItem.m
//  WGDropDown
//
//  Created by 王刚 on 14/7/18.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGItem.h"

@interface WGItem()

@property (strong, nonatomic, readwrite) NSString *itemId;
@property (strong, nonatomic, readwrite) NSString *itemTitle;

@end

@implementation WGItem


- (id)initWithItemId:(NSString *)aItemId
           itemTitle:(NSString *)aItemTitle {
    if (self = [super init]) {
        self.itemId = [aItemId copy];
        self.itemTitle = [aItemTitle copy];
    }
    return self;
}

@end
