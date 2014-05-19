//
//  TestViewLevel2.m
//  YRUISignal
//
//  Created by 王晓宇 on 14-5-19.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "TestViewLevel2.h"

@implementation TestViewLevel2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        TestViewLevel3 *testView3=[[TestViewLevel3 alloc]initWithFrame:CGRectMake(20, 20, frame.size.width-40, frame.size.height-40)];
        
        [self addSubview:testView3];
        [self setBackgroundColor:[UIColor darkGrayColor]];
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
