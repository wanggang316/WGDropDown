//
//  WGDropDownView.m
//  WGDropDown
//
//  Created by 王刚 on 14/7/17.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGDropDownView.h"
#import "WGTableViewDataSource.h"
#import "WGItemCell.h"
#import "WGItem.h"

#define TITLE_BTN_TAG   1000
#define DROP_INDICATOR  2000

#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

static NSString *const ItemIdentifier = @"ItemIdentifier";
static CGFloat const CellHeight = 40;   //cell行高

@interface WGDropDownView() <UITableViewDelegate>
{
    BOOL isHidden;
    BOOL isNavigationView;
}

@property (weak, nonatomic) id<WGDropDownViewDelegate> dropDownDelegate;

@property (strong, nonatomic) WGTableViewDataSource *tableViewDataSource;
@property (strong, nonatomic) UITableView *itemTableView;
@property (strong, nonatomic) NSArray *items;

@property (strong, nonatomic) UIView *tableContainerView;

@property (strong, nonatomic) UIView *displayView;


@end

@implementation WGDropDownView

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id)delegate displayView:(UIView *)displayView isNavigationView:(BOOL)flag {
    
    if (!items) {
        return nil;
    }
    
    if (self = [super initWithFrame:frame]) {
        
        self.items = items;
        self.dropDownDelegate = delegate;
        self.displayView = displayView;
        isHidden = YES;
        isNavigationView = flag;
        
        
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        titleBtn.tag = TITLE_BTN_TAG;
        
        [titleBtn addTarget:self action:@selector(tapTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        WGItem *item = self.items[0];
        NSString *sectionBtnTitle = item.itemTitle;
        
        [titleBtn  setTitle:sectionBtnTitle forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [self addSubview:titleBtn];
        //初始化指示图片
        UIImageView *indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 16, (self.frame.size.height-12)/2, 12, 8)];
        indicatorImageView.image = [UIImage imageNamed:@"drop_indicator.png"];
        [indicatorImageView setContentMode:UIViewContentModeScaleToFill];
        indicatorImageView.tag = DROP_INDICATOR;
        [self addSubview: indicatorImageView];
        
    }
    
    
    return self;
}


- (void)tapTitleBtn:(UIButton *)btn {
    if (isHidden) {
        [self showListView];
    } else {
        [self hiddenListView];
    }
}


- (void)showListView {
    
    isHidden = NO;

    
    if (!self.itemTableView) {
        
        //设置tableview的容器视图
        self.tableContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y + self.frame.size.height , self.displayView.frame.size.width, self.displayView.frame.size.height - self.frame.origin.y - self.frame.size.height)];
        self.tableContainerView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContainerView:)];
        [self.tableContainerView addGestureRecognizer:bgTap];
        
        
        //设置tableView
        self.itemTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, (isNavigationView ? 64. : self.frame.origin.y + self.frame.size.height), self.frame.size.width, CellHeight * self.items.count)];
        self.itemTableView.delegate = self;
        [self.itemTableView registerClass:[WGItemCell class] forCellReuseIdentifier:ItemIdentifier];

        
        TableViewCellConfigureBlock configureBlock = ^(WGItemCell *cell, WGItem *item) {
            [cell configureItem:item];
        };
        
        self.tableViewDataSource = [[WGTableViewDataSource alloc]initWithItems:self.items cellIdentifier:ItemIdentifier configureCellBlock:configureBlock];
        
        
        self.itemTableView.dataSource = self.tableViewDataSource;
    }
    
    
    //修改tableview的height
    CGRect rect = self.itemTableView.frame;
    rect.size.height = 0;
    self.itemTableView.frame = rect;
    
    [self.displayView addSubview:self.tableContainerView];
    [self.displayView addSubview:self.itemTableView];
    
    
    //动画设置位置
    rect .size.height = CellHeight * self.items.count;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableContainerView.alpha = 0.2;
        self.itemTableView.alpha = 0.2;
        
        self.tableContainerView.alpha = 1.0;
        self.itemTableView.alpha = 1.0;
        self.itemTableView.frame =  rect;
    }];
    [self.itemTableView reloadData];
    
    UIImageView *indicatorImageView= (UIImageView *)[self viewWithTag:(DROP_INDICATOR)];
    
    [UIView animateWithDuration:0.3 animations:^{
        indicatorImageView.transform = CGAffineTransformRotate(indicatorImageView.transform, DEGREES_TO_RADIANS(180));
    }];
    
}


- (void)hiddenListView {
    isHidden = YES;
    CGRect rect = self.itemTableView.frame;
    rect.size.height = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableContainerView.alpha = 1.0f;
        self.itemTableView.alpha = 1.0f;
        
        self.tableContainerView.alpha = 0.2f;
        self.itemTableView.alpha = 0.2;
        
        self.itemTableView.frame = rect;
    }completion:^(BOOL finished) {
        [self.itemTableView removeFromSuperview];
        [self.tableContainerView removeFromSuperview];
    }];
    UIImageView *indicatorImageView = (UIImageView *)[self viewWithTag:DROP_INDICATOR];
    [UIView animateWithDuration:0.3 animations:^{
        indicatorImageView.transform = CGAffineTransformRotate(indicatorImageView.transform, DEGREES_TO_RADIANS(180));
    }];
}


- (void)tapContainerView:(UIGestureRecognizer *)gesture {
    
    
    [self hiddenListView];
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGItem *item = [self.items objectAtIndex:indexPath.row];
    UIButton *titleBtn = (UIButton *)[self viewWithTag:TITLE_BTN_TAG];
    [titleBtn setTitle:item.itemTitle forState:UIControlStateNormal];
    
    [self.dropDownDelegate didSelectedAtIndex:indexPath.row];
    
    [self hiddenListView];
}


@end
