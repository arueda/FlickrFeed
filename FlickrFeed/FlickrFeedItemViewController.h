//
//  FlickrFeedItemViewController.h
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/12/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFeedItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrFeedItemViewController : UIViewController

/**
 Creates a FlickrFeedItemViewController
 
 @param item A FlickrFeedItem
 */
- (instancetype) initWithItem:(FlickrFeedItem*)item;

@property (assign, nonatomic) NSInteger pageIndex;

@end

NS_ASSUME_NONNULL_END
