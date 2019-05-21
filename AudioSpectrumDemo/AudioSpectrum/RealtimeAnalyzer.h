//
//  RealtimeAnalyzer.h
//  AudioSpectrumDemo
//
//  Created by user on 2019/5/16.
//  Copyright © 2019 adu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>

NS_ASSUME_NONNULL_BEGIN

@interface RealtimeAnalyzer : NSObject

- (instancetype)initWithFFTSize:(int)fftSize;
- (NSArray *)analyse:(AVAudioPCMBuffer *)buffer withAmplitudeLevel:(int)amplitudeLevel;

@end

NS_ASSUME_NONNULL_END
