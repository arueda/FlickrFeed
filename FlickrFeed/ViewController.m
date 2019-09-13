//
//  ViewController.m
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/11/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import "ViewController.h"
#import "FlickrFeed.h"
#import "FlickrFeedItem.h"
#import "FlickrFeedItemViewController.h"

@interface ViewController ()

@property (weak) IBOutlet UIActivityIndicatorView* activityIndicatorView;
@property (weak) IBOutlet UILabel* pullToRefreshLabel;

@property UIPageViewController* pageController;
@property NSArray* items;

@property FlickrFeed* feed;
@property CAShapeLayer* shapeLayer;

/**
 Gets a FlickrFeedItemViewController based on the given index
 
 @param pageIndex the index of the page to retrieve.
 */
- (FlickrFeedItemViewController *)viewControllerWithPageIndex:(NSInteger)pageIndex;

/**
 Creates a UIPageViewController and loads it as a childViewController
 
 This method runs on the main thread.
 */
- (void) attachPageViewController;

/**
 Triggers a Flickr feed refresh
 */
- (void) refresh;

/**
 Creates a CALayer that the user can pull to refresh
 */
- (void) addReloadControl;

/**
 Invoked when the user pulls to refresh
 */
- (void) panGestureDidMove:(UIPanGestureRecognizer*) gesture;

@end

#pragma mark - Implementation
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicatorView.layer.cornerRadius = 5;
    self.activityIndicatorView.layer.masksToBounds = true;
    
    [self addReloadControl];
    
    self.feed = [[FlickrFeed alloc] initWithString:@"https://api.flickr.com/"];
    
    [self refresh];
}

- (void) addReloadControl {
    
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 80);
    self.shapeLayer.backgroundColor = [[UIColor colorWithRed:57/255.0
                                                       green:67/255.0
                                                        blue:89/255.0
                                                       alpha:1.0] CGColor];
    self.shapeLayer.zPosition = -1;
    [self.view.layer addSublayer:self.shapeLayer];
    
    UIPanGestureRecognizer* gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(panGestureDidMove:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (void) panGestureDidMove:(UIPanGestureRecognizer*) gesture {
    
    CGRect temp = self.shapeLayer.frame;
    
    if(gesture.state == UIGestureRecognizerStateEnded ||
       gesture.state == UIGestureRecognizerStateFailed ||
       gesture.state == UIGestureRecognizerStateCancelled) {
        temp.size.height = 80;
        [self refresh];
    } else {
        temp.size.height = 80 + MAX([gesture translationInView:self.view].y, 0);
    }
    self.shapeLayer.frame = temp;
    
}

- (void) refresh {
    
    [self.pullToRefreshLabel setHidden:YES];
    [self.activityIndicatorView startAnimating];
    // TODO: this makes the screen blink. Fix it.
    [self.pageController removeFromParentViewController];
    
    [self.feed refreshWithHandler:^(NSArray *items) {
        
        self.items = items;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pullToRefreshLabel setHidden:NO];
            [self.activityIndicatorView stopAnimating];
        });
        
        [self attachPageViewController];
        
    }];
    
}

- (FlickrFeedItemViewController *)viewControllerWithPageIndex:(NSInteger)pageIndex {
    if (pageIndex < 0 || pageIndex >= [self.items count]) {
        return nil;
    }
    
    FlickrFeedItem* item = [[FlickrFeedItem alloc] initWithDictionary:[self.items objectAtIndex:pageIndex]];
    FlickrFeedItemViewController *viewController = [[FlickrFeedItemViewController alloc] initWithItem:item];
    viewController.pageIndex = pageIndex;
    
    return viewController;
}

- (void) attachPageViewController {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        self.pageController.dataSource = self;
        [[self.pageController view] setFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height-150)];
        
        UIViewController *initialViewController = [self viewControllerWithPageIndex:0];
        
        [self.pageController setViewControllers:@[initialViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
        
        [self addChildViewController:self.pageController];
        [[self view] addSubview:[self.pageController view]];
        [self.pageController didMoveToParentViewController:self];
        
    });
}

#pragma mark - UIPageViewControllerDelegate

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.items count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return [(FlickrFeedItemViewController *)pageViewController.presentedViewController pageIndex];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    FlickrFeedItemViewController *vc = (FlickrFeedItemViewController *)viewController;
    NSUInteger index = vc.pageIndex;
    return [self viewControllerWithPageIndex:(index - 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    FlickrFeedItemViewController *vc = (FlickrFeedItemViewController *)viewController;
    NSUInteger index = vc.pageIndex;
    return [self viewControllerWithPageIndex:(index + 1)];
    
}

@end
