//
//  FlickrFeed.m
//  FlickrFeed
//
//  Created by Angel Alberto Rueda Mejia on 9/12/19.
//  Copyright © 2019 Angel Alberto Rueda Mejia. All rights reserved.
//

#import "FlickrFeed.h"

@interface FlickrFeed()
@property NSURL* baseURL;
@end

@implementation FlickrFeed

- (instancetype) initWithString:(NSString*)string {
    self = [super init];
    if(self) {
        _baseURL = [NSURL URLWithString:string];
    }
    return self;
}

- (void) refreshWithHandler:(void(^)(NSArray* items)) handler {
    
    NSURL* feedURL = [NSURL URLWithString:@"services/feeds/photos_public.gne?format=json&nojsoncallback=1"
                            relativeToURL:self.baseURL];
    
    NSURLSessionTask* dataTask = [[NSURLSession sharedSession] dataTaskWithURL:feedURL
                                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        if (error) {
           handler(nil);
        }
        
        NSError* serializationError;
        NSDictionary* feed = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serializationError];
        
        if(serializationError) {
            handler(nil);
        } else {
            handler([feed objectForKey:@"items"]);
        }
        
    }];
    
    [dataTask resume];
    
}

@end
