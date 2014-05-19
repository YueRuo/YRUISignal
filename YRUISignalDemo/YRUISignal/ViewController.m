//
//  ViewController.m
//  YRUISignal
//
//  Created by 王晓宇 on 14-5-19.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "ViewController.h"
#import "YRUISignal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    TestViewLevel1 *testView1=[[TestViewLevel1 alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:testView1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)handleYRUISignal:(YRUISignal *)signal{
    if ([signal.name isEqualToString:TestViewLevel3ButtonSignalKey]) {//能处理这个信号
        NSLog(@"--->>the controller get the event for TestView3  and the info =%@",signal.userInfo);
        return true;//根据需要中断响应链
    }
    return false;//否则就继续传递
}
@end
