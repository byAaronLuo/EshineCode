//
//  NSString+MMUtil.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/18.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "NSString+MMUtil.h"

@implementation NSString (MMUtil)
-(NSString *)getEnglishLettersAtIdex:(NSUInteger)idex{
    
    switch (idex) {
        case 0:
            return @"A";
            break;
        case 1:
            return @"B";
            break;
        case 2:
            return @"C";
            break;
        case 3:
            return @"D";
            break;
        case 4:
            return @"E";
            break;
        case 5:
            return @"F";
            break;
        case 6:
            return @"G";
            break;
        case 7:
            return @"H";
            break;
            
        default:
            return @"A";
            break;
    }
}


@end
