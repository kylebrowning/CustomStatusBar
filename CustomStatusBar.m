#import "CustomStatusBar.h"

@implementation CustomStatusBar
@synthesize statusLabel;
-(id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		// Place the window on the correct level & position
		self.windowLevel = UIWindowLevelStatusBar + 1.0f;
    CGRect tempFrame = [UIApplication sharedApplication].statusBarFrame;
    statusbarHeight = tempFrame.size.height;
    self.frame = CGRectMake(tempFrame.origin.x, -statusbarHeight, tempFrame.size.width, statusbarHeight);
    backgroundView = [[UIView alloc] initWithFrame:tempFrame];
    [backgroundView setBackgroundColor:[UIColor blackColor]];
		
		statusLabel = [[UILabel alloc] initWithFrame:(CGRect){.origin.x =  0.0f, .origin.y = 0.0f, .size.width = 320.0f, .size.height = self.frame.size.height}];
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.textColor = [UIColor whiteColor];
    [statusLabel setTextAlignment:UITextAlignmentCenter];
		statusLabel.font = [UIFont boldSystemFontOfSize:11.0f];
		[backgroundView addSubview:statusLabel];
    self.hidden = YES;
    [self addSubview:backgroundView];
    //This is needed to detect if the application changes to a phone.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resizeViews:)
                                                 name:@"UIApplicationDidChangeStatusBarFrameNotification"
                                               object:nil];
	}
	return self;
}
- (void) resizeViews:(id)sender {
  CGRect tempFrame = [UIApplication sharedApplication].statusBarFrame;
  statusbarHeight = tempFrame.size.height;
  self.frame = CGRectMake(tempFrame.origin.x, -statusbarHeight, tempFrame.size.width, statusbarHeight);
  [backgroundView setFrame:tempFrame];
  [statusLabel setFrame:tempFrame];
}
-(void)dealloc
{
	[statusLabel release];
	[super dealloc];
}
-(void)showWithStatusMessage:(NSString*)msg hide:(BOOL)shouldHide {
  if(shown) {
    statusLabel.text = msg;
    return;
  }
	if (!msg)
		return;
  self.hidden = NO;
	statusLabel.text = msg;
  CGRect tempFrame = [UIApplication sharedApplication].statusBarFrame;
  self.frame = CGRectMake(tempFrame.origin.x, -statusbarHeight, tempFrame.size.width, statusbarHeight);
  [UIView animateWithDuration:0.5f
                        delay:0.0f
                      options: UIViewAnimationCurveLinear
                   animations:^{
                     shown = YES;
                     self.frame = CGRectMake(tempFrame.origin.x, tempFrame.origin.y, tempFrame.size.width, statusbarHeight);
                   }
                   completion:^(BOOL finished) {
                     if(shouldHide) {
                       [self hide];
                     }
                   }];
}
-(void)showWithStatusMessage:(NSString*)msg
{
  if(shown) {
    statusLabel.text = msg;
    return;
  }
	if (!msg) {
		return;
  }
  self.hidden = NO;
	statusLabel.text = msg;
  CGRect tempFrame = [UIApplication sharedApplication].statusBarFrame;
  self.frame = CGRectMake(tempFrame.origin.x, -statusbarHeight, tempFrame.size.width, statusbarHeight);
  [UIView animateWithDuration:0.5f
                        delay:0.0f
                      options: UIViewAnimationCurveLinear
                   animations:^{
                     shown = YES;
                     self.frame = CGRectMake(tempFrame.origin.x, tempFrame.origin.y, tempFrame.size.width, statusbarHeight);
                   }
                   completion:^(BOOL finished) {
                     
                   }];
}

-(void)hide:(CGFloat)delay withCompletition:(void (^)(BOOL finished))completition
{
  CGRect tempFrame = [UIApplication sharedApplication].statusBarFrame;
  [UIView animateWithDuration:0.5f
                        delay:delay
                      options: UIViewAnimationCurveLinear
                   animations:^{
                     self.frame = CGRectMake(tempFrame.origin.x, -statusbarHeight, tempFrame.size.width, statusbarHeight);
                     shown = NO;
                   }
                   completion:completition];
}

-(void)hide
{
  [self hide:2.0f withCompletition:^(BOOL finished) {
    shown = NO;
    statusLabel.text = @"";
    self.hidden = YES;
  }];
}
-(void)hide:(CGFloat)delay {
  [self hide:delay withCompletition:^(BOOL finished) {
    if (finished) {
      shown = NO;

    }
  }];
}
@end;