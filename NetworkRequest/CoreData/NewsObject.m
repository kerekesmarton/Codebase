//
//  NewsObject.m
//  Festival
//
//  Created by Jozsef-Marton Kerekes on 3/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "NewsObject.h"


@implementation NewsObject

@dynamic title;
@dynamic desc;
@dynamic del;
@dynamic read;
@dynamic timeStamp;
@dynamic uid;

+ (id)addWithParams:(NSDictionary *)params forManagedObjectContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", [params objectForKey:@"id"]];
    
//    Check if news exists.
    NewsObject *news = (NewsObject *)[self fetchForPredicate:predicate forManagedObjectContext:context];
    if ([news isKindOfClass:[NSArray class]]) {
        news = [(NSArray*)news lastObject];
    }
    if (news != nil) {
//        If user previously marked it as deleted, don't add it again.
        if ([news.del boolValue]) {
            return nil;
        }
        return [self editWithParams:params forObject:news];
    } else {
        return [self syncWithParams:params forManagedObjectContext:context];
    }
}

+ (id)setInformationFromDictionary:(NSDictionary *)params forObject:(NSManagedObject *)object
{
    NewsObject *news = (NewsObject *)object;
    
    news.title = [[params objectForKey:newsTitleKey] isKindOfClass:[NSNull class]] ? news.title : [params objectForKey:newsTitleKey];
    
//    news.link = [[params objectForKey:newsLinkKey] isKindOfClass:[NSNull class]] ? news.link : [params objectForKey:newsLinkKey];
    
    news.desc = [[params objectForKey:newsDescriptionKey] isKindOfClass:[NSNull class]] ? news.desc : [params objectForKey:newsDescriptionKey];
    
    news.del = [[params objectForKey:newsDeleted] isKindOfClass:[NSNull class]] ? news.del : [params objectForKey:newsDeleted];
    
    //    news.read <-don't set this on dictionary init!
    
    news.timeStamp = [[params objectForKey:newsTimeStamp] isKindOfClass:[NSNull class]] ? news.timeStamp : [params objectForKey:newsTimeStamp];
    
    news.uid = [[params objectForKey:@"id"] isKindOfClass:[NSNull class]] ? news.uid : [params objectForKey:@"id"];
    
    return news;
}

+(NSArray *)fetchUndeletedNews {
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class]) withPredicate:[NSPredicate predicateWithFormat:@"del == %@", @NO] forContext:[VICoreDataManager getInstance].managedObjectContext];
    return [results sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(NewsObject *)obj1 timeStamp] compare:[(NewsObject *)obj2 timeStamp]] * (-1);
    }];
}

+(NSArray *)fetchNews {
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class])];
    return [results sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(NewsObject *)obj1 timeStamp] compare:[(NewsObject *)obj2 timeStamp]] * (-1);
    }];
}

-(void)markAsDeleted {
    
    self.del = @YES;
    [[VICoreDataManager getInstance] saveContext:self.managedObjectContext];
}
@end
