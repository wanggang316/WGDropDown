//
//  WGDropDownView.h
//  WGDropDown
//
//  Created by 王刚 on 14/7/17.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGDropDownViewDelegate <NSObject>

-(void)didSelectedAtIndex:(NSInteger)index;

@end

@interface WGDropDownView : UIView
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id)delegate displayView:(UIView *)displayView isNavigationView:(BOOL)flag;
@end


