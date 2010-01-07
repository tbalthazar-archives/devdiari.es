
@import <AppKit/CPView.j>


@implementation TweetView : DefaultCollectionViewItem
{
    
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
        
    bgColor = [CPColor colorWithHexString:@"FFFFFF"];
    [self setBackgroundColor:bgColor];
    
    var tweetText = [representedObject text];
    tweetText = tweetText.replace(/\n/g, " ");
    
    var day     = [representedObject day],
        month   = [representedObject month];
    
    [label setLineBreakMode:CPLineBreakByTruncatingTail];
    
    if (day!==nil && month!==nil)
    {
        [label setStringValue:month + "/" + day + " : " + tweetText];
    }
    else
    {
        [label setStringValue:tweetText];
    }
}

- (void)mouseDown:(CPEvent)anEvent
{
    if ([anEvent clickCount] > 1)
    {
        [[CPNotificationCenter defaultCenter] postNotificationName:@"TweetDoubleClicked"
                                                            object:nil];
        
    }
    else
    {
        [super mouseDown:anEvent];
    }
}


@end
