//
//  SGPurchaseItem.m
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGPurchaseItem.h"

@implementation SGPurchaseItem


NSString * const KEY_TITLE             = @"title";
NSString * const KEY_ARTIST            = @"artist";
NSString * const KEY_RELEASED_ON       = @"releasedOn";
NSString * const KEY_TRACK_ID          = @"trackID";
NSString * const KEY_TRACK_IMAGE_URL   = @"imageURL";
NSString * const KEY_IMAGE             = @"image";

- (id) initWithTitle:(NSString*) inTitle artest:(NSUInteger) inArtist releasedOn:(NSDate*) inDate
             trackId:(NSUInteger) inTrackId
            imageURL:(NSString*) inImageURL
{
    self = [self init];
    
    _title        = inTitle;
    _artistId     = inArtist;
    _releasedDate = inDate;
    _trackID      = inTrackId;
    _imageURL     = inImageURL;
    
    return self;
}

#pragma mark -
#pragma mark encoding

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    
    _title        = [aDecoder decodeObjectForKey:KEY_TITLE];
    _artistId     = (NSUInteger) [aDecoder decodeIntegerForKey:KEY_ARTIST];
    _releasedDate = [aDecoder decodeObjectForKey:KEY_RELEASED_ON];
    _trackID      = (NSUInteger) [aDecoder decodeIntegerForKey:KEY_TRACK_ID];
    _imageURL     = [aDecoder decodeObjectForKey:KEY_TRACK_IMAGE_URL];
    
    if([aDecoder containsValueForKey:KEY_IMAGE])
    {
        _image = [aDecoder decodeObjectForKey:KEY_IMAGE];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:KEY_TITLE];
    [aCoder encodeInteger:_artistId forKey:KEY_ARTIST];
    [aCoder encodeObject:_releasedDate forKey:KEY_RELEASED_ON];
    [aCoder encodeInteger:_trackID forKey:KEY_TRACK_ID];
    [aCoder encodeObject:_imageURL forKey:KEY_TRACK_IMAGE_URL];
    
    if(_image)
    {
        [aCoder encodeObject:_image forKey:KEY_IMAGE];
    }
    
}

#pragma mark -
#pragma mark image loading

- (BFTask*) loadImage      //Used by Swift, so false positive about this method not begin used.
{
    BFTaskCompletionSource *completionSource = [BFTaskCompletionSource taskCompletionSource];

    if (self.image)
    {
        [completionSource setResult:self.image];
        return completionSource.task;
    }

    NSURL *url = [[NSURL alloc] initWithString:self.imageURL];

    NSError *error;
    NSData *imageData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedAlways error:&error];

    if(error)
    {
        [completionSource setError:error];
    }
    else
    {
        UIImage *image = [UIImage imageWithData:imageData];
        self.image = image;
        [completionSource setResult:image];
    }

    return completionSource.task;
}

#pragma mark -
#pragma mark equals / hash

- (NSUInteger) hash
{
	NSUInteger prime = 31;
	NSUInteger result = 1;
	
	result = prime * (result + _trackID);
	
	return result;
}

- (BOOL) isEqual:(id) other
{
	if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToWidget:other];
}

- (BOOL)isEqualToWidget:(SGPurchaseItem *) inItem
{
    if (self == inItem)
        return YES;
	
    return (self.trackID == inItem.trackID);
}


@end
