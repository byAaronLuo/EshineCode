//
//  MMWorkDetailTaskCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkDetailTaskCell.h"
@interface MMWorkDetailTaskCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableContent;
@property(nonatomic,strong)UIView *taskLine;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *lableName;
@property(nonatomic,strong)UILabel *lableTime;
@property(nonatomic,strong)UILabel *lableFirstChat;
@property(nonatomic,strong)UIView *chatContent;
@property(nonatomic,strong)UIButton *btnShowAll;
@property(nonatomic,strong)UIView *contentLine;
@property(nonatomic,strong)UIButton *btnChart;
@property(nonatomic,strong)UIButton *btnComplete;
@property(nonatomic,strong)UIView *cellLine;
@end
@implementation MMWorkDetailTaskCell

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _cellLine;
}
-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        _lableTitle.textColor = HEXCOLOR(0x333333);
    }
    return _lableTitle;
}

-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        [_lableContent setFont:[UIFont systemFontOfSize:16.0f]];
        _lableContent.textColor = HEXCOLOR(0x666666);
        _lableContent.numberOfLines = 0.0f;
    }
    return _lableContent;
}

-(UIView *)taskLine{
    if(_taskLine == nil){
        _taskLine = [UIView new];
        _taskLine.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _taskLine;
}

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor redColor];
        _headImageView.layer.cornerRadius = 13.0f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)lableName{
    if(_lableName == nil){
        _lableName = [UILabel new];
        [_lableName setFont:[UIFont systemFontOfSize:13.0f]];
        _lableName.textColor = HEXCOLOR(0x666666);
    }
    return _lableName;
}

-(UILabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [UILabel new];
        [_lableTime setFont:[UIFont systemFontOfSize:12.0f]];
        _lableTime.textColor = HEXCOLOR(0x999999);
    }
    return _lableTime;
}

-(UILabel *)lableFirstChat{
    if(_lableFirstChat == nil){
        _lableFirstChat = [UILabel new];
        [_lableFirstChat setFont:[UIFont systemFontOfSize:13.0f]];
        _lableFirstChat.textColor = HEXCOLOR(0x333333);
        _lableFirstChat.numberOfLines = 0.0f;
    }
    return _lableFirstChat;
}

-(UIView *)chatContent{
    if(_chatContent == nil){
        _chatContent = [UIView new];
        _chatContent.backgroundColor = HEXCOLOR(0xf9f9f9);
    }
    return _chatContent;
}

-(UIButton *)btnShowAll{
    if(_btnShowAll == nil){
        _btnShowAll = [UIButton new];
        _btnShowAll.backgroundColor = HEXCOLOR(0xf9f9f9);
        [_btnShowAll.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_btnShowAll setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_btnShowAll.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_btnShowAll addTarget:self action:@selector(btnShowAllClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnShowAll;
}

-(UIView *)contentLine{
    if(_contentLine == nil){
        _contentLine = [UIView new];
        _contentLine.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _contentLine;
}

-(UIButton *)btnChart{
    if(_btnChart == nil){
        _btnChart = [UIButton new];
        [_btnChart setImage:[UIImage imageNamed:@"tab_pinglun"] forState:UIControlStateNormal];
        [_btnChart setImage:[UIImage imageNamed:@"tab_pinglun1"] forState:UIControlStateHighlighted];
        [_btnChart setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [_btnChart.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_btnChart addTarget:self action:@selector(btnChatClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnChart;
}

-(UIButton *)btnComplete{
    if(_btnComplete == nil){
        _btnComplete = [UIButton new];
        [_btnComplete setImage:[UIImage imageNamed:@"icon_wancheng"] forState:UIControlStateNormal];
        [_btnComplete setImage:[UIImage imageNamed:@"icon_wancheng1"] forState:UIControlStateSelected];
        [_btnComplete setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [_btnComplete addTarget:self action:@selector(completeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnComplete;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self WDSetUpSubviews];
    }
    return self;
}

-(void)WDSetUpSubviews{
     self.contentView.backgroundColor = [UIColor whiteColor];
    
     [self.contentView addSubview:self.lableTitle];
     [self.contentView addSubview:self.lableContent];
     [self.contentView addSubview:self.taskLine];
     [self.contentView addSubview:self.headImageView];
     [self.contentView addSubview:self.lableName];
     [self.contentView addSubview:self.lableTime];
     [self.contentView addSubview:self.lableFirstChat];
     [self.contentView addSubview:self.chatContent];
     [self.chatContent addSubview:self.btnShowAll];
     [self.contentView addSubview:self.contentLine];
     [self.contentView addSubview:self.btnChart];
     [self.contentView addSubview:self.btnComplete];
    [self.contentView addSubview:self.cellLine];
}

-(void)setFrameModel:(MMDetailTaskFrame *)frameModel{
    _frameModel = frameModel;
    //聊天记录
    NSArray *chatsContent = frameModel.viewModel.chatContents;
    MMDetailTaskModel *model = frameModel.viewModel;
    [_chatContent.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_chatContent addSubview:self.btnShowAll];
    [chatsContent enumerateObjectsUsingBlock:^(NSString*  _Nonnull content, NSUInteger idx, BOOL * _Nonnull stop){
        UILabel *lableChat = [[UILabel alloc]init];
        NSValue *fameValue = _frameModel.contentFrames[idx];
        CGRect itemFrame;
        [fameValue getValue:&itemFrame];
        lableChat.frame = itemFrame;
        lableChat.numberOfLines = 0.0f;
        lableChat.font = [UIFont systemFontOfSize:13.0f];
        lableChat.textColor = HEXCOLOR(0x666666);
        lableChat.text = model.chatContents[idx];
        [_chatContent addSubview:lableChat];
    }];
    [self setFrameWithModel:frameModel];
    [self setViewModel:frameModel.viewModel];
   
}

-(void)setFrameWithModel:(MMDetailTaskFrame *)frameModel{
    _cellLine.frame = frameModel.cellLineFrame;
    _lableTitle.frame = frameModel.titleFrame;
    _lableContent.frame = frameModel.titleContentFrame;
    _taskLine.frame = frameModel.taskLineFrame;
    _headImageView.frame = frameModel.headImageFrame;
    _lableName.frame = frameModel.nameFrame;
    _lableTime.frame = frameModel.timeFrame;
    _lableFirstChat.frame = frameModel.firstChatFrame;
    _chatContent.frame = frameModel.chatContentFrame;
    
    _btnShowAll.frame = frameModel.btnShowAllFrame;
    _contentLine.frame = frameModel.contentLineFrame;
    _btnChart.frame = frameModel.btnChartFrame;
    _btnComplete.frame = frameModel.btnCompleteFrame;
    
}

-(void)setViewModel:(MMDetailTaskModel *)viewModel{
    _lableContent.text = viewModel.title;
    _lableName.text = viewModel.name;
    _lableTime.text = viewModel.time;
    _lableFirstChat.text = viewModel.chatContents.firstObject;
    [_btnShowAll setTitle:[NSString stringWithFormat:@"查看全部%lu条回复",viewModel.chatContents.count] forState:UIControlStateNormal];
    [_btnChart setTitle:[NSString stringWithFormat:@"%lu",viewModel.chatContents.count] forState:UIControlStateNormal];
}

#pragma mark - 评论点击
-(void)btnChatClick{
    _chatClickBlock ? _chatClickBlock():nil;
 
}

#pragma mark - 完成点击
-(void)completeBtnClick:(UIButton *)sender{
    _completeClickBlock?_completeClickBlock(sender):nil;
}

#pragma mark - 显示全部点击
-(void)btnShowAllClick{
    BOOL state = _frameModel.showAll;
    state = !state;
    _showAllClickBlock?_showAllClickBlock(state):nil;
}

-(void)setTaskIdex:(NSUInteger)taskIdex{
    _lableTitle.text = [NSString stringWithFormat:@"任务%lu",taskIdex];
}

-(void)setChatClickBlock:(chatClick)chatClickBlock CompleteClickBlock:(completeClick)completeClickBlock ShowAllClickBlock:(showAllClick)showAllClickBlock{
    _chatClickBlock = chatClickBlock;
    _completeClickBlock = completeClickBlock;
    _showAllClickBlock = showAllClickBlock;
}








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
