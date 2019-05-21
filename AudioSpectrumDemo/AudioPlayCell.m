//
//  AudioPlayCell.m
//  AudioSpectrumDemo
//
//  Created by user on 2019/5/8.
//  Copyright © 2019 adu. All rights reserved.
//

#import "AudioPlayCell.h"

#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width

@implementation AudioPlayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenWidth - 110, 40)];
        self.nameLabel.numberOfLines = 2;
        [self addSubview:self.nameLabel];
        
        self.playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.playBtn.selected = NO;
        self.playBtn.frame = CGRectMake(ScreenWidth - 80, 10, 65, 40);
        [self.playBtn setTitle:@"Play" forState:UIControlStateNormal];
        [self.playBtn setTitle:@"Stop" forState:UIControlStateSelected];
        [self.playBtn addTarget:self action:@selector(clickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playBtn];
        
    }
    return self;
}

- (void)clickPlayButton:(UIButton *)button {
    button.selected = !button.selected;
    if (self.playBlock) {
        self.playBlock(!button.selected);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
