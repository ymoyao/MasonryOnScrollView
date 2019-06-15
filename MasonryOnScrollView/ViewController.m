//
//  ViewController.m
//  MasonryOnScrollView
//
//  Created by 游辉 on 2019/6/15.
//  Copyright © 2019 游辉. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;//滚动视图
@property (nonatomic, readwrite, strong) UIView *mas_heighContentView;//用来获取contentSize 高度的视图
@property (nonatomic, readwrite, strong) UIView *contentView;//真正的scrollView 内部承载视图
@property (nonatomic, readwrite, strong) UIView *topView;//contentView的子视图,
@property (nonatomic, readwrite, strong) UIView *bottomView;//contentView的子视图,在这里会被设置为超过屏幕
@end

@implementation ViewController

//生命周期
#pragma mark - Lifecycle
- (void)dealloc {
    NSLog(@"%@dealloc",self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubviews];
    [self layout];
    // Do any additional setup after loading the view.
}

//视图的初始化，层级结构都在这里
#pragma mark - LoadSubViews
- (void)loadSubviews {
    [self.view addSubview:self.scrollView];
        [self.scrollView addSubview:self.mas_heighContentView];
        [self.scrollView addSubview:self.contentView];
            [self.contentView addSubview:self.topView];
            [self.contentView addSubview:self.bottomView];
}

//视图的布局，刷新
#pragma mark - LayoutSubViews
//布局
- (void)layout {
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        //必须设置宽度 mas_right 对scrollView 没用
        make.width.equalTo(self.scrollView);
        
        //必须设置高度,用来撑开contentSize
        make.height.equalTo(self.mas_heighContentView);
    }];
    
    [self.mas_heighContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.scrollView);
        //这里的底部关联scrollView 最底部的视图,使self.contentView可以拿到 mas_height
        make.bottom.equalTo(self.bottomView);
    }];
    
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(50);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(300);
    }];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(200);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(500);
    }];
}

//重写父类放这里
#pragma mark - Overwrite

//公开方法
#pragma mark - Public Method

//隐私方法
#pragma mark - Privacy Method

//网络请求
#pragma mark - Request <#netRequest#>

//通知方法
#pragma mark - Notification Obverser Method

//代理
#pragma mark - Delegate

//get set 懒加载
#pragma mark - Get and Set
- (UIView *)mas_heighContentView{
    if (_mas_heighContentView == nil) {
        _mas_heighContentView = [[UIView alloc] init];
        _mas_heighContentView.backgroundColor = [UIColor greenColor];
    }
    return _mas_heighContentView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor blueColor];
    }
    return _contentView;
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor yellowColor];
    }
    return _topView;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor redColor];
    }
    return _bottomView;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

@end
