
@implementation SuggestionsController : CPObject
{
    SuggestionsSheetView    suggestionSheet     @accessors;
    CPWindow                window              @accessors;
    CPTextField             suggestionTextField;
}

- (id)init
{
    self = [super init] ;
    
    if (self)
    {
    }
    
    return self ;
}

- (void)displaySheet:(id)sender
{
    suggestionTextField = [suggestionSheet suggestionTextField];
    
    [suggestionTextField setStringValue:""];
    [suggestionSheet makeFirstResponder:suggestionTextField];

    [CPApp beginSheet:suggestionSheet modalForWindow:window modalDelegate:self didEndSelector:@selector(didEndSheet:returnCode:contextInfo:) contextInfo:nil];
}

- (void)suggestTwitterer:(id)sender
{
    var str = [suggestionTextField stringValue];

    var twitterer = [Twitterer new:{ screen_name:str }];
    [twitterer save];
    
    [suggestionSheet showConfirmMessage];
}

- (void)closeSheet:(id)sender
{
    [CPApp endSheet:suggestionSheet returnCode:[sender tag]];
}

- (void)didEndSheet:(CPWindow)sheet returnCode:(int)returnCode contextInfo:(id)contextInfo
{
    [sheet orderOut:self];
}


@end