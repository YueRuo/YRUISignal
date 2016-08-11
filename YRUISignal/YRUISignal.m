//
//  YRUISignal.m
//  YRSnippets
//
//  Created by 王晓宇 on 14-4-15.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRUISignal.h"

@implementation YRUISignal
- (id)init {
    if (self = [super init]) {
        _state = YRUISignalState_None;
    }
    return self;
}
- (void)start {
    if (!_sender) {
        NSLog(@"-->>>Warning! YRUISignal must have sender!");
        return;
    }
    [self cancel];
    _state = YRUISignalState_Executing;
    if (_receiver) {
        if ([_receiver handleYRUISignal:self]) {
            _state = YRUISignalState_Finished;
        } else {
            _state = YRUISignalState_NotFound;
        }
    } else {
        [self checkThePossibleHandle:_sender];
    }
}
- (void)cancel {
    _state = YRUISignalState_Cancel;
}
- (void)finished {
    _state = YRUISignalState_Finished;
}
- (void)checkThePossibleHandle:(id<YRUISignalDelegate>)possibleHandle {
    if (_state == YRUISignalState_Executing) {
        if ([possibleHandle handleYRUISignal:self]) { //自己能处理
            [self finished];
        } else {
            if ([possibleHandle isKindOfClass:[UIView class]]) { //查找view链
                UIView *superView = [(UIView *) possibleHandle superview];
                if (superView) {
                    [self checkThePossibleHandle:superView];
                } else { //view找到顶了
                    UIViewController *senderViewController = [(UIView *) _sender viewControllerForYRUISignal];
                    if (senderViewController) {
                        [self checkThePossibleHandle:senderViewController];
                    }
                }
            } else if ([possibleHandle isKindOfClass:[UIViewController class]]) { //查找controll链
                UIViewController *viewControler = (UIViewController *) possibleHandle;
                if ([viewControler isKindOfClass:[UINavigationController class]]) {
                    viewControler = [(UINavigationController *) possibleHandle topViewController];
                    if (viewControler) {
                        [self checkThePossibleHandle:viewControler];
                    }
                } else {
                }
            } else {
            }
        }
        if (_state == YRUISignalState_Executing) { //如果最后还没有
            _state = YRUISignalState_NotFound;
        }
    }
}
@end

@implementation UIView (YRUISignal)
- (void)sendYRUISignalForKey:(NSString *)signalKey {
    [self sendYRUISignalForKey:signalKey userInfo:nil callback:nil];
}
- (void)sendYRUISignalForKey:(NSString *)signalKey userInfo:(id)userInfo {
    [self sendYRUISignalForKey:signalKey userInfo:userInfo callback:nil];
}
- (void)sendYRUISignalForKey:(NSString *)signalKey userInfo:(id)userInfo callback:(YRUISignalCallBack)callback {
    YRUISignal *signal = [[YRUISignal alloc] init];
    signal.name = signalKey;
    signal.userInfo = userInfo;
    signal.callBack = callback;
    [self sendYRUISignal:signal];
}
- (void)sendYRUISignal:(YRUISignal *)signal {
    if (signal) {
        if (!signal.sender) {
            signal.sender = self;
        }
        [signal start];
    }
}
- (BOOL)handleYRUISignal:(YRUISignal *)signal {
    return false;
}
- (UIViewController *)viewControllerForYRUISignal {
    id viewController = [self nextResponder];
    UIView *view = self;
    while (viewController && ![viewController isKindOfClass:[UIViewController class]]) {
        view = [view superview];
        viewController = [view nextResponder];
    }
    return viewController;
}
@end

@implementation UIViewController (YRUISignal)
- (BOOL)handleYRUISignal:(YRUISignal *)signal {
    return false;
}
@end
