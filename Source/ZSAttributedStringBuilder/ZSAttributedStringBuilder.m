//
//  ZSAttributedStringBuilder.m
//  Epayment
//
//  Created by safiri on 2018/6/14.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSAttributedStringBuilder.h"


@implementation ZSAttributedStringBuilder
{
    NSMutableAttributedString *attrString;
    NSInteger paragraphIndex;
}

+ (ZSAttributedStringBuilder *)builderWithNormalString:(NSString *)string
{
    return [[ZSAttributedStringBuilder alloc] initWithNormalString:string];
}

- (id)initWithNormalString:(NSString *)string
{
    self = [self init];
    if (self != nil)
    {
        if (string != nil) {
            attrString = [[NSMutableAttributedString alloc] initWithString:string];
        }else {
            attrString = nil;
        }
            
        paragraphIndex = 0;
    }
    
    return self;
}
+ (ZSAttributedStringBuilder *)builderWithString:(NSString *)string forDocumentType:(ZSSourceStringDocumentType)type
{
    return [[ZSAttributedStringBuilder alloc] initWithString:string forDocumentType:type];
}
- (id)initWithString:(NSString *)string forDocumentType:(ZSSourceStringDocumentType)type
{
    self = [super init];
    if (self != nil) {
        if (string) {
            switch (type) {
                case ZSNormalTextDocumentType:
                    attrString = [[NSMutableAttributedString alloc] initWithString:string];
                    break;
                case ZSPlainTextDocumentType:
                    attrString = [[NSMutableAttributedString alloc]initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSPlainTextDocumentType} documentAttributes:nil error:nil];
                    break;
                case ZSRTFTextDocumentType:
                    attrString = [[NSMutableAttributedString alloc]initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSRTFTextDocumentType} documentAttributes:nil error:nil];
                    break;
                case ZSRTFDTextDocumentType:
                    attrString = [[NSMutableAttributedString alloc]initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSRTFDTextDocumentType} documentAttributes:nil error:nil];
                    break;
                case ZSHTMLTextDocumentType:
                    attrString = [[NSMutableAttributedString alloc]initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                    break;
                default:
                    break;
            }
        }else {
            attrString = nil;
        }
    }
    return self;
}

- (ZSAttributedStringRange *)range:(NSRange)range
{
    if (attrString == nil)
        return nil;
    
    if (attrString.length < range.location + range.length)
        return nil;
    
    
    ZSAttributedStringRange *attrstrrang = [[ZSAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    [attrstrrang addRange:range];
    return attrstrrang;
}

- (ZSAttributedStringRange *)allRange
{
    if (attrString == nil)
        return nil;
    
    NSRange range = NSMakeRange(0, attrString.length);
    return [self range:range];
}

- (ZSAttributedStringRange *)lastRange
{
    if (attrString == nil)
        return nil;
    
    NSRange range = NSMakeRange(attrString.length - 1, 1);
    return [self range:range];
}

- (ZSAttributedStringRange *)lastNRange:(NSInteger)length
{
    if (attrString == nil)
        return nil;
    
    return [self range:NSMakeRange(attrString.length - length, length)];
}


- (ZSAttributedStringRange *)firstRange
{
    if (attrString == nil)
        return nil;
    
    NSRange range = NSMakeRange(0, attrString.length > 0 ? 1 : 0);
    return [self range:range];
}

- (ZSAttributedStringRange *)firstNRange:(NSInteger)length
{
    if (attrString == nil)
        return nil;
    
    return [self range:NSMakeRange(0, length)];
}

- (ZSAttributedStringRange *)characterSet:(NSCharacterSet*)characterSet
{
    if (attrString == nil)
        return nil;
    
    
    //遍历所有字符，然后计算数值
    ZSAttributedStringRange *attrstrrang = [[ZSAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    
    
    NSString *str = attrString.string;
    NSRange range = NSMakeRange(0, 0);
    BOOL isStart = YES;
    for (int i = 0; i < str.length; i++)
    {
        unichar uc  = [str characterAtIndex:i];
        if ([characterSet characterIsMember:uc])
        {
            if (isStart)
            {
                range.location = i;
                range.length = 0;
                isStart = NO;
            }
            
            range.length++;
        }
        else
        {
            if (!isStart)
            {
                isStart = YES;
                
                [attrstrrang addRange:range];
            }
        }
    }
    
    if (!isStart)
        [attrstrrang addRange:range];
    
    return attrstrrang;
}


- (ZSAttributedStringRange *)searchString:(NSString *)searchString options:(NSStringCompareOptions)options all:(BOOL)all
{
    if (attrString == nil)
        return nil;
    
    
    ZSAttributedStringRange *attRange = [[ZSAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    NSString *str = attrString.string;
    if (!all)
    {
        return [self range:[str rangeOfString:searchString options:options]];
    }
    else
    {
        NSRange searchRange = NSMakeRange(0, str.length);
        NSRange range = NSMakeRange(0, 0);
        
        while(range.location != NSNotFound && searchRange.location < str.length)
        {
            range = [str rangeOfString:searchString options:options range:searchRange];
            [attRange addRange:range];
            if (range.location != NSNotFound)
            {
                searchRange.location = range.location + range.length;
                searchRange.length = str.length - searchRange.location;
            }
        }
        
        
    }
    
    return attRange;
    
}

- (ZSAttributedStringRange *)includeString:(NSString *)includeString all:(BOOL)all
{
    return [self searchString:includeString options:0 all:all];
}

- (ZSAttributedStringRange *)regularExpression:(NSString *)regularExpression all:(BOOL)all
{
    return [self searchString:regularExpression options:NSRegularExpressionSearch all:all];
}




- (ZSAttributedStringRange *)firstParagraph
{
    if (attrString == nil)
        return nil;
    
    
    paragraphIndex = 0;
    
    NSString *str = attrString.string;
    NSRange range = NSMakeRange(0, 0);
    NSInteger i;
    for (i = paragraphIndex; i < str.length; i++)
    {
        unichar uc = [str characterAtIndex:i];
        if (uc == '\n')
        {
            range.location =  0;
            range.length = i + 1;
            paragraphIndex = i + 1;
            break;
        }
    }
    
    if (i >= str.length)
    {
        range.location = 0;
        range.length = i;
        paragraphIndex = i;
    }
    
    
    return [self range:range];
}

- (ZSAttributedStringRange *)nextParagraph
{
    if (attrString == nil)
        return nil;
    
    NSString *str = attrString.string;
    
    if (paragraphIndex >= str.length)
        return nil;
    
    
    NSRange range = NSMakeRange(0, 0);
    NSInteger i;
    for (i = paragraphIndex; i < str.length; i++)
    {
        unichar uc = [str characterAtIndex:i];
        if (uc == '\n')
        {
            range.location =  paragraphIndex;
            range.length = i - paragraphIndex + 1;
            paragraphIndex = i + 1;
            break;
        }
    }
    
    if (i >= str.length)
    {
        range.location = paragraphIndex;
        range.length = i - paragraphIndex;
        paragraphIndex = i + 1;
    }
    
    
    return [self range:range];
}


-(void)insert:(NSInteger)pos attrstring:(NSAttributedString *)attrstring
{
    if (attrString == nil || attrstring == nil)
        return;
    
    if (pos == -1)
        [attrString appendAttributedString:attrstring];
    else
        [attrString insertAttributedString:attrstring atIndex:pos];
}

-(void)insert:(NSInteger)pos attrBuilder:(ZSAttributedStringBuilder *)attrBuilder
{
    [self insert:pos attrstring:attrBuilder.commit];
}

-(NSAttributedString*)commit
{
    return attrString;
}
/// MARK: - 其他类方法
/// 计算指定宽度的字符串高度
+ (CGFloat)calculateShowHeightForAttributedString:(NSAttributedString *)attributedString withShowWidth:(CGFloat)width {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect =[attributedString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:nil];
    CGFloat height = ceilf(rect.size.height);
    return height;
}
@end
