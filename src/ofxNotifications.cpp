/*==============================================================================
 
 Copyright (c) 2012 Christopher Baker <http://christopherbaker.net>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ==============================================================================*/

#include "ofxNotifications.h"

#ifdef TARGET_LINUX

void ofxNotification(const string& title,
                     const string& description) {

    ofxNotification(title,"",description,true);
}

void ofxNotification(const string& title,
                     const string& description,
                     bool playSound) {

    ofxNotification(title,"",description,playSound);
}

void ofxNotification(const string& title,
                     const string& subtitle,
                     const string& description,
                     bool playSound) {

    const string& iconName = "icon.png";
    const string& shNotify = "notify-send -i " + ofToDataPath(iconName, true) + " \"" + title + "\""
                             + " \"" + (subtitle != ""? subtitle + "\n" : "") + description + "\"";

    if (!ofFile(iconName).exists())
    {
        ofPixels iconPixels;

        iconPixels.allocate(ofIcon.width,ofIcon.height,ofIcon.bytes_per_pixel);
        GIMP_IMAGE_RUN_LENGTH_DECODE(iconPixels.getData(),ofIcon.rle_pixel_data,iconPixels.getWidth()*iconPixels.getHeight(),ofIcon.bytes_per_pixel);

        ofSaveImage(iconPixels, iconName);
    }

    ofSystem(shNotify);
}

#endif // TARGET_LINUX

