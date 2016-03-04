//
//  TQWordModle.m
//  9.23听书
//
//  Created by 童裳强 on 15/9/23.
//  Copyright © 2015年 ellemoi_alami. All rights reserved.
//

#import "TQWordModle.h"

@implementation TQWordModle


-(instancetype)initWithdict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}


+(instancetype)WordModelWithdict:(NSDictionary *)dict{
    return [[self alloc] initWithdict:dict];
}

@end
