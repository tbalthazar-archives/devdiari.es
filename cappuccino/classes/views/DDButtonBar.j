
@import <AppKit/CPView.j>


@implementation DDButtonBar : CPView
{
    CPButton addButton;
    SuggestionsController suggestionsController;
}

- (void)setSuggestionsController:(SuggestionsController)aSuggestionsController
{
    suggestionsController = aSuggestionsController
    [addButton setTarget:aSuggestionsController];
    [addButton setAction:@selector(displaySheet:)];    
}

- (void)awakeFromCib
{
    // button bar
    var bgColor = [CPColor colorWithPatternImage:[[CPImage alloc]
                          initWithContentsOfFile:[[CPBundle mainBundle]
                                 pathForResource:@"images/bg-button-bar.png"]]];
  
    [self setBackgroundColor:bgColor];

    var addImage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:@"images/add-button.png"]];
    [addImage setSize:CGSizeMake(31,23)];
    var addImagePressed = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:@"images/add-button-pressed.png"]];
    [addImage setSize:CGSizeMake(31,23)];
    
    
    addButton = [[CPButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 31.0, 23.0)];
    [addButton setTitle:@"?"];
    [addButton setBordered:NO];
    [addButton setImage:addImage];
    [addButton setAlternateImage:addImagePressed];
    [addButton setImagePosition:CPImageOnly];

    [self addSubview:addButton];

}

@end
