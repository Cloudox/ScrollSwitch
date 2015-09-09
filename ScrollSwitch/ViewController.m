//
//  ViewController.m
//  ScrollSwitch
//
//  Created by csdc-iMac on 15/9/7.
//  Copyright (c) 2015年 csdc. All rights reserved.
//

#import "ViewController.h"
#import "InfoCustomHeaderView.h"

@interface ViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;// 标签滚动栏
@property (strong, nonatomic) NSString *btnName;// 标签的名字
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 表头
    UIView *headTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 110)];
    headTitleView.backgroundColor = [UIColor yellowColor];
    
    // 表头中的标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, [UIScreen mainScreen].bounds.size.width, 16)];
    titleLabel.text = @"ScrollSwitch";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.numberOfLines = 0;
    titleLabel.opaque = NO;
    
    // 表头中的年份
    UILabel *yearAndDirectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 58, [UIScreen mainScreen].bounds.size.width, 13)];
    yearAndDirectorLabel.text = @"year";
    yearAndDirectorLabel.backgroundColor = [UIColor clearColor];
    yearAndDirectorLabel.textColor = [UIColor colorWithRed:142.0/255.0 green:195.0/255.0 blue:241.0/255.0 alpha:1];
    yearAndDirectorLabel.textAlignment = NSTextAlignmentCenter;
    [yearAndDirectorLabel setFont:[UIFont systemFontOfSize:13]];
    
    // 横向滚动条
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 30)];
    self.scrollView.backgroundColor = [UIColor greenColor];
    self.scrollView.scrollEnabled = YES;// 可滚动
    self.scrollView.bounces = NO;// 到边界不弹回
    self.scrollView.showsHorizontalScrollIndicator = NO;// 不显示横向滚动条
    
    NSMutableArray *switchTitle = [[NSMutableArray alloc] initWithObjects:@"基本信息", @"联系方式", @"申报信息", @"立项信息", @"年检信息", @"结项信息", nil];
    
    self.scrollView.contentSize = CGSizeMake(20 + [switchTitle count] * 100, 30);// 设置显示内容的多少
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSLog(@"%f", screenBounds.size.width);
    
    for (int i = 0; i < [switchTitle count]; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20 + i * 100, 0, 80, 25)];
        [btn setTitle:[switchTitle objectAtIndex:i] forState:UIControlStateNormal];// 设置标题
        [btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];// 添加响应
        [self.scrollView addSubview:btn];
        if (i == 0) {
            self.btnName = btn.titleLabel.text;
            [self.tableView reloadData];
        }
        
    }
    
    // 将上述view添加到表头中去
    [headTitleView addSubview:titleLabel];
    [headTitleView addSubview:yearAndDirectorLabel];
    [headTitleView addSubview:self.scrollView];
    
    self.tableView.tableHeaderView = headTitleView;
    [self.tableView reloadData];
}

- (void)selectButton:(UIButton *)sender {
    self.btnName = sender.titleLabel.text;// 标签标题
    NSLog(@"%@", self.btnName);
    [self.tableView reloadData];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
//    NSLog(@"%f", sender.frame.origin.x + sender.bounds.size.width - screenBounds.size.width);
    NSLog(@"%f", self.scrollView.contentOffset.x);
    
    if (sender.frame.origin.x + sender.bounds.size.width - self.scrollView.contentOffset.x > screenBounds.size.width) {// 标签内容超出了屏幕右边边界
        [self.scrollView setContentOffset:CGPointMake(sender.frame.origin.x - (screenBounds.size.width - sender.bounds.size.width - 20), 0) animated:YES];
    }
    
    if (sender.frame.origin.x - self.scrollView.contentOffset.x < 20) {// 标签内容超出了屏幕左边边界
        [self.scrollView setContentOffset:CGPointMake(sender.frame.origin.x - 20, 0) animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ListViewCellId = @"ListViewCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListViewCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListViewCellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 第 %ld 行", self.btnName, [indexPath row]];
    
    return  cell;
}

@end
