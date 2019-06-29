//
//  HooltNetTl.m
//  Euclid
//
//  Created by 陈荣科 on 2019/5/14.
//  Copyright © 2019 Kasper Peulen & David Hallgren. All rights reserved.
//

#import "HooltNetTl.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AFNetworking/AFNetworking.h>

@implementation HooltNetTl

+ (void)jugmentNet:(void (^)(BOOL show, NSString *webString))block{
    
    AVACL *acl = [AVACL ACL];
    [acl setPublicReadAccess:YES];
    AVQuery *query = [AVQuery queryWithClassName:@"GymWork"];
    [query getObjectInBackgroundWithId:@"5d02740aba39c8328bfa9816" block:^(AVObject *object, NSError *error) {
        BOOL can = [[object objectForKey:@"showNib"] boolValue];
        NSString *wrbstr = [object objectForKey:@"sktUrl"];
        
        block(can,wrbstr);
    }];
}

@end
