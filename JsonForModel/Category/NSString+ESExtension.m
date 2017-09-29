//
//  NSString+ESExtension.m
//  ESJsonFormat
//
//  Created by 尹桥印 on 15/7/4.
//  Copyright (c) 2015年 EnjoySR. All rights reserved.
//

#import "NSString+ESExtension.h"

@implementation NSString (ESExtension)

- (NSString *)substringWithStartStr:(NSString *)start endStr:(NSString *)endStr{
    NSString *resultStr = nil;
    NSRange range;
    NSRange tempRange = [self rangeOfString:start];
    if (tempRange.location !=NSNotFound) {
        range.location = tempRange.location+tempRange.length;
        tempRange = [self rangeOfString:endStr];
        if (tempRange.location!=NSNotFound) {
            range.length = tempRange.location-range.location;
            return [self substringWithRange:range];
        }
    }
    return resultStr;
}
- (NSString *)convert{
    
    
    NSString *tmp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    tmp = [tmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    tmp = [tmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    tmp = [tmp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    return tmp;
}


/** 判断是不是整数 */
- (BOOL)isPureInt{
    
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

/*判断是否为浮点形*/
- (BOOL)isPureFloat{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

/**判断是不是 long long 长整数 */
- (BOOL)isPureLongLong{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    long long val;
    
    return [scan scanLongLong:&val] && [scan isAtEnd];
    
}

/**判断是不是 Bool 长整数 */
- (BOOL)isPureBool{
    
    NSString *tmp = [self capitalizedString];
    
    
    if ([tmp isEqualToString:@"TURE"] || [tmp isEqualToString:@"FALSE"] || [tmp isEqualToString:@"YES"] || [tmp isEqualToString:@"NO"]) {
        
        return YES;
    }
    
    return NO;
}

/** 去掉相同的类 */
- (BOOL)isNewClassWithInterfaceClassName:(NSString *)interfaceClassName{
    
    NSArray *tmp = [self componentsSeparatedByString:interfaceClassName];
    
    //如果没有发现，或者没有分割，就是 只有 1
    return tmp.count == 1;
}

- (NSString *)perferCharCapitalizedString{
    
    NSString *tmp = [self substringToIndex:1];
    
    tmp = [tmp capitalizedString];
    
    return [NSString stringWithFormat:@"%@%@", tmp, [self substringFromIndex:1]];
    
}


- (NSString *)documentPath{
    
    
    
    return [self stringByDeletingLastPathComponent];
    
}
@end
