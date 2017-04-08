//
//  MMMineViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMineViewController.h"
#import "MMMineHeadView.h"
#import "MMMineModel.h"
#import "MMMyTableViewCell.h"
#import "MMMyShareViewController.h"
#import "MMMySettingViewController.h"
#import "MMErrorNotebookViewController.h"
@interface MMMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSArray *plistArray;
@property(nonatomic,strong)MMMineHeadView *headView;
@end

@implementation MMMineViewController

-(MMMineHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMMineHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 104.0f)];
    }
    return _headView;
}

-(NSArray *)plistArray{
    if(_plistArray == nil){
        NSString *fullPath  =  [[NSBundle mainBundle]pathForResource:@"Mine.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *temp = [NSMutableArray new];
        [listArray enumerateObjectsUsingBlock:^(NSArray*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray * array = obj;
            NSMutableArray *itemArray = [MMMineModel mj_objectArrayWithKeyValuesArray:array];
            temp[idx] = itemArray;
        }];
        _plistArray = temp;
    }
    return _plistArray;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self MVSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)MVSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height ) style:UITableViewStyleGrouped];
    self.tableView.rowHeight = 44.0f;
    self.tableView.sectionHeaderHeight = 5.0f;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    [self.tableView registerNib:[UINib nibWithNibName:@"MMMyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHead"];
    if(headView == nil){
    
        UITableViewHeaderFooterView *headView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"sectionHead"];
        headView.contentView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.plistArray[section];
    if(NotNilAndNull(array)){
        return array.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMMyTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if(cell == nil){
        cell = [[NSBundle mainBundle]loadNibNamed:@"MMMyTableViewCell" owner:nil options:nil].firstObject;
    }
    NSArray *sectionArray = self.plistArray[indexPath.section];
    if(indexPath.row == (sectionArray.count - 1)){
        cell.cellLine.hidden = YES;
    }
    MMMineModel *model = sectionArray[indexPath.row];
    [cell setCellModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
            case 0:{
                switch (indexPath.row) {
                        case 0:{
                        }
                        break;
                        case 1:{
                        }
                        break;
                        case 2:{
                        }
                        break;
                        case 3:{
                            MMErrorNotebookViewController *ENVC = [MMErrorNotebookViewController new];
                             [self.navigationController pushViewController:ENVC animated:YES];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            break;
            
            case 1:{
                switch (indexPath.row) {
                        case 0:{
                            MMMyShareViewController *shareVc = [[MMMyShareViewController alloc]init];
                            [self.navigationController pushViewController:shareVc animated:YES];
                        }
                        break;
                        case 1:{
                            MMMySettingViewController *SetVC = [MMMySettingViewController new];
                            [self.navigationController pushViewController:SetVC animated:YES];
                        }
                        break;
                    default:
                        break;
                }
            }
            break;
            
        default:
            break;
    }
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
