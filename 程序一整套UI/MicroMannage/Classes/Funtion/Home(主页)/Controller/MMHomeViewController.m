//
//  MMHomeViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMHomeViewController.h"
#import "MMHomeHeadView.h"
#import "MMHomeSectionHead.h"
#import "MMHomeEmployCell.h"
#import "MMRecommendTableViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "MMHomeSearchButton.h"
#import "MMHomeBtnItemModel.h"
#import "MMNoticeViewController.h"
#import "WLSegmentViewController.h"
#import "MMRankingActiveViewController.h"
#import "MMRankingTimeViewController.h"
#import "MMEmployeeViewController.h"
#import "MMEmployStatisticViewController.h"
#import "MMEmployMannagerViewController.h"
#import "MMEvaluationViewController.h"
#import "MMEvaluationExamViewController.h"
#import "MMEvaluationRecordViewController.h"
#import "MMEvaluationMannagerController.h"
#import "MMWorkViewController.h"
#import "MMWorkDispatchViewController.h"
#import "MMWorkMyViewController.h"
#import "MMTrainViewController.h"
#import "MMTrainWorkViewController.h"
#import "MMTrainDispatchController.h"
#import "MMHomeEmployModel.h"
#import "CXSearchController.h"
#import "BSENavigationController.h"

#define NAVBAR_CHANGE_POINT 84.0f
@interface MMHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMHomeHeadView *headView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *employPlist;
@end

@implementation MMHomeViewController

-(NSArray *)employPlist{
    if(_employPlist == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"HomeEmploy.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *itemArray = [MMHomeEmployModel mj_objectArrayWithKeyValuesArray:listArray];
        _employPlist = [itemArray copy];
    }
    return _employPlist;
}

-(MMHomeHeadView *)headView{
    if(_headView == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"HomeFuncBtnItems.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *itemArray = [MMHomeBtnItemModel mj_objectArrayWithKeyValuesArray:listArray];
        _headView = [[MMHomeHeadView alloc]initWithItems:itemArray  Frame:CGRectMake(0,0, kScreenWidth, 353.5f)];
    }
    return _headView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _tableView.delegate = self;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tableView.delegate = nil;
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self HVSetUpNavItem];
    [self HVSetupSubviews];
    // Do any additional setup after loading the view.
}

-(void)HVSetupSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -kNavigationBarAndStateBarHeight,self.view.width,self.view.height+(kNavigationBarAndStateBarHeight - kTabbarHeight)) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.sectionHeaderHeight = 60.0f;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[MMHomeSectionHead class] forHeaderFooterViewReuseIdentifier:@"MMHomeSectionHead"];
    [self.tableView registerClass:[MMHomeEmployCell class] forCellReuseIdentifier:@"MMHomeEmployCell"];
    [self.tableView registerClass:[MMRecommendTableViewCell class] forCellReuseIdentifier:@"MMRecommendTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    
    WeakSelf();
    //表头点击事件
    [self.headView setADClickBlock:^(NSUInteger idx) {
        
    } FuncBtnClickBlock:^(NSUInteger idx) {
        switch (idx) {
            case 0:{
                NSArray *contollers = [NSArray arrayWithObjects:
                                       [MMWorkMyViewController new],
                                       [MMWorkDispatchViewController new],
                                       nil];
                
                NSArray *titles = [NSArray arrayWithObjects:
                                   @"我的工作",
                                   @"安排工作",
                                   nil];
                MMWorkViewController *EV = [[MMWorkViewController alloc]initWithController:contollers addTitles:titles];
                [weakself.navigationController pushViewController:EV animated:YES];

            }
                break;
                
            case 1:{
                NSArray *contollers = [NSArray arrayWithObjects:
                                       [MMTrainWorkViewController new],
                                       [MMTrainDispatchController new],
                                       nil];
                
                NSArray *titles = [NSArray arrayWithObjects:
                                   @"岗位培训",
                                   @"培训安排",
                                   nil];
                MMTrainViewController *EV = [[MMTrainViewController alloc]initWithController:contollers addTitles:titles];
                [weakself.navigationController pushViewController:EV animated:YES];
                
            }break;
            case 2:{
                NSArray *contollers = [NSArray arrayWithObjects:
                                       [MMEvaluationExamViewController new],
                                       [MMEvaluationRecordViewController new],
                                       [MMEvaluationMannagerController new],
                                       nil];
                
                NSArray *titles = [NSArray arrayWithObjects:
                                   @"考试",
                                   @"记录",
                                   @"管理",
                                   nil];
                MMEvaluationViewController *EEV = [[MMEvaluationViewController alloc]initWithController:contollers addTitles:titles];
                [weakself.navigationController pushViewController:EEV animated:YES];
               
            }break;
                
            case 3:{
                NSArray *contollers = [NSArray arrayWithObjects:
                                       [MMRankingActiveViewController new],
                                       [MMRankingTimeViewController new],
                                       nil];
                
                NSArray *titles = [NSArray arrayWithObjects:
                                   @"学习时长",
                                   @"答题正确率",
                                   nil];
                
                WLSegmentViewController *Ranking = [[WLSegmentViewController alloc]initWithController:contollers addTitles:titles];
                [weakself.navigationController pushViewController:Ranking animated:YES];

            }break;
                
            default:
                break;
        }
    }];
}

-(void)HVSetUpNavItem{
    CGFloat SearchBtnW = kScreenWidth - 95.0f;
    CGFloat SearchBtnY = 6.0f;
    MMHomeSearchButton *searchBtn = [[MMHomeSearchButton alloc]initWithFrame:CGRectMake(12.0f,SearchBtnY,SearchBtnW, 32.0f)];
    [searchBtn setTitleColor:HEXCOLOR(0x8c95aa) forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索课程/知识库" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[[UIColor whiteColor]colorWithAlphaComponent:0.8f] forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [searchBtn setImage:[UIImage imageNamed:@"nav_sousu"] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 16.0f;
    searchBtn.layer.masksToBounds = YES;
    [searchBtn addTarget:self action:@selector(HVSearchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 21, 21);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"nav_gonggao"] forState:UIControlStateNormal];
    [rightBtn.imageView setContentMode:UIViewContentModeCenter];
    [rightBtn addTarget:self action:@selector(HVNoticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = customRightItem;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 21, 21);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_saoyisao"] forState:UIControlStateNormal];
    [leftBtn.imageView setContentMode:UIViewContentModeCenter];
    [leftBtn addTarget:self action:@selector(HVQrcodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customleftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = customleftItem;
    
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section  == 0){
        return 65.0f;
    }else{
      return 164.0f;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section  == 0){
        return self.employPlist.count;
    }else if(section == 1){
        return 4;
    }else if(section == 2){
        return 4;
    }else if(section == 3){
        return 4;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        MMHomeEmployCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMHomeEmployCell"];
        if(cell == nil){
            cell = [[MMHomeEmployCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMHomeEmployCell"];
        }
        MMHomeEmployModel *model = self.employPlist[indexPath.row];
        [cell setCellModel:model];
        if(indexPath.row == self.employPlist.count - 1){
            cell.cellLine.hidden = YES;
        }
        return cell;
        
    }else{
        MMRecommendTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MMRecommendTableViewCell"];
        if(cell == nil){
            cell = [[MMRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMRecommendTableViewCell"];
        }
        if(indexPath.row  == 9){
            cell.cellLine.hidden = YES;
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WeakSelf();
    MMHomeSectionHead *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MMHomeSectionHead"];
    if(headView == nil){
        headView = [[MMHomeSectionHead alloc]initWithReuseIdentifier:@"MMHomeSectionHead"];
        
    }
    
    switch (section) {
        case 0:{
            [headView setTitle:@"员工管理" SubTitle:@"查看更多" SubImage:[UIImage imageNamed:@"icon_gengduo"] FunctionBlock:^{
                NSArray *contollers = [NSArray arrayWithObjects:
                                       [MMEmployStatisticViewController new],
                                       [MMEmployMannagerViewController new],
                                       nil];
                
                NSArray *titles = [NSArray arrayWithObjects:
                                   @"员工统计",
                                   @"员工管理",
                                   nil];
                MMEmployeeViewController *EV = [[MMEmployeeViewController alloc]initWithController:contollers addTitles:titles];
                [weakself.navigationController pushViewController:EV animated:YES];
            }];
        }
            break;
        case 1:{
            [headView setTitle:@"个性推荐" SubTitle:@"换一批" SubImage:[UIImage imageNamed:@"icon_hyp"] FunctionBlock:^{
                
            }];
        }
            break;
        case 2:{
            [headView setTitle:@"最新知识" SubTitle:@"换一批" SubImage:[UIImage imageNamed:@"icon_hyp"] FunctionBlock:^{
                
            }];
        }
            break;
        case 3:{
            [headView setTitle:@"热门知识" SubTitle:@"换一批" SubImage:[UIImage imageNamed:@"icon_hyp"] FunctionBlock:^{
                
            }];
        }
            break;
            
        default:
            break;
    }
    return headView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 导航栏变色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == _tableView){
      UIColor * color = HEXCOLOR(kBlueColor);
      CGFloat offsetY = scrollView.contentOffset.y;
      if (offsetY > NAVBAR_CHANGE_POINT) {
          CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT - offsetY) / 64));
          [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
      } else {
          [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
      }
    }
}

#pragma mark - NavBtnClick
-(void)HVNoticeBtnClick{
    MMNoticeViewController *NTVc = [MMNoticeViewController new];
    [self.navigationController pushViewController:NTVc animated:YES];
}

#pragma mark - 搜索点击
-(void)HVSearchBtnClick{
    BSENavigationController *nav = [[BSENavigationController alloc]initWithRootViewController:[CXSearchController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 二维码扫描点击
-(void)HVQrcodeBtnClick{
  
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
