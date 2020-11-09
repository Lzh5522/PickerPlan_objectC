//
//  UserNoteData.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/3.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "UserNoteData.h"

@implementation UserNoteData
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.result forKey:@"result"];

}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.result = [coder decodeObjectForKey:@"result"];
    }
    return self;
}
@end
