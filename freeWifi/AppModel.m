//
//  AppModel.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/3.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSComparisonResult)compareByDistance:(AppModel *)amodel
{
    if ( [self.distance floatValue] > [amodel.distance floatValue])
    {
        return  NSOrderedDescending;
    }
    else if ([self.distance floatValue] == [amodel.distance floatValue])
    {
        return NSOrderedSame;
    }
    else
    {
        return NSOrderedAscending;
    }
}
@end
