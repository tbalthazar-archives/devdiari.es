
@implementation Twitterer : CPActiveRecord
{
    // You need to define the attributes you want to have in your cappuccino model.
    CPString        twittererId     @accessors;
    CPString        name            @accessors;
    CPString        screenName      @accessors;
    CPString        location        @accessors;
    CPString        profileImageUrl @accessors;
}

// Define the layout for saving a record. This will be called on -save.
- (JSObject)attributes
{
    return {
        'twitterer': {
            'screen_name': screenName
        }
    }
}

@end
