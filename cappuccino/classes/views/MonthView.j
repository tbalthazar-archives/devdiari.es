
@import <AppKit/CPView.j>


@implementation MonthView : DefaultCollectionViewItem
{
    
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
    [label setStringValue:representedObject];
}

@end
