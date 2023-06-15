//
//  CFPermenantThread.h
//  ThreadKeepAlivePro
//
//  Created by jcf on 2023/6/15.
//

#import <Foundation/Foundation.h>

typedef void (^CFPermenantThreadTask)(void);

@interface CFPermenantThread : NSObject





/// 开启线程
- (void)startThread;

/// 开始一个任务
/// - Parameter task: 任务
- (void)executeTask:(CFPermenantThreadTask)task;

/// 关闭线程
- (void)stopThread;


@end


