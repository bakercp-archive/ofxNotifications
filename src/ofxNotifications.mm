// =============================================================================
//
// Copyright (c) 2012-2014 Christopher Baker <http://christopherbaker.net>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// =============================================================================


#include "ofxNotifications.h"


void ofxNotification(const std::string& title, const std::string& description)
{
    ofxNotification(title, "", description, true);
}


void ofxNotification(const std::string& title,
                     const std::string& description,
                     bool playSound)
{
    ofxNotification(title, "", description, playSound);
}


void ofxNotification(const std::string& title,
                     const std::string& subtitle,
                     const std::string& description,
                     bool playSound)
{
#if (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_8)
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    
    if(!title.empty())
    {
        [notification setTitle:[NSString stringWithCString:title.c_str()
                                                  encoding:[NSString defaultCStringEncoding]]];
    }
    
    if(!subtitle.empty())
    {
        [notification setSubtitle:[NSString stringWithCString:subtitle.c_str()
                                                     encoding:[NSString defaultCStringEncoding]]];
    }
    
    if(!description.empty())
    {
        [notification setInformativeText:[NSString stringWithCString:description.c_str()
                                                            encoding:[NSString defaultCStringEncoding]]];
    }
    
    [notification setSoundName:playSound?(NSUserNotificationDefaultSoundName):nil];
    
    [notification setDeliveryDate:[NSDate date]]; // now
    
    
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    
    [center scheduleNotification:notification];
    
    [notification release];

#else
    ofLogWarning("ofxNotification") << "This is only compatible with OS X 10.8 or newer.";
#endif
};
