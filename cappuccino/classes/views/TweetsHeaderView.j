
@import <AppKit/CPView.j>


@implementation TweetsHeaderView : CPView
{
    CPSearchField   tweetsSearchField;
}

- (void)awakeFromCib
{
    // set the background color
    var bgColor = [CPColor colorWithPatternImage:[[CPImage alloc]
                          initWithContentsOfFile:[[CPBundle mainBundle]
                                 pathForResource:@"images/bg-tweets-header.png"]]]
    
    [self setBackgroundColor:bgColor];
    
    // create the search field
    var searchFieldWidth = 200.0;
    var searchFieldRightMargin = 10.0;
    
    var xPosition = CGRectGetWidth([self bounds]) - searchFieldWidth - searchFieldRightMargin;

    tweetsSearchField = [[CPSearchField alloc] initWithFrame:CGRectMake(xPosition, 14, 200.0, 30.0)];
    [tweetsSearchField setAutoresizingMask:CPViewMinXMargin];
    [tweetsSearchField setEditable:YES];
    [tweetsSearchField setPlaceholderString:@"Search Tweets"];
    [tweetsSearchField setBordered:YES];
    [tweetsSearchField setBezeled:YES];
    [tweetsSearchField setTarget:self];
    [tweetsSearchField setAction:@selector(performSearch:)];
    [tweetsSearchField setSendsWholeSearchString:YES];
    
    [self addSubview:tweetsSearchField];
}

- (void)performSearch:(id)aSender
{
    // console.log('-- performSearch :' + [aSender stringValue]);
    [[CPNotificationCenter defaultCenter] postNotificationName:@"SearchPerformed" object:[aSender stringValue]];
}

@end
