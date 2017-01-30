//
//  QuartzFunView.m
//  QuartzFun
//
//  Created by wanghuiyong on 30/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "QuartzFunView.h"
#import "UIColor+Random.h"

@interface QuartzFunView ()

@property (assign, nonatomic) CGPoint firstTouchLocation;
@property (assign, nonatomic) CGPoint lastTouchLocation;
@property (strong, nonatomic) UIImage *image;

@end

@implementation QuartzFunView

// 从 storyboard 中加载归档的对象
- (id)initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
        _currentColor = [UIColor redColor];
        _useRandomColor = NO;
        _image = [UIImage imageNamed:@"iphone"] ;
    }
    return self;
}

#pragma mark - Touch Handling

// 在首次触摸屏幕时调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.useRandomColor) {
        self.currentColor = [UIColor randomColor];
    }
    UITouch *touch = [touches anyObject];
    self.firstTouchLocation = [touch locationInView:self];
    self.lastTouchLocation = [touch locationInView:self];
    [self setNeedsDisplay];	// 将视图标记为需要重新绘制
}

// 触摸离开屏幕时调用
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    [self setNeedsDisplay];
}

// 在屏幕上拖动时持续调用
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	self.lastTouchLocation = [touch locationInView:self];
	[self setNeedsDisplay];
}
 /*
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    
    if (self.shapeType == kImageShape) {
        CGFloat horizontalOffset = self.image.size.width / 2;
        CGFloat verticalOffset = self.image.size.height / 2;
        self.redrawRect = CGRectUnion(self.redrawRect,
                                      CGRectMake(self.lastTouchLocation.x -
                                                 horizontalOffset,
                                                 self.lastTouchLocation.y -
                                                 verticalOffset,
                                                 self.image.size.width,
                                                 self.image.size.height));
    } else {
        self.redrawRect = CGRectUnion(self.redrawRect, self.currentRect);
    }
    self.redrawRect = CGRectInset(self.redrawRect, -2.0, -2.0);
    [self setNeedsDisplayInRect:self.redrawRect];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    
    if (self.shapeType == kImageShape) {
        CGFloat horizontalOffset = self.image.size.width / 2;
        CGFloat verticalOffset = self.image.size.height / 2;
        self.redrawRect = CGRectUnion(self.redrawRect,
                                      CGRectMake(self.lastTouchLocation.x -
                                                 horizontalOffset,
                                                 self.lastTouchLocation.y -
                                                 verticalOffset,
                                                 self.image.size.width,
                                                 self.image.size.height));
    } else {
        self.redrawRect = CGRectUnion(_redrawRect, self.currentRect);
    }
    [self setNeedsDisplayInRect:self.redrawRect];
}
*/

#pragma mark - Drawing Code

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();	// 获取当前环境的引用
    CGContextSetLineWidth(context, 2.0);						// 线宽度为2点
    CGContextSetStrokeColorWithColor(context, self.currentColor.CGColor);	// 笔刷颜色
    CGContextSetFillColorWithColor(context, self.currentColor.CGColor);		// 填充颜色
    // 矩形的位置和大小
    CGRect currentRect = CGRectMake(self.firstTouchLocation.x, self.firstTouchLocation.y, 
                    				self.lastTouchLocation.x - self.firstTouchLocation.x, 
                                    self.lastTouchLocation.y - self.firstTouchLocation.y);


    switch (self.shapeType) {
        case kLineShape:
            CGContextMoveToPoint(context, self.firstTouchLocation.x, self.firstTouchLocation.y);
            CGContextAddLineToPoint(context, self.lastTouchLocation.x, self.lastTouchLocation.y);
            CGContextStrokePath(context);	// 绘制路径
            break;
        case kRectShape:
            CGContextAddRect(context, currentRect);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kEllipseShape:
            CGContextAddEllipseInRect(context, currentRect);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kImageShape: {
            CGFloat horizontalOffset = self.image.size.width / 2;
            CGFloat verticalOffset = self.image.size.height / 2;
            CGPoint drawPiont = CGPointMake(self.lastTouchLocation.x - horizontalOffset, self.lastTouchLocation.y - verticalOffset);
            [self.image drawAtPoint:drawPiont];
            break;
        }
        default:
            break;
    }
}

- (CGRect)currentRect {
    return CGRectMake (self.firstTouchLocation.x,
                       self.firstTouchLocation.y,
                       self.lastTouchLocation.x - self.firstTouchLocation.x,
                       self.lastTouchLocation.y - self.firstTouchLocation.y);
}


@end
