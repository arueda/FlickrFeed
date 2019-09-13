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

- (instancetype) initWithItem:(FlickrFeedItem*)item;

@property (weak) IBOutlet UILabel* titleLabel;
@property (weak) IBOutlet UIImageView* imageView;

@end

NS_ASSUME_NONNULL_END
