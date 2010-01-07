/*
 * AppController.j
 * devdiaries-cappuccino
 *
 * Created by Thomas Balthazar on November 24, 2009.
 * Copyright 2009, Suit My Mind SPRL All rights reserved.
 */

@import <Foundation/CPObject.j>

// custom views
@import "classes/views/HeaderView.j"
@import "classes/views/DefaultCollectionViewItem.j"
@import "classes/views/TweetsHeaderView.j"
@import "classes/views/DDButtonBar.j"

// suggestions
@import "classes/controllers/SuggestionsController.j"
@import "classes/views/SuggestionSheetView.j"

// twitterers
@import "classes/controllers/TwitterersController.j"
@import "classes/views/TwittererView.j"
@import "classes/models/Twitterer.j"

// years
@import "classes/views/YearView.j"
@import "classes/controllers/YearsController.j"

// months
@import "classes/views/MonthView.j"
@import "classes/controllers/MonthsController.j"

// tweets
@import "classes/models/Tweet.j"
@import "classes/views/TweetView.j"
@import "classes/controllers/TweetsController.j"

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow; //this "outlet" is connected automatically by the Cib
    @outlet HeaderView          headerView;
    @outlet CPCollectionView    twitterersCollectionView;
    @outlet CPCollectionView    yearsCollectionView;
    @outlet CPCollectionView    monthsCollectionView;
    @outlet CPCollectionView    tweetsCollectionView;
    @outlet TweetsHeaderView    tweetsHeaderView;
    @outlet CPImageView         twittererImageView;
    @outlet DDButtonBar         buttonBar;
    @outlet CPView              loadingIndicator;    
    
    CPArray                     twitterers;
    SuggestionSheetView         suggestionSheet;
    // CPTextField                 suggestionTextField;
    SuggestionsController       suggestionsController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var twitterersController = [[TwitterersController alloc] init];
    [twitterersController setTwitterersCollectionView:twitterersCollectionView];
    [twitterersController setTwittererImageView:twittererImageView];  
    [twitterersCollectionView setDelegate:twitterersController];
 
    var tweetsController = [[TweetsController alloc] init];
    [tweetsController setTweetsCollectionView:tweetsCollectionView];
    [tweetsController setLoadingIndicator:loadingIndicator];
    [tweetsCollectionView setDelegate:tweetsController];
        
    var yearsController = [[YearsController alloc] initWithViewController:yearsCollectionView];
    [yearsController setYearsCollectionView:yearsCollectionView];
    [yearsCollectionView setDelegate:yearsController];

    var monthsController = [[MonthsController alloc] initWithViewController:monthsCollectionView];
    [monthsController setMonthsCollectionView:monthsCollectionView];
    [monthsCollectionView setDelegate:monthsController];
    
    suggestionsController = [[SuggestionsController alloc] init];
    [suggestionsController setSuggestionSheet:suggestionSheet];
    [suggestionsController setWindow:theWindow];
    [suggestionSheet setSuggestionsController:suggestionsController];
    [buttonBar setSuggestionsController:suggestionsController];
}

- (void)awakeFromCib
{    
    suggestionSheet = [[SuggestionSheetView alloc] init];
    
    // ---- colleciton views
    [twitterersCollectionView setMaxNumberOfColumns:1];
    [twitterersCollectionView setVerticalMargin:0];
    [twitterersCollectionView setSelectable:YES];
    [twitterersCollectionView setItemPrototype:[[CPCollectionViewItem alloc] initWithCibName:@"TwittererView"
                                                                                      bundle:nil]];
    [twitterersCollectionView setMinItemSize:CGSizeMake(135, 25)];
    [twitterersCollectionView setMaxItemSize:CGSizeMake(150, 25)];

    [yearsCollectionView setBackgroundColor:[CPColor colorWithHexString:@"f3f7fb"]];
    [[yearsCollectionView superview] setBackgroundColor:[CPColor colorWithHexString:@"f3f7fb"]];
    [yearsCollectionView setMaxNumberOfColumns:1];
    [yearsCollectionView setVerticalMargin:0];
    [yearsCollectionView setSelectable:YES];
    [yearsCollectionView setItemPrototype:[[CPCollectionViewItem alloc] initWithCibName:@"YearView"
                                                                                 bundle:nil]];
    [yearsCollectionView setMinItemSize:CGSizeMake(135, 25)];
    [yearsCollectionView setMaxItemSize:CGSizeMake(1000, 25)];    

    [monthsCollectionView setBackgroundColor:[CPColor colorWithHexString:@"f3f7fb"]];
    [[monthsCollectionView superview] setBackgroundColor:[CPColor colorWithHexString:@"f3f7fb"]];
    [monthsCollectionView setMaxNumberOfColumns:1];
    [monthsCollectionView setVerticalMargin:0];
    [monthsCollectionView setSelectable:YES];
    [monthsCollectionView setItemPrototype:[[CPCollectionViewItem alloc] initWithCibName:@"MonthView"
                                                                                  bundle:nil]];
    [monthsCollectionView setMinItemSize:CGSizeMake(135, 25)];
    [monthsCollectionView setMaxItemSize:CGSizeMake(1000, 25)];

    [tweetsCollectionView setMaxNumberOfColumns:1];
    [tweetsCollectionView setVerticalMargin:0];
    [tweetsCollectionView setSelectable:YES];
    [tweetsCollectionView setItemPrototype:[[CPCollectionViewItem alloc] initWithCibName:@"TweetView"
                                                                                  bundle:nil]];
    [tweetsCollectionView setMinItemSize:CGSizeMake(400, 25)];
    [tweetsCollectionView setMaxItemSize:CGSizeMake(5000, 25)];
    
    var tweetsScrollView = [tweetsCollectionView superview];
    [loadingIndicator setFrame:[tweetsScrollView frame]];
    [tweetsScrollView addSubview:loadingIndicator];
}


@end
