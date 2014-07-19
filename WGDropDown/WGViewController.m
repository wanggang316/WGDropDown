//
//  WGViewController.m
//  WGDropDown
//
//  Created by 王刚 on 14/7/18.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGViewController.h"
#import "WGItem.h"
#import "WGDropDownView.h"

@interface WGViewController ()<WGDropDownViewDelegate>

@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation WGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.items = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        WGItem *item = [[WGItem alloc]initWithItemId:[NSString stringWithFormat:@"%d", i] itemTitle:[NSString stringWithFormat:@"item%d",i]];
        [self.items addObject:item];
    }
    //titleView
    WGDropDownView *dropDownView = [[WGDropDownView alloc]initWithFrame:CGRectMake(0, 0, 100, 30) items:self.items delegate:self displayView:self.view isNavigationView:YES];
    self.navigationItem.titleView = dropDownView;
    
    //general
    WGDropDownView *dropDownView1 = [[WGDropDownView alloc]initWithFrame:CGRectMake(0, 64, 160, 30) items:self.items delegate:self displayView:self.view isNavigationView:NO];
    [self.view addSubview:dropDownView1];
    
    //rightBarButtonItem view
    WGDropDownView *dropDownView2 = [[WGDropDownView alloc]initWithFrame:CGRectMake(0, 0, 60, 30) items:self.items delegate:self displayView:self.view isNavigationView:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:dropDownView2];
    [self.navigationItem setRightBarButtonItem:backItem];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - WGDropDownViewDelegate
-(void)didSelectedAtIndex:(NSInteger)index {
    
    WGItem *item = [self.items objectAtIndex:index];
    NSLog(@"-------->sellected index is %d, item id is %@, item title is %@",index, item.itemId, item.itemTitle);
}

@end
