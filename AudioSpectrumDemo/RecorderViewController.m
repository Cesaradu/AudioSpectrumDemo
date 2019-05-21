//
//  RecorderViewController.m
//  AudioSpectrumDemo
//
//  Created by user on 2019/5/21.
//  Copyright © 2019 adu. All rights reserved.
//

#import "RecorderViewController.h"
#import "SpectrumView.h"
#import "AudioSpectrumRecorder.h"

@interface RecorderViewController () <AudioSpectrumRecorderDelegate>

@property (nonatomic, strong) AudioSpectrumRecorder *recorder;
@property (nonatomic, strong) SpectrumView *spectrumView;

@end

@implementation RecorderViewController


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.recorder stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configInit];
    [self buildUI];
}

- (void)configInit {
    self.title = @"录音";
}

- (void)buildUI {
    self.spectrumView = [[SpectrumView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    [self.view addSubview:self.spectrumView];
}

- (IBAction)startRecord:(id)sender {
    [self.recorder startRecord];
}

- (IBAction)stopRecord:(id)sender {
    [self.recorder stop];
}

#pragma mark - AudioSpectrumRecorderDelegate
- (void)recorderDidGenerateSpectrum:(NSArray *)spectrums {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.spectrumView updateSpectra:spectrums withStype:ADSpectraStyleRound];
    });
}

- (AudioSpectrumRecorder *)recorder {
    if (!_recorder) {
        _recorder = [[AudioSpectrumRecorder alloc] init];
        _recorder.delegate = self;
    }
    return _recorder;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
