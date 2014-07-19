//
//  WGItem.h
//  WGDropDown
//
//  Created by 王刚 on 14/7/18.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGItem : NSObject

@property (strong, nonatomic, readonly) NSString *itemId;
@property (strong, nonatomic, readonly) NSString *itemTitle;

- (id)initWithItemId:(NSString *)aItemId
           itemTitle:(NSString *)aItemTitle;
@end
