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

- (void)createTiles:(UIImage *)sourceImage tiles:(void (^)(NSArray<UIImage *> *))tiles
{
    NSAssert(self.tileSize.width > 0 && self.tileSize.height > 0, @"Invalid tile size was specified");
   
   NSMutableArray <UIImage*>* images = [NSMutableArray new];
   
    dispatch_async(self.queue, ^{
        
       NSUInteger column = 0;
       CGFloat offsetX = 0;
       
       while (offsetX < sourceImage.size.width) {
          NSUInteger row = 0;
          NSUInteger offsetY = 0;
          
          while (offsetY < sourceImage.size.height) {
             CGRect tileFrame = CGRectMake(offsetX, offsetY, self.tileSize.width, self.tileSize.height);
             
             UIImage *tileImage = [sourceImage imageInRect:tileFrame];
             [images addObject:tileImage];
      
             row += 1;
             offsetY += self.tileSize.height;
          }
          
          column += 1;
          offsetX += self.tileSize.width;
       }
       
       [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          tiles(images.copy);
       }];
       
       dispatch_group_wait(self.group, DISPATCH_TIME_FOREVER);
    });
}

@end
