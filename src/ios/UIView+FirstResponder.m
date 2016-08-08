#import "UIView+FirstResponder.h"

@implementation UIView (FirstResponder)

- (id)findFirstResponder
{
  if (self.isFirstResponder) {
    return self;
  }
  for (UIView *subView in self.subviews) {
    id responder = [subView findFirstResponder];
    if (responder) return responder;
  }
  return nil;
}

@end
