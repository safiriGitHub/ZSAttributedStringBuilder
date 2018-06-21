//
//  ZSAttributedStringRange.h
//  Epayment
//
//  Created by safiri on 2018/6/14.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSAttributedStringBuilder;
/// 属性字符串区域
@interface ZSAttributedStringRange : NSObject

/// 字体
- (ZSAttributedStringRange *)setFont:(UIFont *)font;
/// 文字颜色
- (ZSAttributedStringRange *)setTextColor:(UIColor *)color;
/// 背景色
- (ZSAttributedStringRange *)setBackgroundColor:(UIColor *)color;
/// 段落样式
- (ZSAttributedStringRange *)setParagraphStyle:(NSParagraphStyle *)paragraphStyle;
/// 连体字符，好像没有什么作用
- (ZSAttributedStringRange *)setLigature:(BOOL)ligature;
/// 字间距
- (ZSAttributedStringRange *)setKern:(CGFloat)kern;
/// 行间距
- (ZSAttributedStringRange *)setLineSpacing:(CGFloat)lineSpacing;
/// 删除线
- (ZSAttributedStringRange *)setStrikethroughStyle:(int)strikethroughStyle;
/// 删除线颜色
- (ZSAttributedStringRange *)setStrikethroughColor:(UIColor *)StrikethroughColor NS_AVAILABLE_IOS(7_0);
/// 下划线
- (ZSAttributedStringRange *)setUnderlineStyle:(NSUnderlineStyle)underlineStyle;
/// 下划线颜色
- (ZSAttributedStringRange *)setUnderlineColor:(UIColor *)underlineColor NS_AVAILABLE_IOS(7_0);
/// 阴影
- (ZSAttributedStringRange *)setShadow:(NSShadow *)shadow;
- (ZSAttributedStringRange *)setTextEffect:(NSString *)textEffect NS_AVAILABLE_IOS(7_0);
/// 将区域中的特殊字符: NSAttachmentCharacter,替换为attachement中指定的图片,这个来实现图片混排。
- (ZSAttributedStringRange *)setAttachment:(NSTextAttachment *)attachment NS_AVAILABLE_IOS(7_0);
/// 设置区域内的文字点击后打开的链接
- (ZSAttributedStringRange *)setLink:(NSURL *)url NS_AVAILABLE_IOS(7_0);
/// 设置基线的偏移量，正值为往上，负值为往下，可以用于控制UILabel的居顶或者居低显示
- (ZSAttributedStringRange *)setBaselineOffset:(CGFloat)baselineOffset NS_AVAILABLE_IOS(7_0);
/// 设置倾斜度
- (ZSAttributedStringRange *)setObliqueness:(CGFloat)obliqueness NS_AVAILABLE_IOS(7_0);
/// 压缩文字，正值为伸，负值为缩
- (ZSAttributedStringRange *)setExpansion:(CGFloat)expansion NS_AVAILABLE_IOS(7_0);
/// 中空文字的颜色
- (ZSAttributedStringRange *)setStrokeColor:(UIColor *)strokeColor;
/// 中空的线宽度
- (ZSAttributedStringRange *)setStrokeWidth:(CGFloat)strokeWidth;

/// 可以设置多个属性
- (ZSAttributedStringRange *)setAttributes:(NSDictionary *)dict;

- (instancetype)initWithAttributeString:(NSMutableAttributedString *)attrString builder:(ZSAttributedStringBuilder *)builder;
- (void)addRange:(NSRange)range;
/// 得到构建器
-(ZSAttributedStringBuilder *)builder;

@end
