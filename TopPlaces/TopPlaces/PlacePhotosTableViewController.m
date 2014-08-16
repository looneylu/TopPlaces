//
//  PlacePhotosTableViewController.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/16/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "PlacePhotosTableViewController.h"
#import "TopPlaces.h"
#import "PictureViewController.h"

@interface PlacePhotosTableViewController ()

@property (nonatomic, strong) TopPlaces *placePictures;
@property (nonatomic, strong) NSArray *photoURLs;
@property (nonatomic, strong) NSArray *photoDictArray;
@property (nonatomic, strong) NSURL *url;

@end

@implementation PlacePhotosTableViewController

#pragma mark - Lazy Instantiation

- (TopPlaces *)placePictures
{
    if (!_placePictures)
        _placePictures = [[TopPlaces alloc] init];
    return _placePictures;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.photoDictArray = [[NSArray alloc] initWithArray:[self.placePictures queryForPhotos:self.placeID]];
//    NSLog(@"There are %i entries in array", [self.photoDictArray count]);
//    NSLog(@"%@", self.photoDictArray);
    self.photoURLs = [[NSArray alloc] initWithArray:[self.placePictures retrievePhotoURLs]];
//    NSLog(@"There are %i URLs", [self.photoURLs count]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photoURLs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    // use the picture title to label cell
    // if the picture doesn't have a title, use its description
    // if it doesn't have a description either, label it Untitled"
    if ([[[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"title"] length] > 0)
        cell.textLabel.text = [[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    else if ([[[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"description._content"] length] > 0)
        cell.textLabel.text = [[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"description._content"];
    else
        cell.textLabel.text = @"Untitled";
    
    // use picture's description for cell subtitle
    // if there is no description, label it "No Detail"
    if ([[[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"description._content"] length] > 0)
        cell.detailTextLabel.text = [[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"description._content"];
    else
        cell.detailTextLabel.text = @"No Detail";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the picture URL for picture at indexPath
    self.url = [self.photoURLs objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"toImageView" sender:indexPath];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toImageView"])
    {
        NSIndexPath *indexPath = sender;
        PictureViewController *pictureVC = segue.destinationViewController;
        pictureVC.url = self.url;
        // if it doesn't have a description either, label it Untitled"
        if ([[[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"title"] length] > 0)
            pictureVC.photoTitle = [[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"title"];
        else if ([[[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"description._content"] length] > 0)
            pictureVC.photoTitle = [[self.photoDictArray objectAtIndex:indexPath.row] objectForKey:@"description._content"];
        else
            pictureVC.photoTitle = @"Untitled";
        NSLog(@"%@", pictureVC.photoTitle); 
    }
}


@end
