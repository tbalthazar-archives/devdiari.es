
@implementation YearsController : CPObject
{
    CPArray                 years               @accessors;
    CPCollectionView        yearsCollectionView @accessors;
    CPCollectionViewItem    currentObject       @accessors;
}

- (id)initWithViewController:(CPCollectionView)collectionView
{
    self = [super init] ;
    
    if (self)
    {
        [[CPNotificationCenter defaultCenter ]
            addObserver:self
               selector:@selector(tweetsDidLoad:)
                   name:@"TweetsDidLoad" 
                 object:nil];
        
        yearsCollectionView = collectionView;
    }
    
    return self ;
}

- (void)tweetsDidLoad:(id)aNotificaiton
{
    [yearsCollectionView setContent:[@"2010", @"2009", @"2008", @"2007"]];
    [yearsCollectionView setSelectionIndexes:[[CPIndexSet alloc] initWithIndex:0]];
}

- (void)collectionViewDidChangeSelection:(CPCollectionView)collectionView
{
    var selectedIndex = [[collectionView selectionIndexes] firstIndex];
    currentObject = [[collectionView content] objectAtIndex:selectedIndex];
    
    [[CPNotificationCenter defaultCenter] postNotificationName:@"SelectedYearChanged" object:currentObject];
}

@end