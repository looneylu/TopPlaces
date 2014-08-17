//
//  PictureViewController.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/16/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "PictureViewController.h"
#import "FlickrFetcher.h"

@interface PictureViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PictureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.5;
    
    //get picture from URL
//    NSData *data = [NSData dataWithContentsOfURL:self.url];
    CGSize photoSize = [self.imageView.image size];
    self.imageView.frame = CGRectMake(0, 0, photoSize.width, photoSize.height);
//    self.imageView.image = [[UIImage alloc] initWithData:data];
    [self startDownloadingImage];
    
    self.scrollView.contentSize = photoSize;

    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:2];
    navCon.navigationItem.title = self.photoTitle;

}

#pragma mark - Delegate Methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - Methods

- (void) startDownloadingImage
{
    //downloads image in a different thread to avoid blocking main thread
    self.imageView.image = nil;
    
    if(self.url)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
            if (!error)
            {
                if ([request.URL isEqual:self.url])
                {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = image;
                    });
                }
            }
        }];
        [task resume];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
