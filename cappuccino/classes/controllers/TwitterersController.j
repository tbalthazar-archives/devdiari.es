
@implementation TwitterersController : CPObject
{
    CPArray                 twitterers                  @accessors;
    CPCollectionView        twitterersCollectionView    @accessors;
    CPCollectionViewItem    currentObject               @accessors;
    CPImageView             twittererImageView          @accessors;
}

- (id)init
{
    self = [super init] ;
    
    if (self)
    {
        twittererImage = [[CPImage alloc] init];
        [Twitterer addObserver:self selector:@selector(twitterersDidLoad:)];
    }
    
    return self ;
}

- (void)twitterersDidLoad:(CPNotification)aNotification
{
    twitterers = [Twitterer find:{ all: true }];
    
    var sortDescriptor = [[CPSortDescriptor alloc] initWithKey:@"screenName"
                                                     ascending:YES
                                                      selector:@selector(compare:)];
                                                      
    var descriptors = [CPArray arrayWithObjects:sortDescriptor, nil];
                                                      
    twitterers = [twitterers sortedArrayUsingDescriptors:descriptors];
    

    [twitterersCollectionView setContent:twitterers];
    [twitterersCollectionView setSelectionIndexes:[[CPIndexSet alloc] initWithIndex:0] ];
}

// when a new record is saved
- (void)twittererDidLoad:(CPNotification)aNotification
{
    [Twitterer reload];
}

- (void)collectionViewDidChangeSelection:(CPCollectionView)collectionView
{
    var selectedIndex = [[collectionView selectionIndexes] firstIndex];
    currentObject = [[collectionView content] objectAtIndex:selectedIndex];
    
    var image = [[CPImage alloc] initWithContentsOfFile:[currentObject profileImageUrl]];
    [twittererImageView setImage:image];
    
    var currentLocalDBTwittererId = [currentObject identifier];
        
    [[CPNotificationCenter defaultCenter] postNotificationName:@"SelectedTwittererChanged" object:currentObject];

    [Tweet setCurrentTwittererId:currentLocalDBTwittererId];
    [Tweet reload];
}



@end