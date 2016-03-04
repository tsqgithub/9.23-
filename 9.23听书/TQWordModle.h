//
//  TQWordModle.h
//  9.23听书
//
//  Created by 童裳强 on 15/9/23.
//  Copyright © 2015年 ellemoi_alami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQWordModle : NSObject

@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) double time;
-(instancetype)initWithdict:(NSDictionary *)dict;
+(instancetype)WordModelWithdict:(NSDictionary *)dict;





@end
