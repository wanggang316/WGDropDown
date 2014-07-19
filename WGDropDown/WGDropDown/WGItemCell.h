//
//  WGItemCell.h
//  WGDropDown
//
//  Created by 王刚 on 14/7/18.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGItem;
@interface WGItemCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;

- (void)configureItem:(WGItem *)item;

@end
