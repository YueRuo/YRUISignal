//
//  YRUISignal.h
//  YRSnippets
//
//  Created by 王晓宇 on 14-4-15.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    YRUISignalState_None=1,//未开始
    YRUISignalState_Executing,//正在执行
    YRUISignalState_Cancel,//被取消
    YRUISignalState_Finished,//执行完毕且找到响应者
    YRUISignalState_NotFound,//执行到最后也没有找到
}YRUISignalState;

@protocol YRUISignalDelegate;
@interface YRUISignal : NSObject
@property (retain,nonatomic) NSString *name;//名字,唯一标识
@property (assign,nonatomic) NSInteger tag;//数字,辅助标识
@property (retain,nonatomic) id userInfo;//附带信息或参数

@property (weak,nonatomic) id sender;//发送者,应当是UIView或者UIViewController
@property (weak,nonatomic) id receiver;//接受者,应当是UIView或者UIViewController，如果有，则尝试直接发送至接受者，如为nil，则按链式传递处理
@property (assign,readonly) YRUISignalState state;

-(void)start;
-(void)cancel;
@end


@protocol YRUISignalDelegate <NSObject>

/*!
 *	@brief	处理某个信号，具体的是否处理该消息根据signal的name判别
 *
 *	@param 	signal 	待处理的信号消息
 *
 *	@return	如果返回是YES，则中断响应链，如果是NO，则继续传递消息
 */
-(BOOL)handleYRUISignal:(YRUISignal *)signal;

@end




@interface UIView (YRUISignal)<YRUISignalDelegate>//由view中发出信号
-(void)sendYRUISignalForKey:(NSString*)signalKey;
-(void)sendYRUISignalForKey:(NSString *)signalKey userInfo:(id)userInfo;
-(void)sendYRUISignal:(YRUISignal *)signal;
-(UIViewController*)viewControllerForYRUISignal;
@end
@interface UIViewController (YRUISignal)<YRUISignalDelegate>//在controller中处理
@end
