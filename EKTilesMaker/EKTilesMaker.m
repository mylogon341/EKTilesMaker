//
//  EKTileMaker.m
//  EKTilesMakerDemo
//
//  Created by Evgeniy Kirpichenko on 2/3/14.
//  Copyright (c) 2014 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKTilesMaker.h"

#import "UIImage+EKTilesMaker.h"

@interface EKTilesMaker ()
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic) dispatch_group_t group;
@end

@implementation EKTilesMaker

#pragma mark - life cycle

- (id)init
{
   if (self = [super init]) {
      [self setOutputFileType:OutputFileTypePNG];
      
      [self setQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
      [self setGroup:dispatch_group_create()];
   }
   return self;
}

#pragma mark - public

- (void)createTiles:(UIImage *)sourceImage cols:(int)cols rows:(int)rows size:(CGSize)size tiles:(void (^)(NSArray<UIImage *> *, CGRect))tilesCallback{
   __block NSMutableArray <UIImage*>* images = [NSMutableArray new];
   
   //calculate zoom that aspect fits grid size
   float heightRatio = size.height/sourceImage.size.height;
   float widthRatio = size.width/sourceImage.size.width;
   float scaleRatio = sourceImage.size.height > sourceImage.size.width ? heightRatio : widthRatio;
   
   dispatch_async(self.queue, ^{
      
      float tWidth = sourceImage.size.width/cols;
      float tHeight = sourceImage.size.height/rows;

      CGRect tileRect = CGRectMake(0, 0,
                                   floor(scaleRatio * tWidth),
                                   floor(scaleRatio * tHeight));
      
      for (int r=0; r<rows; r++) {
         for (int c =0; c<cols; c++) {
            
            CGRect tileFrame = CGRectMake(tWidth * c, tHeight * r, tWidth, tHeight);
            UIImage *tileImage = [sourceImage imageInRect:tileFrame];
            [images addObject:tileImage];
         }
      }
      
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
         tilesCallback(images.copy,tileRect);
         images = nil;
      }];
      
      dispatch_group_wait(self.group, DISPATCH_TIME_FOREVER);
   });
   
}

@end
