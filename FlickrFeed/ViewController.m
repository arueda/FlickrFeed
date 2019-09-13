//
//  ViewController.m
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/11/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import "ViewController.h"
#import "FlickrFeedItem.h"
#import "FlickrFeedItemViewController.h"

@interface ViewController ()

@property UIPageViewController* pageController;
@property NSArray* items;
@property NSUInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    // Do any additional setup after loading the view.
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    UIViewController *initialViewController = [[FlickrFeedItemViewController alloc] initWithNibName:@"FlickrFeedItemViewController" bundle:nil];   
    
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    NSURLSessionTask* dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError* serializationError;
        NSDictionary* feed = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serializationError];
        
        if(serializationError) {
            NSLog(@"error: %@", serializationError);
        } else {
            self.items = [feed objectForKey:@"items"];
        }
        
    }];
    
    [dataTask resume];
    
    
}

#pragma mark - UIPageViewControllerDelegate

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [self.items count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (self.index < 0) {
        return nil;
    }
    
    FlickrFeedItem* item = [[FlickrFeedItem alloc] initWithDictionary:[self.items objectAtIndex:self.index--]];
    
    FlickrFeedItemViewController* before = [[FlickrFeedItemViewController alloc] initWithItem:item];
    
    return before;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if (self.index == [self.items count]) {
        return nil;
    }
    
    FlickrFeedItem* item = [[FlickrFeedItem alloc] initWithDictionary:[self.items objectAtIndex:self.index++]];
    FlickrFeedItemViewController* after = [[FlickrFeedItemViewController alloc] initWithItem:item];
    
    return after;
}

@end
