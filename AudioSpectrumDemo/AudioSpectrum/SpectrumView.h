//
//  SpectrumView.h
//  AudioSpectrumDemo
//
//  Created by user on 2019/5/8.
//  Copyright © 2019 adu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ADSpectraStyle) {
    ADSpectraStyleRect = 0, //直角
    ADSpectraStyleRound //圆角
};

@interface SpectrumView : UIView

@property (nonatomic, assign) CGFloat barWidth;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) CGFloat bottomSpace;
@property (nonatomic, assign) CGFloat topSpace;

- (void)updateSpectra:(NSArray *)spectra withStype:(ADSpectraStyle)style;

@end

NS_ASSUME_NONNULL_END
