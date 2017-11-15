//
//  WeakTimer.h
//  Foods Cook
//
//  Created by 邓莎 on 2017/11/2.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakTimer : NSObject

+ (NSTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)aUserInfo
                                     repeats:(BOOL)aRepeats;

@end
