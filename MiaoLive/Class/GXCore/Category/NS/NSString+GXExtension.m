//
//  NSString+GXExtension.m
//  GXWeibo
//
//  Created by ailimac100 on 15/9/23.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "NSString+GXExtension.h"

@implementation NSString (GXExtension)
- (CGSize)sizeWithFont:(UIFont*)font maxWidth:(CGFloat)max
{
    
    NSMutableDictionary * attrsDic = [NSMutableDictionary dictionary];
    attrsDic[NSFontAttributeName]  = font;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode            = NSLineBreakByWordWrapping;
    attrsDic[NSParagraphStyleAttributeName] = paragraphStyle.copy;

    CGSize nameSize = [self boundingRectWithSize:CGSizeMake(max, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrsDic context:nil].size;
    
    return nameSize;
}
- (CGSize)sizeWithFont:(UIFont*)font
{
    return [self sizeWithFont:font maxWidth:MAXFLOAT];
}

@end
