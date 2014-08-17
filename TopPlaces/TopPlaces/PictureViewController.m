//
//  PictureViewController.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/16/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "PictureViewController.h"
#import "FlickrFetcher.h"
#import "RecentPicturesArray.h"

@interface PictureViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) RecentPicturesArray *recentPictures;

@end

@implementation PictureViewController

#pragma mark - LazyInstantiation

- (RecentPicturesArray *) recentPictures
{
    if (!_recentPictures)
        _recentPictures = [[RecentPicturesArray alloc] init];
    
    return _recentPictures;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.5;
    
    //get picture from URL
    CGSize photoSize = [self.imageView.image size];
    self.imageView.frame = CGRectMake(0, 0, photoSize.width, photoSize.height);
    [self startDownloadingImage];
    
    self.scrollView.contentSize = photoSize;

    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:2];
    navCon.navigationItem.title = self.selectedPhoto.photoTitle;

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
    
    if(self.selectedPhoto.photoURL)
    {
        [self.activityIndicator startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.selectedPhoto.photoURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
            if (!error)
            {
                if ([request.URL isEqual:self.selectedPhoto.photoURL])
                {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = image;
                        [self.activityIndicator stopAnimating]; 
                    });
                }
            }
        }];
        [task resume];
        [self saveToUserDefaults];
    }
}

#pragma mark - Methods

- (void)saveToUserDefaults
{
    BOOL alreadyInArray = NO;
    
    // make sure the viewed picture hasn't already been stored
    // go through array looking to see if the photo URL has already been stored
    for (NSDictionary *dict in self.recentPictures.recentPhotosDictArray)
        if (![self.selectedPhoto.photoURL isEqual:[dict objectForKey:@"photourl"]])
            alreadyInArray = NO;
        else
        {
            alreadyInArray = YES;
            break;
        }
    
    // if the photo URL hasn't been stored, store and save changes to NSUserDefaults
    if (!alreadyInArray)
    {
        //save viewed photo to recentPictures dictionary
        [self.recentPictures.recentPhotosDict setObject:self.selectedPhoto.countryName forKey:@"countryName"];
        [self.recentPictures.recentPhotosDict setObject:self.selectedPhoto.districtName forKey:@"districtName"];
        [self.recentPictures.recentPhotosDict setObject:self.selectedPhoto.countryName forKey:@"countryName"];
        [self.recentPictures.recentPhotosDict setObject:self.selectedPhoto.photoURL forKey:@"photourl"];
        [self.recentPictures.recentPhotosDict setObject:self.selectedPhoto.photoTitle forKey:@"photoTitle"];
        
        [self.recentPictures.recentPhotosDictArray addObject:self.recentPictures.recentPhotosDict];
        
        //save to NSUserDefaults
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedPictures"];
        [[NSUserDefaults standardUserDefaults] setObject:self.recentPictures.recentPhotosDictArray forKey:@"savedPictures"];
        [[NSUserDefaults standardUserDefaults] synchronize];
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
