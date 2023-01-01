//
//  Foundation.h
//  HorrorStory
//
//  Created by liu ya yun on 2023/1/1.
//

//#ifndef Foundation_h
//#define Foundation_h
//
//
//#endif /* Foundation_h */

#import <Foundation/Foundation.h>

//防止数据越界
@interface NSArray (DXIndexCheckArray)

- (id)objectAtIndexCheck:(NSUInteger)index;

@end
#import "NSArray+DXIndexCheckArray.h"

@implementation NSArray (DXIndexCheckArray)

- (id)objectAtIndexCheck:(NSUInteger)index{
    if (index > self.count) {
        return  nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return  nil;
    }
    return value;
}

@end
