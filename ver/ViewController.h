//
//  ViewController.h
//  ver
//
//  Created by Michel Martin on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
    NSMutableArray* vertexes;
    NSTimer *timer1;
    int etat;       // Etat du jeu
    int compteur;   // Compteur de départ de jeu
    float leTemps;  // Durée de l'état actuel 
    int largeur;    // Largeur de l'écran
    int hauteur;    // Hauteur de l'écran
    float posX;     // Position en X du ver
    float posY;     // Position en Y du ver
    int aTouche;    // 1 si le joueur a touché l'écran, 0 sinon
    int reussi;     // Nombre de vers capturés
    int rate;       // Nombre de vers râtés
    AVAudioPlayer *audioPlayer;
    SystemSoundID bruit;
    SystemSoundID rire;
}

@property (weak, nonatomic) IBOutlet UIImageView *leVer;
@property (weak, nonatomic) IBOutlet UILabel *leMessage;
@end
