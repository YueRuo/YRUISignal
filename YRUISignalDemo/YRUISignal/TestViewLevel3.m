//
//  TestViewLevel3.m
//  YRUISignal
//
//  Created by 王晓宇 on 14-5-19.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "TestViewLevel3.h"
#import "YRUISignal.h"

@implementation TestViewLevel3

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        testButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
        [testButton setBackgroundColor:[UIColor brownColor]];
        [testButton setTitle:@"点完看console" forState:UIControlStateNormal];
        [testButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:testButton];
        
        infoString=@"this is a test info string";
        
        [self setBackgroundColor:[UIColor purpleColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)buttonClicked{
    [self sendYRUISignalForKey:TestViewLevel3ButtonSignalKey userInfo:infoString];
}
@end
