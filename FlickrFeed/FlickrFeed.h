//
//  FlickrFeed.h
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/12/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlickrFeed : NSObject

- (instancetype) initWithString:(NSString*)string;

- (void) refreshWithHandler:(void(^)(NSArray* items))handler;

@end

NS_ASSUME_NONNULL_END
