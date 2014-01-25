//
//  TutorialPageViewController.m
//  Stronghold Locator
//
//  Created by Winston Weinert on 1/15/14.
//  Copyright (c) 2014 Winston Weinert. All rights reserved.
//

#import "TutorialPageViewController.h"

@interface TutorialPageViewController ()

@end

@implementation TutorialPageViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pages = @[
                   [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"Tutorial 1"],
                   [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"Tutorial 2"],
                   [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"Tutorial 3"]
                   ];
    NSLog(@"%s: %@", __func__, self.pages);
    self.dataSource = self;
    [self setViewControllers:@[self.pages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    // Why make it complicated? Don't test pageViewController == self!
    NSUInteger pageNumber = [self.pages indexOfObject:viewController];
    if (pageNumber == 0) {
        return nil;
    } else {
        return self.pages[pageNumber - 1];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger pageNumber = [self.pages indexOfObject:viewController];
    if (pageNumber == [self.pages count] - 1) {
        return nil;
    } else {
        return self.pages[pageNumber + 1];
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pages indexOfObject:self.viewControllers[0]];
}
@end
