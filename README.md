YRUISignal
==========

Help to get UI action signal

支持pod  

	pod 'YRUISignal'


---

开发中经常遇到类似的情况，viewController上贴了view1，view1上贴了view2，view2上贴了view3...  
（如下图）

viewController  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-----view1  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;------view2  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;------view3  

如果在view3上触发了一个事件，需要在view1，或者viewController中处理，按照一般的处理方式，你需要：  
1.在view3上做protocol，或者做block回调  
2.把事件传给上一个界面（对view3来说就是给到view2）  
3.view2再重复1-2的工作，直到到达相应的界面为止。  

如果这个view的层次很深。。。。你恐怕就不愿意这么做了。。。


还好我们还有替代方案：用通知处理，view3上发送通知，在viewController中先注册通知，再处理它。恩恩，比上面那种要简单多了，但是我们继续思考，是否一个小小的UI事件都需要使用全局的通知呢？  

这里我受Touch事件的链式响应处理以及早期BeeFramework中Signal的启发，做了这个小工具类。

这个工具类的使用很简单。比如说上面提到的view3中触发事件，viewController中处理，只需要两步：  
1.在view3中触发事件时：  

    [self sendYRUISignalForKey:@"事件唯一名称"];
    
2.在viewController中实现handleYRUISignal方法

    -(BOOL)handleYRUISignal:(YRUISignal *)signal{
    	if ([signal.name isEqualToString:@"事件唯一名称"]) {//能处理这个信号
        	return true;//根据需要中断响应链
    	}
    	return false;//不能处理（继续传递给下一个view）
	}
打完收工，是不是非常的简单？  
  
<br><br>
需要注意的是：  
1.这种方式由于采用的是父view链式查找，因此只有view被add到界面上才有效，换句话说，如果这个view被removeFromSubview，则不能正确的传递信号出去。（不过你可以使用sendYRUISignal方法显式指明接受者，但是这样又有点多此一举了）  
2.这种方式个人觉得比通知简单一些，当然仁者见仁智者见智，目前Bee也是使用通知注册的方法去做的传递，但是接收处理上我们不太一致。  
<br>		

希望这里处理方式和思想能对大家有所帮助或者启发。
