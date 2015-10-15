//
//  detailViewController.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/6.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#define ScreenWidth self.view.frame.size.width
#define ScreenHeight self.view.frame.size.height

#import "detailViewController.h"
#import "detailCell.h"
#import "navigateViewController.h"
@interface detailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    UIButton *_navigate;
}
@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _arr = [[NSMutableArray alloc]init];
    [self configUI];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回 btn
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 38, 38);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(tapBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    //    [self.navigationItem.leftBarButtonItem setCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[item];
    
    //导航
    _navigate = [UIButton buttonWithType:UIButtonTypeCustom];
    _navigate.frame= CGRectMake(ScreenWidth/2-150/2,64+50, 150, 38);
    _navigate.layer.borderWidth = 2;
    _navigate.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_navigate setTitle:@"开始导航" forState:UIControlStateNormal];
    [_navigate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_navigate addTarget:self action:@selector(goToNavigate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navigate];
}

-(void)tapBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goToNavigate
{
    navigateViewController *navigateVC = [[navigateViewController alloc]init];
//    AppModel *model = [[AppModel alloc]init];
    navigateVC.baidu_lat = self.baidu_lat;
    navigateVC.baidu_lon = self.baidu_lon;
    navigateVC.address = self.address;
    [self.navigationController pushViewController:navigateVC animated:YES];
}

//-(void)backTapped
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)configUI
{
    CGSize sizeIntro = [self sizeWithText:self.intro font:[UIFont systemFontOfSize:17.0f] size:CGSizeMake(300, MAXFLOAT)];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, sizeIntro.height+ScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
//    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.userInteractionEnabled = NO;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    detailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"detailCell" owner:self options:nil]firstObject];
    }
    cell.model = self.model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [self sizeWithText:self.intro font:[UIFont systemFontOfSize:17.0f] size:CGSizeMake(210, MAXFLOAT)];
//    NSLog(@"%f",size.height);
    return ScreenHeight+size.height;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size
{
    /** 1,CGSize 宽是固定的，高度不固定
     2,Options 记住用枚举值的第二个和第三个
     3,attributes :文本的一系列属性,我们只需要设置字体
     4,context
     */
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
    return rect.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
