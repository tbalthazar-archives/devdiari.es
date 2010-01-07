
@import <AppKit/CPView.j>


@implementation TwittererView : DefaultCollectionViewItem
{
    
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
    [label setStringValue:[representedObject screenName]];
}

@end
