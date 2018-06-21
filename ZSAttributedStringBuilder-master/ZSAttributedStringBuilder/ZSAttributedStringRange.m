//
//  ZSAttributedStringRange.m
//  Epayment
//
//  Created by safiri on 2018/6/14.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSAttributedStringRange.h"

@interface ZSAttributedStringRange ()

@property (nonatomic ,strong) NSMutableArray *ranges;

@property (nonatomic ,strong) NSMutableAttributedString *attrString;

@property (nonatomic ,strong) ZSAttributedStringBuilder *builder;

@end

@implementation ZSAttributedStringRange

- (instancetype)initWithAttributeString:(NSMutableAttributedString *)attrString builder:(ZSAttributedStringBuilder *)builder
{
    self = [super init];
    if (self != nil)
    {
        _attrString = attrString;
        _builder = builder;
        _ranges = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)addRange:(NSRange)range
{
    [_ranges addObject:[NSValue valueWithRange:range]];
}

-(void)enumRange:(void(^)(NSRange range))block
{
    if (self == nil || _attrString == nil)
        return;
    
    for (int i = 0; i < _ranges.count; i++)
    {
        NSRange range = ((NSValue *)[_ranges objectAtIndex:i]).rangeValue;
        if (range.location == NSNotFound || range.length == 0)
            continue;
        
        block(range);
    }
}


- (ZSAttributedStringRange *)setFont:(UIFont *)font
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSFontAttributeName value:font range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setTextColor:(UIColor *)color
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setBackgroundColor:(UIColor *)color
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSBackgroundColorAttributeName value:color range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setLigature:(BOOL)ligature
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSLigatureAttributeName value:[NSNumber numberWithInteger:ligature] range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setKern:(CGFloat)kern
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:kern] range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setLineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = lineSpacing;
    return [self setParagraphStyle:ps];
}


- (ZSAttributedStringRange *)setStrikethroughStyle:(int)strikethroughStyle
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:strikethroughStyle] range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setStrikethroughColor:(UIColor *)strikethroughColor
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSStrikethroughColorAttributeName value:strikethroughColor range:range];
        }
    }];
    
    return self;
}


- (ZSAttributedStringRange *)setUnderlineStyle:(NSUnderlineStyle)underlineStyle
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:underlineStyle] range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setShadow:(NSShadow *)shadow
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSShadowAttributeName value:shadow range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setTextEffect:(NSString *)textEffect
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSTextEffectAttributeName value:textEffect range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setAttachment:(NSTextAttachment *)attachment
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSAttachmentAttributeName value:attachment range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setLink:(NSURL *)url
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSLinkAttributeName value:url range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setBaselineOffset:(CGFloat)baselineOffset
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:baselineOffset] range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setUnderlineColor:(UIColor *)underlineColor
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSUnderlineColorAttributeName value:underlineColor range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setObliqueness:(CGFloat)obliqueness
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSObliquenessAttributeName value:[NSNumber numberWithFloat:obliqueness] range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setExpansion:(CGFloat)expansion
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSExpansionAttributeName value:[NSNumber numberWithFloat:expansion] range:range];
        }
    }];
    
    return self;
}


- (ZSAttributedStringRange *)setStrokeColor:(UIColor *)strokeColor
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setStrokeWidth:(CGFloat)strokeWidth
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:strokeWidth] range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringRange *)setAttributes:(NSDictionary *)dict
{
    __weak typeof(self) weakSelf = self;
    [self enumRange:^(NSRange range){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.attrString addAttributes:dict range:range];
        }
    }];
    
    return self;
}

- (ZSAttributedStringBuilder *)builder
{
    return _builder;
}

@end
