//
//  AnswerVC.m
//  chgk
//
//  Created by Semen Ignatov on 06/08/14.
//  Copyright (c) 2014 Semen Ignatov. All rights reserved.
//

#import "AnswerVC.h"
#import "OneRound.h"
#import "Question.h"

@interface AnswerVC ()

@property (nonatomic, weak) IBOutlet UIButton *makeCorrectButton;
@property (nonatomic, weak) IBOutlet UIButton *nextQuestion;
@property (nonatomic, weak) IBOutlet UIButton *endGame;
@property (nonatomic, weak) IBOutlet UITextView *correctAnswer;
@property (nonatomic, weak) IBOutlet UITextView *playerAnswer;
@property (nonatomic, weak) IBOutlet UILabel *score;
@property (nonatomic, weak) IBOutlet UITextView *annotationView;
@property (nonatomic, weak) IBOutlet UIView *rightSignal;

@property (nonatomic, weak) OneRound *oneRound;
@property (nonatomic) BOOL isRight;

@end

@implementation AnswerVC

@synthesize oneRound = oneRound_;
@synthesize isRight = isRight_;

- (id)init
{
    NSLog(@"Please use initWithRound: instead");
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (instancetype)initWithRound:(OneRound *)round
{
    if(self=[super init]){
        oneRound_ = round;
        if (([oneRound_.playerAnswer isEqualToString:oneRound_.currentQuestion.answer]) ||
            ([oneRound_.playerAnswer isEqualToString:@"hh"])){
            isRight_ = YES;
        }
        else{
            isRight_ = NO;
        }
    }
    
    return self;
}

- (IBAction)nextQuestionPressed:(id)sender
{
    [self.delegate nextQuestionAfterAnswer:self.isRight];
}

- (IBAction)makeCorrectPressed:(id)sender
{
    [self.delegate nextQuestionAfterAnswer:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.playerAnswer.text = self.oneRound.playerAnswer;
    self.correctAnswer.text = self.oneRound.currentQuestion.answer;
    self.annotationView.text = self.oneRound.currentQuestion.annotation;
    
    self.rightSignal.backgroundColor = self.isRight ? [UIColor greenColor] : [UIColor redColor];
    
    self.score.text = [NSString stringWithFormat:
                       @"%d : %d",
                       self.oneRound.rightAnswers,
                       self.oneRound.wrongAnswers];
    
    [self.delegate downloadSingleQuestion];
    // Do any additional setup after loading the view from its nib.
}

@end
