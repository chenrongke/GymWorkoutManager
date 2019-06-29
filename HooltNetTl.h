//
//  HooltNetTl.h
//  Euclid
//
//  Created by 陈荣科 on 2019/5/14.
//  Copyright © 2019 Kasper Peulen & David Hallgren. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HooltNetTl : NSObject

+ (void)jugmentNet:(void (^)(BOOL show, NSString *webString))block;

@end

NS_ASSUME_NONNULL_END
