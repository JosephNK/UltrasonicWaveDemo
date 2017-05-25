//
//  ViewController.m
//  UltrasonicWaveDemo
//
//  Created by JosephNK on 2017. 5. 25..
//  Copyright © 2017년 JosephNK. All rights reserved.
//

#import "ViewController.h"
#import <QuietModemKit/QuietModemKit.h>

@interface ViewController ()

@property (nonatomic, strong) QMTransmitterConfig *txConf;
@property (nonatomic, strong) QMFrameTransmitter *tx;
@property (nonatomic, strong) QMReceiverConfig *rxConf;
@property (nonatomic, strong) QMFrameReceiver *rx;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController


- (void)dealloc {
    [self.tx close];
    [self.rx close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.textView setEditable:NO];
    [self.textField becomeFirstResponder];
    [self.sendButton setBackgroundColor:[UIColor whiteColor]];
    
    [self readyReceiver];
    
    //[self.textField setEnabled:NO];
    //[self.sendButton setEnabled:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSendClicked:(id)sender {
    NSString *message = self.textField.text;
    [self sendTransmitter:message];
    self.textField.text = @"";
}

#pragma mark - Transmitter

- (void)sendTransmitter:(NSString *)message {
    if (self.txConf == nil) {
        self.txConf = [[QMTransmitterConfig alloc] initWithKey:@"ultrasonic-experimental"];
    }
    
    if (self.tx == nil) {
        self.tx = [[QMFrameTransmitter alloc] initWithConfig:self.txConf];
    }
    
    NSString *frame_str = message;
    NSData *frame = [frame_str dataUsingEncoding:NSUTF8StringEncoding];
    [self.tx send:frame];
}

#pragma mark - Receiver

- (void)readyReceiver {
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            [self receiver];
        }else {
            NSLog(@"Permission to record not granted");
        }
    }];
}

- (void)receiver {
    if (self.rxConf == nil) {
        self.rxConf = [[QMReceiverConfig alloc] initWithKey:@"ultrasonic-experimental"];
    }
    
    if (self.rx == nil) {
        self.rx = [[QMFrameReceiver alloc] initWithConfig:self.rxConf];
    }
    
    __weak __typeof__(self) weakSelf = self;
    [self.rx setReceiveCallback:^(NSData *frame) {
        NSString *string = [[NSString alloc] initWithData:frame encoding:NSUTF8StringEncoding];
        NSString *text = [NSString stringWithFormat: @"%@\n", string];
        NSString *currntTextViewString = weakSelf.textView.text;
        NSString *appendString = [currntTextViewString stringByAppendingString:text];
        weakSelf.textView.text = appendString;
        
        //NSLog(@"Receve Data: %s\n", [frame bytes]);
        //NSLog(@"Receve Data: %@\n", string);
    }];
}


@end
