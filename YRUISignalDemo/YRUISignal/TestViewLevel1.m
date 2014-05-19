//
//  TestViewLevel1.m
//  YRUISignal
//
//  Created by 王晓宇 on 14-5-19.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "TestViewLevel1.h"

@implementation TestViewLevel1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        TestViewLevel2 *testView2=[[TestViewLevel2 alloc]initWithFrame:CGRectMake(30, 50, frame.size.width-60, frame.size.height-100)];
        
        [self addSubview:testView2];
        
        [self setBackgroundColor:[UIColor grayColor]];
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

@end
