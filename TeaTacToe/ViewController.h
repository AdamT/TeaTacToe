//
//  ViewController.h
//  TeaTacToe
//
//  Created by Adam Tal on 8/12/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
    
    NSString *currentTurn;
    NSMutableArray *ticTacToeBoardArray;

    NSString *xString;
    NSString *oString;

    AVAudioPlayer *backgroundPlayer;
    AVAudioPlayer *xSound;
    AVAudioPlayer *oSound;

}

- (IBAction)startNewGameClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *startNewGameButton;

- (IBAction)restartGameClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *restartGameButton;

- (IBAction)boardButtonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *winnerCookie;
@property (strong, nonatomic) IBOutlet UIImageView *winnerAnnouncement;

@end