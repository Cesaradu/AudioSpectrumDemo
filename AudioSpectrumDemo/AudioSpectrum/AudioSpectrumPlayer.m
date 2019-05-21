//
//  AudioSpectrumPlayer.m
//  AudioSpectrumDemo
//
//  Created by user on 2019/5/8.
//  Copyright © 2019 adu. All rights reserved.
//

#import "AudioSpectrumPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>
#import "RealtimeAnalyzer.h"

@interface AudioSpectrumPlayer ()

@property (nonatomic, strong) AVAudioEngine *engine;
@property (nonatomic, strong) AVAudioPlayerNode *player;
@property (nonatomic, strong) RealtimeAnalyzer *analyzer;
@property (nonatomic, assign) int bufferSize;

@end

@implementation AudioSpectrumPlayer

- (instancetype)init {
    if (self = [super init]) {
        [self configInit];
        [self setupPlayer];
    }
    return self;
}

- (void)configInit {
    self.bufferSize = 2048;
    self.analyzer = [[RealtimeAnalyzer alloc] initWithFFTSize:self.bufferSize];
}

- (void)setupPlayer {
    [self.engine attachNode:self.player];
    AVAudioMixerNode *mixerNode = self.engine.mainMixerNode;
    [self.engine connect:self.player to:mixerNode format:[mixerNode outputFormatForBus:0]];
    [self.engine startAndReturnError:nil];
    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
    [mixerNode removeTapOnBus:0];
    [mixerNode installTapOnBus:0 bufferSize:self.bufferSize format:[mixerNode outputFormatForBus:0] block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        if (!self.player.isPlaying) return ;
        buffer.frameLength = self.bufferSize;
        NSArray *spectrums = [self.analyzer analyse:buffer withAmplitudeLevel:5];
        if ([self.delegate respondsToSelector:@selector(playerDidGenerateSpectrum:)]) {
            [self.delegate playerDidGenerateSpectrum:spectrums];
        }
    }];
}

- (void)playWithFileName:(NSString *)fileName {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    NSError *error = nil;
    AVAudioFile *file = [[AVAudioFile alloc] initForReading:fileUrl error:&error];
    if (error) {
        NSLog(@"create AVAudioFile error: %@", error);
        return;
    }
    [self.player stop];
    [self.player scheduleFile:file atTime:nil completionHandler:nil];
    [self.player play];
}

- (void)stop {
    [self.player stop];
}

- (AVAudioEngine *)engine {
    if (!_engine) {
        _engine = [[AVAudioEngine alloc] init];
    }
    return _engine;
}

- (AVAudioPlayerNode *)player {
    if (!_player) {
        _player = [[AVAudioPlayerNode alloc] init];
    }
    return _player;
}

@end
