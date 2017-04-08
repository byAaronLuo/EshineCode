//
//  WLSegmentViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "WLSegmentViewController.h"
#import "WLSegmentView.h"
#import "UINavigationBar+Awesome.h"
@interface WLSegmentViewController ()<WLSegmentDelegate>
@property(nonatomic,strong)WLSegmentView *segMentView;
@property(nonatomic,assign)NSUInteger currentVcIndex;
@end

@implementation WLSegmentViewController

- (instancetype)initWithController:(NSArray *)controllers addTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _controllers = controllers;
        _titles = titles;
        [self SCSetUpSubviews];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

-(void)SCSetUpSubviews{
    _segMentView  = [[WLSegmentView alloc]initWithFrame:CGRectMake(0, 0,70.0f * _titles.count, 30.0f) withTitles:_titles];
    _segMentView.delegate = self;
    self.navigationItem.titleView = _segMentView;
    //添加子视图
    for (int i = 0;i < _controllers.count;i++){
        UIViewController *controller = (UIViewController *)(_controllers[i]);
        controller.view.frame = CGRectMake( 0, 0,self.view.bounds.size.width,self.view.frame.size.height - 64.0f);
        [self addChildViewController:controller];
        if(i == 0){
            _currentVcIndex =  0;
            [self.view addSubview:controller.view];
        }
        [controller didMoveToParentViewController:self];
       
    }
}

-(void)WLSegmentBtnClickAtIndex:(NSInteger)index{
    if(index == _currentVcIndex){//当前视图
        return;
    }else{
      [self replaceControllerIndex:_currentVcIndex WithNewControllerAtIndex:index];
    }
}

-(void)changeCurrentVCToIndex:(NSUInteger)index{
     [self replaceControllerIndex:_currentVcIndex WithNewControllerAtIndex:index];
}

-(void)changeCurrentVCToNext{
    [self replaceControllerIndex:_currentVcIndex WithNewControllerAtIndex:_currentVcIndex+1];
}

-(void)changeCurrentVCToFront{
    if(_currentVcIndex != 0){
      [self replaceControllerIndex:_currentVcIndex WithNewControllerAtIndex:_currentVcIndex - 1];
    }
}



//  切换各个标签内容
- (void)replaceControllerIndex:(NSUInteger)oldIndex WithNewControllerAtIndex:(NSUInteger)newIndex
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    UIViewController *newController = _controllers[newIndex];
    UIViewController *oldController = _controllers[oldIndex];
    [self currentVCWillChangeTo:newIndex controller:newController];
    [self addChildViewController:_controllers[newIndex]];
    [self transitionFromViewController:oldController toViewController:newController duration:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            _currentVcIndex = newIndex;
            [self currentVCDidChangeTo:newIndex controller:newController];
        }else{
            _currentVcIndex = oldIndex;
        }
    }];
}

-(void)currentVCWillChangeTo:(NSUInteger)idex controller:(UIViewController*)vc{
    
}

-(void)currentVCDidChangeTo:(NSUInteger)idex controller:(UIViewController*)vc{
    
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
