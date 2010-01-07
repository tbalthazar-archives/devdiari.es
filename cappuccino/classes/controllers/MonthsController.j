
@implementation MonthsController : CPObject
{
    CPArray                 months                  @accessors;
    CPCollectionView        monthsCollectionView    @accessors;
    CPCollectionViewItem    currentObject           @accessors;
    CPString                selectedYear;
}

- (id)initWithViewController:(CPCollectionView)collectionView
{
    self = [super init] ;
    
    if (self)
    {
        [[CPNotificationCenter defaultCenter ]
            addObserver:self
               selector:@selector(yearChanged:)
                   name:@"SelectedYearChanged" 
                 object:nil];
        
        monthsCollectionView = collectionView;
    }
    
    return self;
}

- (void)collectionViewDidChangeSelection:(CPCollectionView)collectionView
{
    var selectedIndex = [[collectionView selectionIndexes] firstIndex];
    currentObject = [[collectionView content] objectAtIndex:selectedIndex];
    var currentDate = selectedYear + '/' + currentObject;
    
    [[CPNotificationCenter defaultCenter] postNotificationName:@"SelectedMonthChanged" object:currentDate];
}

- (void)yearChanged:(id)aNotification
{
    selectedYear            = [aNotification object];
    var today               = new Date;
    var currentYear         = today.getFullYear();
    var currentMonth        = today.getMonth() + 1;
    var maxMonth            = currentYear==selectedYear ? currentMonth : 12;
    var currentMonthIndex   = 0;
    var content             = [[CPArray alloc] init];
            
    for(i=1;i<=maxMonth;i++)
    {
        var month = i < 10 ? ("0" + i) : i;
        [content insertObject:month atIndex:0];
    }
    
    [monthsCollectionView setContent:content];
    [monthsCollectionView setSelectionIndexes:[[CPIndexSet alloc] initWithIndex:currentMonthIndex]];
}

@end