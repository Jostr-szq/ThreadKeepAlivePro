//
//  ViewController.m
//  ThreadKeepAlivePro
//
//  Created by jcf on 2023/6/15.
//

#import "ViewController.h"
#import "CFPermenantThread.h"

@interface ViewController ()

@property (nonatomic, strong) CFPermenantThread *perThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.perThread = [[CFPermenantThread alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.perThread executeTask:^{
        NSLog(@"子线程执行任务 - %@",[NSThread currentThread]);
    }];
}

- (IBAction)startAction:(id)sender {
    [self.perThread startThread];
}
- (IBAction)cloesdAction:(id)sender {
    [self.perThread stopThread];
}

-(void)dealloc {
    NSLog(@"%s",__func__);
}

@end
