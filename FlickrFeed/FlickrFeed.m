//
//  FlickrFeed.m
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/11/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import "FlickrFeed.h"
#import "FlickrFeedItem.h"

@interface FlickrFeed()
{
    NSArray<FlickrFeedItem*>* _itemArray;
}
@end

@implementation FlickrFeed

- (instancetype) initWithArray:(NSArray*)array {
    self = [super init];
    
    if(self) {
        _itemArray = [NSArray arrayWithArray:array];
    }
    
    return self;
}

@end
