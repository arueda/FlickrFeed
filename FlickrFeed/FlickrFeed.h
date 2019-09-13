//
//  FlickrFeed.h
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/12/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This class represents the Flickr Feed API
 
 Only one method is currently supported
 */
@interface FlickrFeed : NSObject

/**
 Creates the FlickrFeed object.
 
 @param string : A String representing the base URL
 */
- (instancetype) initWithString:(NSString*)string;

/**
 Invokes services/feeds/photos_public.gne to retrieve the public Feed
 
 @param handler : a block in charge of receiving the list of items inside the feed
 */
- (void) refreshWithHandler:(void(^)(NSArray* items))handler;

@end

NS_ASSUME_NONNULL_END
