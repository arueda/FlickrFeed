//
//  FlickrFeedItemViewController.m
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/12/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import "FlickrFeedItemViewController.h"

@interface FlickrFeedItemViewController ()

@property FlickrFeedItem* item;

@end

@implementation FlickrFeedItemViewController

- (instancetype) initWithItem:(FlickrFeedItem*)item {
    self = [super initWithNibName:@"FlickrFeedItemViewController" bundle:nil];
    if(self) {
        _item = item;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.item.title;
    
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
