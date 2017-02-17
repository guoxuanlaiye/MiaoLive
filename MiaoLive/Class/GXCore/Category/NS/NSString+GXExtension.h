//
//  NSString+GXExtension.h
//  GXWeibo
//
//  Created by ailimac100 on 15/9/23.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (GXExtension)

- (CGSize)sizeWithFont:(UIFont*)font maxWidth:(CGFloat)max;
- (CGSize)sizeWithFont:(UIFont*)font;

@end
