
@import <AppKit/CPView.j>


@implementation YearView : DefaultCollectionViewItem
{

}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
    [label setStringValue:representedObject];
}

@end
