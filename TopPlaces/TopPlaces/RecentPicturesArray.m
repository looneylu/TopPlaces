//
//  RecentPicturesArray.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/17/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "RecentPicturesArray.h"

@implementation RecentPicturesArray

#pragma mark - Lazy Instantiation

- (NSMutableDictionary *) recentPhotosDict
{
    if (!_recentPhotosDict)
        _recentPhotosDict = [[NSMutableDictionary alloc] init];
    
    return _recentPhotosDict;
}

- (NSMutableArray *) recentPhotosDictArray
{
    if (!_recentPhotosDictArray)
        _recentPhotosDictArray = [[NSMutableArray alloc] init];
    
    return _recentPhotosDictArray;
}

@end
