//
//  FlickrFeedItemViewController.m
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/12/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import "FlickrFeedItemViewController.h"

@interface FlickrFeedItemViewController ()

@property (weak) IBOutlet UILabel* titleLabel;
@property (weak) IBOutlet UIImageView* imageView;
@property FlickrFeedItem* item;

@end

@implementation FlickrFeedItemViewController

/**
 Creates a FlickrFeedItemViewController
 
 @param item A FlickrFeedItem
 */
- (instancetype) initWithItem:(FlickrFeedItem*)item {
    
    self = [super initWithNibName:@"FlickrFeedItemViewController" bundle:nil];
    if(self) {
        _item = item;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.item == nil) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* media = self.item.media[@"m"];
        NSData* data = [[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:media]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:[UIImage imageWithData:data]];
        });
        
    });
    
    NSString* title = self.item.title;
    [self.titleLabel setText:title];
    
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
