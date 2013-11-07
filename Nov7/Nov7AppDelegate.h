//
//  Nov7AppDelegate.h
//  Nov7
//
//  Created by Michael Gradilone on 11/7/13.
//  Copyright (c) 2013 FintechSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "View1.h"


@interface Nov7AppDelegate : UIResponder <UIApplicationDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, MPMediaPlayback> {
    View1 *view;
    
    AVAudioSession *session;
	NSURL *url;

	AVAudioPlayer *player;
    
    MPMoviePlayerController *videoPlayer;
    
    NSURL *videoURL;

}

- (void) valueChanged: (id) sender;

@property (strong, nonatomic) UIWindow *window;

@end
