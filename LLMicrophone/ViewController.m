//
//  ViewController.m
//  LLMicrophone
//
//  Created by 啸峰 on 16/6/11.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "ViewController.h"
#import "LLSpeakingView.h"

@interface ViewController ()

@property (nonatomic, strong) LLSpeakingView *speakingView;
@property (nonatomic, strong) NSTimer *changeVolume;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor yellowColor]];
    _speakingView = [[LLSpeakingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    _speakingView.clipsToBounds = YES;
    [self.view addSubview:_speakingView];
    [_speakingView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *contsArr = [[NSMutableArray alloc] init];
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(self.view,_speakingView);
    NSNumber *width = @(300);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(width);
    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[_speakingView]-0-|"]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDic]];
    
    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[_speakingView(width)]-0-|"]
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:viewsDic]];
    [self.view addConstraints:contsArr];
    
    //开始动画按钮
    UIButton *starAnimationButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [starAnimationButon addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [starAnimationButon setTitle:@"开始动画" forState:UIControlStateNormal];
    [starAnimationButon setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:starAnimationButon];
    [starAnimationButon setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *saBtnContsArr = [[NSMutableArray alloc] init];
    width = @(100);
    NSNumber *height = @(60);
    NSDictionary *btnMetrics = NSDictionaryOfVariableBindings(width,height);
    NSDictionary *btnViewDic = NSDictionaryOfVariableBindings(self.view,starAnimationButon);
    [saBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[starAnimationButon(width)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:btnViewDic]];
    
    [saBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[starAnimationButon(height)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:btnViewDic]];
    
    [saBtnContsArr addObject:[NSLayoutConstraint constraintWithItem:starAnimationButon
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    
    [saBtnContsArr addObject:[NSLayoutConstraint constraintWithItem:starAnimationButon
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:100]];
    [self.view addConstraints:saBtnContsArr];
    
    //关闭动画
    UIButton *stopAnimationButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopAnimationButon addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
    [stopAnimationButon setTitle:@"结束动画" forState:UIControlStateNormal];
    [stopAnimationButon setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:stopAnimationButon];
    [stopAnimationButon setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSMutableArray *stBtnContsArr = [[NSMutableArray alloc] init];
    NSDictionary *stBtnViewDic = NSDictionaryOfVariableBindings(self.view,starAnimationButon,stopAnimationButon);
    [stBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[stopAnimationButon(width)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:stBtnViewDic]];
    
    [stBtnContsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[starAnimationButon]-20-[stopAnimationButon(height)]"]
                                                                               options:0
                                                                               metrics:btnMetrics
                                                                                 views:stBtnViewDic]];
    
    [stBtnContsArr addObject:[NSLayoutConstraint constraintWithItem:stopAnimationButon
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    
    
    [self.view addConstraints:stBtnContsArr];
}

- (void)stopAnimation {
    [_speakingView stopSpeak];
    [_changeVolume invalidate];
}

- (void)startAnimation {
    [_speakingView startSpeak];
    _changeVolume = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(changeVoice) userInfo:nil repeats:YES];
}

- (void)changeVoice {
    int value = (arc4random() % 100) + 1;
    [_speakingView volumeChange:value];
}
@end
