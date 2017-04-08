//
//  MMKnowlegeViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKnowlegeViewController.h"
#import "MMKnowlegeTableViewCell.h"
#import "MMKnowlegeDetaiViewController.h"

#import "MMKVRecordViewController.h"
#import "MMKVStructViewController.h"
#import "MMKVStructMapViewController.h"
#import "MMKVPracticeViewController.h"

#import "MMKnowlegeHeadView.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface MMKnowlegeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMKnowlegeHeadView *headView;
@end

@implementation MMKnowlegeViewController

-(MMKnowlegeHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMKnowlegeHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 221.0f)];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self KVSetUpNavItem];
    [self KVSetupSubviews];
    // Do any additional setup after loading the view.
}

-(void)KVSetupSubviews{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.width,self.view.height- kTabbarHeight - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MMKnowlegeTableViewCell class] forCellReuseIdentifier:@"MMKnowlegeTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = HEXCOLOR(0xf0f3f8);
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    
}

-(void)KVSetUpNavItem{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 21, 21);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"nav_sousu1"] forState:UIControlStateNormal];
    [rightBtn.imageView setContentMode:UIViewContentModeCenter];
    [rightBtn addTarget:self action:@selector(KVSearchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = customRightItem;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return [tableView fd_heightForCellWithIdentifier:@"MMKnowlegeTableViewCell" configuration:^(MMKnowlegeTableViewCell * cell) {
       [cell setTagViews:@[@"4G套餐",@"优惠套餐",@"特惠套餐"]];
   }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf();
    MMKnowlegeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMKnowlegeTableViewCell"];
    if(cell == nil){
        cell = [[MMKnowlegeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMKnowlegeTableViewCell"];
    }
    [cell setTagViews:@[@"4G套餐",@"优惠套餐",@"特惠套餐"]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setKTattentionClickBlock:^{//关注点击
        
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *VCs = [NSArray arrayWithObjects:
                    [MMKVRecordViewController new],
                    [MMKVStructViewController new],
                    [MMKVStructMapViewController new],
                    [MMKVPracticeViewController new],nil];
    
    NSArray *titles = [NSArray arrayWithObjects:
                       @"最新收录",
                       @"知识结构",
                       @"结构图",
                       @"试题",nil];
    MMKnowlegeDetaiViewController *vc = [[MMKnowlegeDetaiViewController alloc]initWithControllers: VCs titles:titles];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)KVSearchBtnClick{
   
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
