//
//  MMWorkMyViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkMyViewController.h"
#import "MMWorkMyDetailViewController.h"
#import "MMWorkMyCell.h"
@class MMWorkMyModel;
@interface MMWorkMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMWorkMyViewController

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMWorkMy.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMWorkMyModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self WMSetUpSubviews];
    // Do any additional setup after loading the view.
}




-(void)WMSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 100.0f;
    [self.tableView registerClass:[MMWorkMyCell class] forCellReuseIdentifier:@"MMWorkMyCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMWorkMyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMWorkMyCell"];
    
    if(cell == nil){
        cell = [[MMWorkMyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMWorkMyCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row == (self.plistArray.count - 1)){
        cell.cellLine.hidden = YES;
    }
    MMWorkMyModel *model =_plistArray[indexPath.row];
    [cell setCellModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MMWorkMyDetailViewController *Vc = [MMWorkMyDetailViewController new];
    [self.parentViewController.navigationController pushViewController:Vc animated:YES];
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
