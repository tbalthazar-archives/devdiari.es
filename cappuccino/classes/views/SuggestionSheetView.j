
@import <AppKit/CPWindow.j>


@implementation SuggestionSheetView : CPWindow
{
    CPTextField             suggestionLabel;
    CPTextField             suggestionTextField @accessors;
    SuggestionsController   suggestionsController @accessors;
    CPButton                okButton;
    CPButton                cancelButton;
}

- (void)setSuggestionsController:(SuggestionsController)aSuggestionsController
{
    suggestionsController = aSuggestionsController;
    [okButton setTarget:suggestionsController];
    [cancelButton setTarget:suggestionsController];
}

- (id)init
{
    self = [super initWithContentRect:CGRectMake(0,0,300,135)
                            styleMask:CPDocModalWindowMask];
    
    if (self)
    {
        var sheetContent = [self contentView];

        suggestionLabel = [[CPTextField alloc] initWithFrame:CGRectMake(10, 30, 280, 25)];
        [suggestionLabel setStringValue:@"Want to suggest a dev diary?"];


        suggestionTextField = [[CPTextField alloc] initWithFrame:CGRectMake(10,55,280,30)];
        [suggestionTextField setPlaceholderString:@"@deviary"];
        [suggestionTextField setEditable:YES];
        [suggestionTextField setBezeled:YES];
        [suggestionTextField setAutoresizingMask:CPViewWidthSizable];

        okButton = [[CPButton alloc] initWithFrame:CGRectMake(230,95,50,24)];
        [okButton setTitle:"OK"];
        // [okButton setTarget:suggestionsController];
        [okButton setTag:1];
        [okButton setAction:@selector(suggestTwitterer:)];
        [okButton setAutoresizingMask:CPViewMinXMargin | CPViewMinYMargin]; 

        cancelButton = [[CPButton alloc] initWithFrame:CGRectMake(120,95,100,24)];
        [cancelButton setTitle:"Cancel"];
        // [cancelButton setTarget:suggestionsController];
        [cancelButton setTag:0];
        [cancelButton setAction:@selector(closeSheet:)];    
        [cancelButton setAutoresizingMask:CPViewMinXMargin | CPViewMinYMargin]; 

        [sheetContent addSubview:suggestionLabel];
        [sheetContent addSubview:suggestionTextField];
        [sheetContent addSubview:okButton];
        [sheetContent addSubview:cancelButton];
    }
    
    return self;
}

- (void)showConfirmMessage
{
    console.log('-- should show a confirm message');
    [okButton setTitle:@"Close"];
    [okButton setAction:@selector(closeSheet:)];
    
    [cancelButton removeFromSuperview];
    [suggestionTextField removeFromSuperview];

    [suggestionLabel setFrame:CGRectMake(10, 30, 280, 50)];
    [suggestionLabel setStringValue:@"Your suggestion has been sent.\nThanks!"];
}


@end
