
@implementation TweetsController : CPObject
{
    CPArray                 tweets                  @accessors;
    CPCollectionView        tweetsCollectionView    @accessors;
    CPCollectionViewItem    currentObject           @accessors;
    CPView                  loadingIndicator        @accessors;
    
    CPString                currentLocalDBTwittererId;
    CPString                currentTwittererId;
    CPString                currentTwittererScreenName;
    CPString                currentYear;
    CPString                currentMonth;
    CPString                searchTerms;
}

- (id)init
{
    self = [super init] ;
    
    if (self)
    {
        currentLocalDBTwittererId   = @"";
        currentTwittererId          = @"";
        currentTwittererScreenName  = @"";
        currentYear                 = @"";
        currentMonth                = @"";
        searchTerms                 = @"";
        
        [Tweet addObserver:self selector:@selector(tweetsDidLoad:)];
        
        [[CPNotificationCenter defaultCenter ]
            addObserver:self
               selector:@selector(twittererChanged:)
                   name:@"SelectedTwittererChanged" 
                 object:nil];

        [[CPNotificationCenter defaultCenter ]
            addObserver:self
               selector:@selector(monthChanged:)
                   name:@"SelectedMonthChanged" 
                 object:nil];

        [[CPNotificationCenter defaultCenter ]
            addObserver:self
               selector:@selector(searchPerformed:)
                   name:@"SearchPerformed" 
                 object:nil];

        [[CPNotificationCenter defaultCenter ]
            addObserver:self
               selector:@selector(openTweet:)
                   name:@"TweetDoubleClicked" 
                 object:nil];
    }
    
    return self ;
}

- (void)tweetsDidLoad:(CPNotification)aNotification
{
    // console.log('-- tweetsDidLoad');
    
    // get all the tweets so we can determine the most recent year and month to display
    // tweets = [Tweet find:{ all: true}];
    // tweets = [TweetsController sort:tweets];
    
    //console.log('-- the most recent tweet :' + [tweets[0] year] + "/" + [tweets[0] month]);
    
    // var allTweets = [Tweet find:{ all: true}];
    // console.log('-- total nb tweets :' + [allTweets count]);
    // console.log('-- first tweet date :' + [allTweets[0] year] + "/" + [allTweets[0] month]);
    
    [[CPNotificationCenter defaultCenter] postNotificationName:@"TweetsDidLoad"
                                                        object:nil];
}

- (void)twittererChanged:(id)aNotification
{    
    tweets = [];
    [tweetsCollectionView setContent:tweets];
    [[tweetsCollectionView superview] addSubview:loadingIndicator];
    
    var twitterer   = [aNotification object];
    currentLocalDBTwittererId = [twitterer identifier];
        
    currentTwittererId = [twitterer twittererId];
    currentTwittererScreenName = [twitterer screenName];
}

- (void)monthChanged:(id)aNotification
{
    var currentDate = [aNotification object];
    currentYear     = [currentDate substringWithRange:CPMakeRange(0,4)];
    currentMonth    = [currentDate substringWithRange:CPMakeRange(5,2)];
    
    [self displayTweets];
}

- (void)searchPerformed:(id)aNotification
{
    searchTerms = [aNotification object];;

    var conditions = {
        twittererId: currentTwittererId,
        year: currentYear,
        month: currentMonth,
        text: searchTerms
    }
    
    tweets = [Tweet find:{ all: true, conditions: conditions }];
    
    tweets = [TweetsController sort:tweets];
    
    [tweetsCollectionView setContent:tweets];
}

- (void)displayTweets
{
    var conditions = {
        twittererId: currentTwittererId,
        year: currentYear,
        month: currentMonth,
        text: searchTerms
    }
    
    tweets = [Tweet find:{ all: true, conditions: conditions }];    
    tweets = [TweetsController sort:tweets];
    
    if ([tweets count]===0)
    {
        var placeHolderTweet = [[Tweet alloc] init];
        [placeHolderTweet setText:@"This dev doesn't tweet much. Try to go back in time."];
        [tweets addObject:placeHolderTweet];
    }
    
    [tweetsCollectionView setContent:tweets];
    [loadingIndicator removeFromSuperview];
    
    console.log('-- tweets (#'  + [tweets count]
                                + ') will display, for : '
                                + currentTwittererScreenName
                                + "("
                                + currentTwittererId
                                + ") on : "
                                + currentYear
                                + "/"
                                + currentMonth);
}

- (void)openTweet:(id)aNotification
{
    if ([currentObject tweetId]!==nil)
        window.open("http://twitter.com/" + currentTwittererScreenName + "/status/" + [currentObject tweetId]);
}

- (void)collectionViewDidChangeSelection:(CPCollectionView)collectionView
{
    var selectedIndex = [[collectionView selectionIndexes] firstIndex];
    currentObject = [[collectionView content] objectAtIndex:selectedIndex];
}

+ (CPArray)sort:(CPArray)tweets
{
    var sortDescriptor = [[CPSortDescriptor alloc] initWithKey:@"createdAt"
                                                     ascending:NO
                                                      selector:@selector(compare:)];
                                                      
    var descriptors = [CPArray arrayWithObjects:sortDescriptor, nil];
                                                      
    return [tweets sortedArrayUsingDescriptors:descriptors];
}


@end