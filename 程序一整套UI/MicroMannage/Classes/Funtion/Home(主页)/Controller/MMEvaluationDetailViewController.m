//
//  MMEvaluationDetailViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationDetailViewController.h"
#import "MMEvaluationDetailHeadView.h"
@interface MMEvaluationDetailViewController ()
@property(nonatomic,strong)MMEvaluationDetailHeadView *EDheadView;
@end

@implementation MMEvaluationDetailViewController

-(MMEvaluationDetailHeadView *)EDheadView{
    if(_EDheadView == nil){
        _EDheadView = [[MMEvaluationDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 289.0f)];
    }
    return _EDheadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self EDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)EDSetUpSubviews{
    self.title = @"考评情况";
    [self setWLtableHeadView:self.EDheadView];
    [_EDheadView redraw];
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
