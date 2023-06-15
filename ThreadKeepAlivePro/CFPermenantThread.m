//
//  CFPermenantThread.m
//  ThreadKeepAlivePro
//
//  Created by jcf on 2023/6/15.
//

#import "CFPermenantThread.h"

@interface CFPermenantThread()

@property (nonatomic, strong) NSThread *innerThread;

@end

@implementation CFPermenantThread

- (instancetype)init {
    if (self = [super init]) {
        self.innerThread = [[NSThread alloc] initWithBlock:^{
            NSLog(@"begin---");
            
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            
            // 销毁source
            CFRelease(source);
            
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            
            NSLog(@"end---");
        }];
    }
    return self;
}

- (void)startThread {
    if (!self.innerThread) return;
    [self.innerThread start];
}

- (void)executeTask:(CFPermenantThreadTask)task {
    if (!self.innerThread || !task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stopThread {
    if (!self.innerThread) return;
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

#pragma mark -- private methods
- (void)__stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(CFPermenantThreadTask)task {
    task();
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
