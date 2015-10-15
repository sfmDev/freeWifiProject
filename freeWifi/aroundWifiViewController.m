//
//  aroundWifiViewController.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/3.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#define width self.view.frame.size.width
#define height self.view.frame.size.height

#import "aroundWifiViewController.h"
#import "AppModel.h"
#import "AppCell.h"
#import "mapViewController.h"
#import "detailViewController.h"
#import "NYSegmentedControl.h"
@interface aroundWifiViewController ()<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_sortArr;
    
    NSMutableArray *_dataArray;
    NSMutableData *_data;
    UITableView *_tableView;
    
    NSMutableArray *_unSortArr;
}

@property NYSegmentedControl *segmentedControl;
@property NSArray *exampleViews;
@property UIView *visibleExampleView;
@end

@implementation aroundWifiViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    [self configUI];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    
    
    //返回 btn
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 38, 38);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(tapBack) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    [self.navigationItem.leftBarButtonItem setCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    //设置segment
    self.segmentedControl = [[NYSegmentedControl alloc] initWithItems:@[@"列表", @"地图"]];
    [self.segmentedControl addTarget:self action:@selector(segmentSelected) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.titleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:14.0f];
    self.segmentedControl.titleTextColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    self.segmentedControl.selectedTitleFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:14.0f];
    self.segmentedControl.selectedTitleTextColor = [UIColor whiteColor];
    self.segmentedControl.borderWidth = 1.0f;
    self.segmentedControl.borderColor = [UIColor colorWithWhite:0.15f alpha:1.0f];
    self.segmentedControl.drawsGradientBackground = YES;
    self.segmentedControl.segmentIndicatorInset = 2.0f;
    self.segmentedControl.segmentIndicatorGradientTopColor = [UIColor colorWithRed:0.30 green:0.50 blue:0.88f alpha:1.0f];
    self.segmentedControl.segmentIndicatorGradientBottomColor = [UIColor colorWithRed:0.20 green:0.35 blue:0.75f alpha:1.0f];
    self.segmentedControl.drawsSegmentIndicatorGradientBackground = YES;
    self.segmentedControl.segmentIndicatorBorderWidth = 0.0f;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl sizeToFit];
    self.navigationItem.titleView = self.segmentedControl;
}

-(void)tapBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)segmentSelected {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self configUI];
    }
    else
    {
        mapViewController *mapVC = [[mapViewController alloc]init];
        mapVC.arr = _unSortArr;
//        AppModel *model = [[AppModel alloc]init];
//        mapVC.model = model;
//        mapVC.intro = self.intro;
//        mapVC.coordinate = self.coordinate;
//        mapVC.address =
        [self.navigationController pushViewController:mapVC animated:YES];
        self.segmentedControl.selectedSegmentIndex = 0;
    }
}

-(void)backTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareData
{
    _dataArray = [[NSMutableArray alloc]init];
    _data = [[NSMutableData alloc]init];
    _unSortArr = [[NSMutableArray alloc]init];
    [self loadData];
}

-(NSString *)getUrl
{
    return [NSString stringWithFormat:@"http://apis.juhe.cn/wifi/local?key=55190e596c87c75204d002ba35dfa88c&lon=%f&lat=%f&r=3000&type=1",self.coordinate.longitude,self.coordinate.latitude];
//    return [NSString stringWithFormat:@"http://apis.juhe.cn/wifi/local?key=55190e596c87c75204d002ba35dfa88c&lon=116.366324&lat=39.905859&r=3000&type=1"];
}

-(void)loadData
{
    NSString *url = [self getUrl];
//    NSLog(@"%@",url);
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
}

-(void)configUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -38,width,height+38) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AppCell" owner:self options:nil]firstObject];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data.length = 0;

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请检查您的网络" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id res = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    
    if ([res isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)res;

        NSDictionary *dict = dic[@"result"];
        NSArray *subDic = dict[@"data"];
    
        for (NSDictionary *value in subDic) {
             AppModel *model = [[AppModel alloc]init];
            [model setValuesForKeysWithDictionary:value];

            [_dataArray addObject:model];
        }
        _unSortArr = _dataArray;
        [_dataArray sortUsingSelector:@selector(compareByDistance:)];
    }
    //判断用户附近是否有wifi
    if (_dataArray.count == 0) {
        UIAlertView *alertVC = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:@"暂时无法得到您附近免费Wifi" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertVC show];
    }
    [_tableView reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailViewController *detailVC = [[detailViewController alloc]init];
    AppModel *model = _dataArray[indexPath.row];
    detailVC.model = model;
//    detailVC.intro = model.intro;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
