#import "NSObject+KeyboardBUI.h"

#import "UIView+FirstResponder.h"

@implementation NSObject(KeyboardBUI)

-(_Nonnull id)_responderForEditing
{
  return self;
}

-(void)cut:(nullable id)sender
{
  NSString *selection = [[self getWebView] stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
  [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand('delete', false, null)"];
  [UIPasteboard generalPasteboard].string = selection;
}

-(void)paste:(nullable id)sender
{
  NSString *text = [UIPasteboard generalPasteboard].string;
  [[self getWebView] stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertHTML', false, '%@')", text]];
}

-(void)copy:(nullable id)sender
{
  NSString *selection = [[self getWebView] stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
  [UIPasteboard generalPasteboard].string = selection;
}

-(void)toggleItalics:(nullable id)sender
{
  [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Italic\")"];
}

-(void)toggleUnderline:(nullable id)sender
{
  [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Underline\")"];
}

-(void)toggleBoldface:(nullable id)sender
{
  [[self getWebView] stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Bold\")"];
}

-(UIWebView * __nullable)getWebView
{
  UIWebView *retVal = nil;
  id obj = [[[[[UIApplication sharedApplication] keyWindow] findFirstResponder] superview] superview];
  if ([obj  isKindOfClass:[UIWebView class]]) {
    retVal = obj;
  }
  return retVal;
}

@end
