//
//  FlickrFeedItem.m
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/11/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import "FlickrFeedItem.h"

@interface FlickrFeedItem()
@end


@implementation FlickrFeedItem

@dynamic description;

- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    if(self) {
        // description can´t be used since it's a NSObject property.
        // rename the value on the dictionary to item_description
        NSMutableDictionary* mutableDictionary = [dictionary mutableCopy];
        NSString* itemDescription = mutableDictionary[@"description"];
        mutableDictionary[@"description"] = nil;
        mutableDictionary[@"item_description"] = itemDescription;
        
        [self setValuesForKeysWithDictionary:mutableDictionary];
    }
    return self;
}

@end
