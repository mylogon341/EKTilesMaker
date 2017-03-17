//
//  EKTileMaker.h
//  EKTilesMakerDemo
//
//  Created by Evgeniy Kirpichenko on 2/3/14.
//  Copyright (c) 2014 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OutputFileType)
{
   OutputFileTypePNG,
   OutputFileTypeJPG
};

/**
 Class that create tiles based on the provided source image
 */
@interface EKTilesMaker : NSObject

- (void)createTiles:(UIImage*)originalImage
               cols:(int)cols
               rows:(int)rows
               size:(CGSize)size
              tiles:(void(^)(NSArray<UIImage*>*,CGRect tileRect))tiles;


/**
 Image type of tiles. Provide OutputfileTypePNG for storing tiles in png format or
 OutputfileTypePNG for storing tiles as jpg. Default value is OutputfileTypePNG
 */
@property (nonatomic) OutputFileType outputFileType;


@end
