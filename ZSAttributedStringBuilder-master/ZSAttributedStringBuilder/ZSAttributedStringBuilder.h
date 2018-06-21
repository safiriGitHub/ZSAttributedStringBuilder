//
//  ZSAttributedStringBuilder.h
//  Epayment
//
//  Created by safiri on 2018/6/14.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSAttributedStringRange.h"

typedef NS_ENUM(NSUInteger, ZSSourceStringDocumentType) {
    ZSNormalTextDocumentType,
    ZSPlainTextDocumentType,
    ZSRTFTextDocumentType,
    ZSRTFDTextDocumentType,
    ZSHTMLTextDocumentType
};

/// 属性字符串构建器
@interface ZSAttributedStringBuilder : NSObject

+ (ZSAttributedStringBuilder *)builderWithNormalString:(NSString *)string;
- (id)initWithNormalString:(NSString *)string;

+ (ZSAttributedStringBuilder *)builderWithString:(NSString *)string forDocumentType:(ZSSourceStringDocumentType)type;
- (id)initWithString:(NSString *)string forDocumentType:(ZSSourceStringDocumentType)type;

/// 指定区域,如果没有属性串或者字符串为nil则返回nil,下面方法一样。
- (ZSAttributedStringRange *)range:(NSRange)range;
/// 全部字符
- (ZSAttributedStringRange *)allRange;
/// 最后一个字符
- (ZSAttributedStringRange *)lastRange;
/// 最后N个字符
- (ZSAttributedStringRange *)lastNRange:(NSInteger)length;
 /// 第一个字符
- (ZSAttributedStringRange *)firstRange;
/// 前面N个字符
- (ZSAttributedStringRange *)firstNRange:(NSInteger)length;
/// 用于选择特殊的字符
- (ZSAttributedStringRange *)characterSet:(NSCharacterSet *)characterSet;
/// 用于选择特殊的字符串
- (ZSAttributedStringRange *)includeString:(NSString *)includeString all:(BOOL)all;
/// 正则表达式
- (ZSAttributedStringRange *)regularExpression:(NSString *)regularExpression all:(BOOL)all;


/// 段落处理,以\n结尾为一段，如果没有段落则返回nil
- (ZSAttributedStringRange *)firstParagraph;
- (ZSAttributedStringRange *)nextParagraph;


/// 插入，如果为0则是头部，如果为-1则是尾部
- (void)insert:(NSInteger)pos attrstring:(NSAttributedString *)attrstring;
- (void)insert:(NSInteger)pos attrBuilder:(ZSAttributedStringBuilder *)attrBuilder;

- (NSAttributedString *)commit;

/// MARK: - 其他类方法
/// 计算指定宽度的字符串高度
+ (CGFloat)calculateShowHeightForAttributedString:(NSAttributedString *)attributedString withShowWidth:(CGFloat)width;

@end

/*
 使用
 MyAttributedStringBuilder *builder = nil;
 
 switch (indexPath.row) {
 case 0:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"字体设置"];
 builder.firstRange.font = [UIFont systemFontOfSize:40];
 builder.lastRange.font = [UIFont systemFontOfSize:20];
 }
 break;
 case 1:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"蓝色的背景红色的文字"];
 builder.allRange.backgroundColor = [UIColor blueColor];
 builder.allRange.textColor = [UIColor redColor];
 }
 break;
 case 2:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"中间的文字中空"];
 [builder range:NSMakeRange(3, 2)].strokeColor = [UIColor greenColor];
 [builder range:NSMakeRange(3, 2)].strokeWidth = 2;
 
 }
 break;
 case 3:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"删除线  和 下划线"];
 [builder includeString:@"删除线" all:NO].strikethroughStyle = 1;
 [builder includeString:@"删除线" all:NO].strikethroughColor = [UIColor redColor];
 
 
 [builder includeString:@"下划线" all:NO].underlineStyle = NSUnderlineStyleSingle;
 [builder includeString:@"下划线" all:NO].underlineColor = [UIColor redColor];
 
 
 }
 break;
 case 4:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"我有阴影"];
 
 NSShadow *shadow = [[NSShadow alloc] init];
 shadow.shadowOffset = CGSizeMake(2, 2);
 shadow.shadowColor = [UIColor redColor];
 shadow.shadowBlurRadius = 2;
 
 builder.allRange.shadow = shadow;
 
 }
 break;
 case 5:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"我是胖子 和 我是廋子  和  我歪了"];
 [builder includeString:@"我是胖子" all:NO].expansion = 1.1;
 [builder includeString:@"我是廋子" all:NO].expansion = -1.2;
 [builder includeString:@"我歪了" all:NO].obliqueness = 2;
 
 }
 break;
 case 6:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"看我的字间距越来越宽"];
 [builder range:NSMakeRange(0, 2)].kern = -5;
 [builder range:NSMakeRange(2, 4)].kern = 7;
 [builder range:NSMakeRange(6, 3)].kern = 15;
 
 
 }
 break;
 case 7:
 {
 cell.textLabel.numberOfLines = 0;
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"第一行\n第二行\n第三行\n"];
 builder.allRange.lineSpacing = 20;
 
 
 }
 break;
 case 8:
 {
 NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
 attach.image = [UIImage imageNamed:@"test"];
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"文字\uFFFC混合排列"];
 builder.allRange.attachment = attach;
 }
 break;
 case 9:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"基线偏移的文字效果"];
 [builder includeString:@"基线偏移" all:NO].baselineOffset = 3;
 [builder includeString:@"效果" all:NO].baselineOffset = -3;
 
 }
 break;
 case 10:
 {
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"数字123是高亮的，456也是高亮的"];
 [builder characterSet:[NSCharacterSet  decimalDigitCharacterSet]].textColor = [UIColor greenColor];
 }
 break;
 case 11:
 {
 
 builder = [[MyAttributedStringBuilder alloc] initWithString:@"两只老虎，两只老虎 跑得快，跑得快"];
 [builder includeString:@"老虎" all:YES].textColor = [UIColor greenColor];
 
 }
 break;
 default:
 break;
 }
 
 cell.textLabel.attributedText = builder.commit;
 */
