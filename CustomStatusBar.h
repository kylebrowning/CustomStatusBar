@interface CustomStatusBar : UIWindow
{
@private
	/// Text information
	UILabel* statusLabel;
	/// Black View
  UIView *backgroundView;
  BOOL shown;
  int statusbarHeight;
}
@property (nonatomic, retain) 	UILabel* statusLabel;
-(void)showWithStatusMessage:(NSString*)msg;
-(void)showWithStatusMessage:(NSString*)msg hide:(BOOL)shouldHide;
-(void)hide;
-(void)hide:(CGFloat)delay;
-(void)hide:(CGFloat)delay withCompletition:(void (^)(BOOL finished))completition;

@end