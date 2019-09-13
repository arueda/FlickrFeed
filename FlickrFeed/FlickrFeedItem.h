//
//  FlickrFeedItem.h
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/11/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/*
 Class that describes an Item from the Flickr Feed
 */
@interface FlickrFeedItem : NSObject

/**
 Creates an item from a dictionary.
 
 @param dictionary A dictionary decoded from JSONSerialization
 */
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;

@property (readonly) NSString* title;
@property (readonly) NSString* link;
@property (readonly) NSDictionary* media;
@property (readonly) NSDate* date_taken;
@property (readonly) NSString* item_description;
@property (readonly) NSDate* published;
@property (readonly) NSString* author;
@property (readonly) NSString* author_id;
@property (readonly) NSString* tags;

@end

NS_ASSUME_NONNULL_END
