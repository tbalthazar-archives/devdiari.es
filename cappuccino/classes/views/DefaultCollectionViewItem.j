
@import <AppKit/CPView.j>


@implementation DefaultCollectionViewItem : CPView
{
    @outlet CPTextField label;
    CPColor bgColor;
    CPColor selectedBgColor;
    CPColor textShadowColor;
    CPColor selectedTextShadowColor;
}

- (void)setRepresentedObject:(id)representedObject
{
    bgColor                 = [CPColor colorWithHexString:@"f3f7fb"];
    
    selectedBgColor         = [CPColor colorWithPatternImage:[[CPImage alloc]
                                      initWithContentsOfFile:[[CPBundle mainBundle]
                                             pathForResource:@"images/bg-CollectionViewItem.png"]]]
                                     
    textShadowColor         = [CPColor colorWithRed:255.0 / 255.0
                                              green:255.0 / 255.0
                                               blue:255.0 / 255.0
                                              alpha:1.0];
    
    selectedTextShadowColor = [CPColor colorWithRed:0.0 / 255.0
                                              green:0.0 / 255.0
                                               blue:0.0 / 255.0
                                              alpha:0.5];
    
    
    [label setTextColor:[CPColor blackColor]];
    [label setTextShadowColor:textShadowColor];
    [label setTextShadowOffset:CGSizeMake(0.0, 0.5)];
    [label setVerticalAlignment:CPCenterVerticalTextAlignment];

    [self setBackgroundColor:bgColor];
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? selectedBgColor : bgColor];
    [label setTextColor:isSelected ? [CPColor whiteColor] : [CPColor blackColor]];
    [label setTextShadowColor:isSelected ? selectedTextShadowColor : textShadowColor];
    [label setTextShadowOffset:isSelected ? CGSizeMake(0.0, -1.5) : CGSizeMake(0.0, 0.5)];
}

@end
