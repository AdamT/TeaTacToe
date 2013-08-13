//
//  ViewController.m
//  TeaTacToe
//
//  Created by Adam Tal on 8/12/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize winnerCookie, winnerAnnouncement;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.restartGameButton.hidden = YES;
    [self.restartGameButton setContentMode:UIViewContentModeScaleToFill];
    
    [self startGame];
    
    [self setupSounds];

}

-(void) setupSounds {
    NSString *johannStrauss = [[NSBundle mainBundle]pathForResource:@"johann strauss - the blue danube waltz" ofType:@"mp3"];
    backgroundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:johannStrauss] error:NULL];
    [backgroundPlayer setVolume: 0.25];
    [backgroundPlayer play];
    
    
    NSString *xSoundBite = [[NSBundle mainBundle]pathForResource:@"click_sound" ofType:@"mp3"];
    xSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:xSoundBite] error:NULL];
    [xSound setVolume:0.03];
    
    NSString *oSoundBite = [[NSBundle mainBundle]pathForResource:@"click_sound" ofType:@"mp3"];
    oSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:oSoundBite] error:NULL];
    [oSound setVolume:0.03];
}
- (void)startGame
{
    xString = @"x";
    oString = @"o";
    currentTurn = xString;

    ticTacToeBoardArray = [[NSMutableArray alloc]initWithObjects:@"?", @"?", @"?", @"?", @"?", @"?", @"?", @"?", @"?", nil];

    // clear game when starting a new game
    for (id object in [self.view subviews]) {
        if ([object isKindOfClass:[UIButton class]] && [object tag] < 10) {
            [object setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    
    // clear winner notifications
    [winnerCookie setImage:nil];
    [winnerAnnouncement setImage:nil];

}

- (void)disableBoard {
    for (id object in [self.view subviews]) {
        if ([object isKindOfClass:[UIButton class]] && [object tag] < 10) {
            [object setUserInteractionEnabled:NO];
        }
    }
}

- (void)enableBoard {
    for (id object in [self.view subviews]) {
        if ([object isKindOfClass:[UIButton class]] && [object tag] < 10) {
            [object setUserInteractionEnabled:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startNewGameClick:(id)sender {
    
    [self startGame];
    [self enableBoard];
    
    self.startNewGameButton.hidden = YES;

}
- (IBAction)restartGameClick:(id)sender {
    self.startNewGameButton.hidden = NO;
    self.restartGameButton.hidden = YES;
    
    [self startGame];
}
- (IBAction)boardButtonClicked:(id)sender {
    
    self.restartGameButton.hidden = NO;
    self.startNewGameButton.hidden = YES;

    if ([self canPlay:sender] == YES) {
        [self addXorO:sender];
        [self addImageToButton:sender];
        [self checkBoard];
    }
}

- (BOOL)canPlay:(id)sender {
    
    NSString *boardObjectAtIndex = [ticTacToeBoardArray objectAtIndex:[sender tag]];
    
    if ([boardObjectAtIndex rangeOfString:@"?"].location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)changeCurrentTurn
{
    if ([currentTurn isEqualToString:xString]) {
        currentTurn = oString;

    } else {
        currentTurn = xString;
    }
}

- (void)addXorO:(id)sender
{
    if ([currentTurn isEqualToString:xString]) {
        [ticTacToeBoardArray replaceObjectAtIndex:[sender tag] withObject:xString];
    } else {
        [ticTacToeBoardArray replaceObjectAtIndex:[sender tag] withObject:oString];
    }
}

- (void)addImageToButton:(id)sender
{    
    UIButton *buttonPressed = (UIButton *)sender;
    
    if ([currentTurn isEqualToString:xString]) {
        UIImage *xImage = [UIImage imageNamed:@"X.png"];
        [buttonPressed setBackgroundImage:xImage forState:UIControlStateNormal];
        [xSound play];
    } else {
        UIImage *oImage = [UIImage imageNamed:@"O.png"];
        [buttonPressed setBackgroundImage:oImage forState:UIControlStateNormal];
        [oSound play];
    }
    
}

- (void)checkBoard
{
    if (
        
        ([ticTacToeBoardArray objectAtIndex:0] == [ticTacToeBoardArray objectAtIndex:1] && [ticTacToeBoardArray objectAtIndex:1] == [ticTacToeBoardArray objectAtIndex:2] && ![[ticTacToeBoardArray objectAtIndex:0] isEqualToString:@"?"])||
        
        ([ticTacToeBoardArray objectAtIndex:3] == [ticTacToeBoardArray objectAtIndex:4] && [ticTacToeBoardArray objectAtIndex:4] == [ticTacToeBoardArray objectAtIndex:5] && ![[ticTacToeBoardArray objectAtIndex:3] isEqualToString:@"?"])||
        
        ([ticTacToeBoardArray objectAtIndex:6] == [ticTacToeBoardArray objectAtIndex:7] && [ticTacToeBoardArray objectAtIndex:7] == [ticTacToeBoardArray objectAtIndex:8] && ![[ticTacToeBoardArray objectAtIndex:6] isEqualToString:@"?"]) ||
        
        ([ticTacToeBoardArray objectAtIndex:0] == [ticTacToeBoardArray objectAtIndex:3] && [ticTacToeBoardArray objectAtIndex:3] == [ticTacToeBoardArray objectAtIndex:6] && ![[ticTacToeBoardArray objectAtIndex:0] isEqualToString:@"?"]) ||
        
        ([ticTacToeBoardArray objectAtIndex:1] == [ticTacToeBoardArray objectAtIndex:4] && [ticTacToeBoardArray objectAtIndex:4] == [ticTacToeBoardArray objectAtIndex:7] && ![[ticTacToeBoardArray objectAtIndex:1] isEqualToString:@"?"]) ||
        
        ([ticTacToeBoardArray objectAtIndex:2] == [ticTacToeBoardArray objectAtIndex:5] && [ticTacToeBoardArray objectAtIndex:5] == [ticTacToeBoardArray objectAtIndex:8] && ![[ticTacToeBoardArray objectAtIndex:2] isEqualToString:@"?"]) ||
        
        ([ticTacToeBoardArray objectAtIndex:0] == [ticTacToeBoardArray objectAtIndex:4] && [ticTacToeBoardArray objectAtIndex:4] == [ticTacToeBoardArray objectAtIndex:8] && ![[ticTacToeBoardArray objectAtIndex:0] isEqualToString:@"?"]) ||
        
        ([ticTacToeBoardArray objectAtIndex:2] == [ticTacToeBoardArray objectAtIndex:4] && [ticTacToeBoardArray objectAtIndex:4] == [ticTacToeBoardArray objectAtIndex:6] && ![[ticTacToeBoardArray objectAtIndex:2] isEqualToString:@"?"])
        ) {

        if ([currentTurn isEqualToString:@"x"]) {
            UIImage *xImage = [UIImage imageNamed: @"X.png"];
            [winnerCookie setImage:xImage];
            
        } else {
            UIImage *xImage = [UIImage imageNamed: @"O.png"];
            [winnerCookie setImage:xImage];
        }
        
        UIImage *wins = [UIImage imageNamed:@"wins.png"];
        [winnerAnnouncement setImage:wins];
        
        self.startNewGameButton.hidden = NO;
        self.restartGameButton.hidden = YES;
        
        [self disableBoard];

        
    } else if (![ticTacToeBoardArray containsObject:@"?"]) {
        // board is full, game over
        self.startNewGameButton.hidden = NO;
        self.restartGameButton.hidden = YES;
    }
    else
        
    {
        [self changeCurrentTurn];
    }
}
@end
