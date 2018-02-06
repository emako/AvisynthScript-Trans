#######################################################################################################################
#
# SoftWipe()    2011/12/12 by vampiredom
# -----------------------------------------------------------------------------------
# Soft-edged horizontal and vertical wipe transitions
#
# Requirements: Gscript.dll
#
#######################################################################################################################
#
# Usage:
# ------
# SoftWipe(clip a, clip b1 [, clip b2..b99], int "duration", int "direction", int "softness", bool "ease", bool "auto")
#
# Parameters:
# -----------
# a, b1 [, b2..b99]     clips
# SoftWipe() requires between 2 and 99 clips as input. It will wipe from a to b1 [to b2, b3..]
# If you want audio output, all clips should have matching sample rate, number of channels, etc.
# If some clips contain audio while others do not, they will be conformed to match those with audio. 
# Audio will cross-fade as the video wipes unless xfade=false
#
# duration      integer, default: [automatic]
# This is the length of the transition in frames. By default, the wipes are 1 second long
# There is no upper limit, though excessively high values may affect the smoothness.
# of the transition on lower-resolution clips. Duration will be shortened automatically if the underlying clips do not
# have enough frames for the specified transition. If duration < 1, video (& audio) will hard-cut instead.
#
# softness      integer, default: [automatic]
# Softness determines the size of the gradient used for wiping. Bu default, it is ~1/16 of the source width
# This parameter can not be set lower than 8. Values < 8 will be rounded up to 8, and will always be rounded to mod4
# There is no upper limit on softness, but settings higher than 256 may not look as good.
#
# direction     integer, default: 0
# Direction can be between 0 and 3 and affects the direction of the wipe transition:
# 0 = left
# 1 = right
# 2 = up
# 3 = down
#
# ease          boolean, default: true
# By default, transition progress will be non-linear (sine). Set ease=false for linear wipe timing.
#
# auto          boolean, default: true
# By default, when more than 2 clips are supplied as arguments, transition direction rotates automatically -
# beginning with the value set by the direction parameter and continuing in the sequence: left, down, right, up ...
# auto has no effect when only 2 clips are passed to SoftWipe()
#
# xfade         boolean, default: true
# By default, clips with audio will crossfade from a->b over the duration of the tranition.
# Setting xfade=false will cause the audio to hard cut from a->b halfway through the transition.
#
#######################################################################################################################
# This global will hold the basic gradient in memory (256x2 RGB24, 1536 bytes)
global __SoftWipe_gradient__   = ""

function SoftWipe(
\       clip a,  "b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9","b10","b11","b12","b13","b14","b15","b16","b17","b18","b19",
\         "b20","b21","b22","b23","b24","b25","b26","b27","b28","b29","b30","b31","b32","b33","b34","b35","b36","b37","b38","b39",
\         "b40","b41","b42","b43","b44","b45","b46","b47","b48","b49","b50","b51","b52","b53","b54","b55","b56","b57","b58","b59",
\         "b60","b61","b62","b63","b64","b65","b66","b67","b68","b69","b70","b71","b72","b73","b74","b75","b76","b77","b78","b79",
\         "b80","b81","b82","b83","b84","b85","b86","b87","b88","b89","b90","b91","b92","b93","b94","b95","b96","b97","b98","b99",
\       int "duration", int "direction", int "softness", bool "ease", bool "auto", bool "xfade"
\ ) {

        ###############################################################
        # INITIALIZATION
        ###############################################################

        w = a.width()
        h = a.height()
        
        duration  = Default(duration, Round(a.framerate()))
        softness  = Default(softness, Round(Float(w / 16.0)  * 4.0 / 4))
        softness  = Max(softness, 8)
        
        direction = Default(direction, 0)
        ease      = Default(ease, true)
        auto      = Default(auto, true)
        xfade     = Default(xfade, true)
        
        Assert((direction >= 0 && direction <=3),"""SoftWipe()
The direction parameter should be an integer between 0 and 3
0 = Wipe Left
1 = Wipe Right
2 = Wipe Up
3 = Wipe Down
        """)
        
        Assert(duration > 0, """SoftWipe()
The duration parameter cannot be less than 1
        """)
        
        global __SoftWipe_gradient__ = (isClip(__SoftWipe_gradient__)) ? __SoftWipe_gradient__ : _MakeGradient()
        
        ###############################################################
        # MAIN ACTION
        ###############################################################
        a
        i = 1
        Gscript("""
                While (i <= 99 && isClip(Eval("b" + String(i)))) {
                        _DoWipe(last,Eval("b" + String(i)), duration, direction, softness, ease, xfade)
                        direction = (auto) ? (direction == 1) ? 2
                        \                  : (direction == 2) ? 0
                        \                  : (direction == 3) ? 1
                        \                  :                    3
                        \ : direction
                        i = i + 1
                }
        """)
        last
        
        ###############################################################
        # HELPER FUNCTIONS
        ###############################################################
        
        function _MakeGradient() {
                GScript("""
                for ( i = 0 , 255 , 1 ) {
                        b = BlankClip(width=1, height=2, length=1, pixel_type="RGB24", color=i*65536 + i*256 + i)
                        isClip(last) ? StackHorizontal(b) : b
                }""")
        }

        function _ScaleGradient(int w, int h, bool v) {
                __SoftWipe_gradient__
                PointResize(width(), h)
                GaussResize(w,h,p=20)
                (v) ? TurnRight() : last
        }

        function _MoveMask(
        \       clip m, int target_size,
        \       float t, float d, int direction, bool ease
        \ ) {
        
                last = m
                
                w = width()
                h = height()
                
                c = (direction <= 1) ? w - target_size : h - target_size
                x = (direction <= 1) ? (ease) ? _Ease(t, 0, c, d) : Float(t) / Float(d) * Float(c) : 0
                y = (direction >= 2) ? (ease) ? _Ease(t, 0, c, d) : Float(t) / Float(d) * Float(c) : 0
                
                #x = Round(x)
                #y = Round(y)
                
                #(direction <= 1) ? Crop(x,0,target_size,h) : last
                #(direction >= 2) ? Crop(0,y,w,target_size) : last
                
                (direction <= 1) ? GaussResize(target_size,h, x,0,target_size,h) : last
                (direction >= 2) ? GaussResize(w,target_size, 0,y,w,target_size) : last
                
                (direction == 1) ? FlipHorizontal() : (direction == 3) ? FlipVertical() : last
        }

        function _DoWipe(clip a, clip b, int duration, int direction, int softness, bool ease, bool xfade) {
                w = a.width()
                h = a.height()

                a = _FillAudio(a,b)
                b = _FillAudio(b,a)
                
                duration = Min(Floor(Float(a.framecount()) / 2.0), Floor(Float(b.framecount()) / 2.0), duration)
                GScript("""
                        if (duration > 0) {
                                (direction <= 1) ? _ScaleGradient(softness, h, false).AddBorders(w,0,0,0, $000000).AddBorders(0,0,w,0, $FFFFFF)
                                \                : _ScaleGradient(softness, w,  true).AddBorders(0,h,0,0, $000000).AddBorders(0,0,0,h, $FFFFFF)
                                
                                Loop(duration).Animate(0,duration, "_MoveMask",
                                \       (direction <= 1 ? w : h), 1,          duration+1, direction, ease,
                                \       (direction <= 1 ? w : h), duration+1, duration+1, direction, ease)
                                
                                a1 = a.KillAudio().Trim(0,-(a.framecount()-duration))
                                a2 = a.KillAudio().Trim(a.framecount()-duration, 0)
                                b1 = b.KillAudio().Trim(0,-duration)
                                b2 = b.KillAudio().Trim(duration, 0)
                                
                                a1 + Overlay(a2,b1,mask=last,pc_range=true) + b2
                                
                                c = (HasAudio(a)) ?
                                \ (xfade)
                                \       ? Dissolve(a,b, duration)
                                \       : (a.Trim(0,-(a.framecount() - Floor(Float(duration) / 2.0)))
                                \       +  b.Trim(Ceil(Float(duration) / 2.0), 0)).KillVideo()
                                \ : NOP()
                
                                (isClip(c)) ? AudioDub(c) : last
                                
                        } else {
                                a + b
                        }
                """)
        }
        
        function _FillAudio(clip b, clip a) {
                c = (HasAudio(a) && !HasAudio(b))
                \ ? BlankClip(a, b.Framecount(), 1, 1, "RGB24", FramerateNumerator(b), FramerateDenominator(b)).KillVideo()
                \ : NOP()
                (isClip(c)) ? AudioDub(b,c) : b
        }


        function _Ease(a, b, c, d) {
                Float(-c) / 2.0 * (Cos(3.141592 * Float(a) / Float(d)) - 1.0) + Float(b)
        }
}