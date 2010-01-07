
@import <AppKit/CPView.j>


@implementation HeaderView : CPView
{
    CPTextField headerTitle;
    CPButton    aboutButton;
}

- (void)awakeFromCib
{
    // header title
    var bgColor = [CPColor colorWithPatternImage:[[CPImage alloc]
                          initWithContentsOfFile:[[CPBundle mainBundle]
                                 pathForResource:@"images/bg-header-view.png"]]];
        
    var textShadowColor = [CPColor colorWithRed:255.0 / 255.0
                                          green:255.0 / 255.0        
                                           blue:255.0 / 255.0        
                                          alpha:0.8];                
    
    [self setBackgroundColor:bgColor];
    
    headerTitle = [[CPTextField alloc] initWithFrame:CGRectMake(16, 3, 0, 0)];
    
    [headerTitle setStringValue:@"devdiari.es"];
    [headerTitle setFont:[CPFont boldSystemFontOfSize:16.0]];
    [headerTitle setTextShadowColor:textShadowColor];
    [headerTitle setTextShadowOffset:CGSizeMake(0.0, 0.5)];
    [headerTitle setVerticalAlignment:CPCenterVerticalTextAlignment];
    [headerTitle sizeToFit];
    
    [self addSubview:headerTitle];
    
    // about button
    var headerWidth = [self bounds].size.width;
    aboutButton = [[CPButton alloc] initWithFrame:CGRectMake(headerWidth - 50.0 - 16.0, 3.0, 50.0, 24.0)];
    [aboutButton setAutoresizingMask:CPViewMinXMargin];
    [aboutButton setTitle:@"about"];
    [aboutButton setTarget:self];
    [aboutButton setAction:@selector(about:)];
    
    [self addSubview:aboutButton];
}

- (void)about:(id)sender
{
    window.open("http://suitmymind.com");
}

@end
