var TweetCurrentTwittererId;

@implementation Tweet : CPActiveRecord
{
    // You need to define the attributes you want to have in your cappuccino model.
    CPString        twittererId @accessors;
    CPString        text        @accessors;
    CPString        createdAt   @accessors;
    CPString        tweetId     @accessors;
}

+ (void)setCurrentTwittererId:(CPString)aTwittererId
{
    TweetCurrentTwittererId = aTwittererId;
}

+ (CPString)currentTwittererId
{
    return TweetCurrentTwittererId;
}

+ (CPURL)resourcesPath
{
    if (!TweetCurrentTwittererId)
        return nil;
        
    var urlString = [Twitterer resourcesPath];
    urlString += '/' + TweetCurrentTwittererId;
    urlString += @"/" + [[self className] lowercaseString] + @"s";

    return [CPURL URLWithString:urlString];
}

- (int)year
{
    return [createdAt substringWithRange:CPMakeRange(0,4)];
}

- (int)month
{
    return [createdAt substringWithRange:CPMakeRange(5,2)];
}

- (int)day
{
    return [createdAt substringWithRange:CPMakeRange(8,2)];
}

// Define the layout for saving a record. This will be called on -save.
- (JSObject)attributes
{
    return {
        'tweet': {
            'text': text
        }
    }
}

@end
