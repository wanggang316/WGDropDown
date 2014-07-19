//
//  WGItemCell.m
//  WGDropDown
//
//  Created by 王刚 on 14/7/18.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGItemCell.h"
#import "WGItem.h"

@implementation WGItemCell

- (void)configureItem:(WGItem *)item {
    self.titleLabel.text = item.itemTitle;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
         [self.contentView addSubview:self.titleLabel];
    }
   
    return _titleLabel;
}

@end
