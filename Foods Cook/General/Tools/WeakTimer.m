//
//  WeakTimer.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/11/2.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "WeakTimer.h"

@interface WeakTimer()

@property (nonatomic, weak)id target;
@property (nonatomic, weak)NSTimer *timer;
@property (nonatomic, assign)SEL selector;

@end

@implementation WeakTimer

+ (NSTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval
                           target:(id)aTarget
                         selector:(SEL)aSelector
                         userInfo:(id)aUserInfo
                          repeats:(BOOL)aRepeats
{
    WeakTimer *weakTimer = [[WeakTimer alloc] init];
    weakTimer.target = aTarget;
    weakTimer.selector = aSelector;
    weakTimer.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:weakTimer selector:@selector(fire:) userInfo:aUserInfo repeats:aRepeats];
    return weakTimer.timer;
}

- (void)fire:(NSTimer *)timer{
    if (self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.f];
    }else{
        [self.timer invalidate];
    }
}

@end
