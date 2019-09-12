//
//  FlickrFeedItem.h
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/11/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlickrFeedItem : NSObject

- (instancetype) initWithDictionary:(NSDictionary*)dictionary;

@property (readonly) NSString* title;
@property (readonly) NSString* link;
@property (readonly) NSString* media;
@property (readonly) NSDate* date_taken;
@property (readonly) NSString* item_description;
@property (readonly) NSDate* published;
@property (readonly) NSString* author;
@property (readonly) NSString* author_id;
@property (readonly) NSString* tags;

@end

NS_ASSUME_NONNULL_END
