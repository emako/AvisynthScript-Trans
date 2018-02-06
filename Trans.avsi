/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Version : v0.3a (2018.01.19)
# Designer : ema
# Bug : http://weibo.com/egosub
# HP : http://egosub.ske48.co
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Plugins : TransAll_by_Mohan,
#              The Pete files are by Pete Warden,
#              SoftWipe_by_vampiredom,
#              GScript_by_Gavino
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Equipment : 
#                  TransAll.dll
#                  FreeFrame.dll
#                  GraMaMa.dll
#                  GScript.dll
#                  zoom.dll
#                  FreeFrame_GParm.avsi
#                  TransModels.avsi
#                  BoxBlur.avsi
#                  SoftWipe.avsi
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# MainFuncs : 
#                  Slideshow
#                  TransRand
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# SubFuncs : 
#                 SmartCrop
#                 OverlayM
#                 PointChk
#                 TransPrep
#                 MaskTransBase
#                 MaskTransition
#                 Trim3
#                 Trim2
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Example 1:
LoadPlugin("TransAll.dll")
LoadPlugin("FreeFrame.dll")
LoadPlugin("GraMaMa.dll")
LoadPlugin("GScript.dll")
LoadPlugin("zoom.dll")
Import("FreeFrame_GParm.avsi")
Import("TransModels_GParm.avsi")
Import("BoxBlur.avsi")
Import("SoftWipe.avsi")
at=OverlayM(ImageSource("a.jpg",pixel_type="rgb32",0,99),1280,720)
bt=OverlayM(ImageSource("b.jpg",pixel_type="rgb32",0,99),1280,720)
ft=int((at.FrameRate()+bt.FrameRate())/2)
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Example 2:
Import("TransMain.avsi")
Slideshow("image (*).jpg", 1, 99, 50)
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
global random_max = 243
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Main : Slideshow
# Parm : string path -> The path of img (See the Example2).
#          start -> Start path number.
#          end -> End path number.
#          every -> Length of every image clip.
#          ft -> Length of fx.
#          w -> Weight (OverlayM).
#          h -> Height (OverlayM).
#          color -> Background color (OverlayM).
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
function Slideshow(string path, int start, int end, int every, int "ft", float "fps", int "w", int "h", int "color")
{
    fps = Default(fps, 29.970)
    w = Default(w, 1280)
    h = Default(h, 720)
    color = Default(color, $FFFFFF)
    ft = Default(ft, (every > Round(fps*2)) ? Round(fps) : Floor(every/2))
    every = every + Ceil(ft/2)
    pos = FindStr(path, "*")
    path_prev = LeftStr(path, pos - 1)
    path_next = RightStr(path, StrLen(path) - pos)
    src = ImageSource(path_prev + String(start) + path_next, fps=fps, start=0, end=every)
    video = src.OverlayM(w, h, color=color)
    i = start + 1
    GScript("""
        while ( i <= end ) {
            path_full = path_prev + String(i) + path_next
            read_source = ImageSource(path_full, fps=fps, start=0, end=every)
            read_source = read_source.OverlayM(w, h, color=color)
            video = TransRand(video, read_source, ft, Rand(max=random_max))
            video = (video.IsRGB32()) ? video : video.ConvertToRGB32()
            i = i + 1
        }
    """)
    return video
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
function TransRand(clip at, clip bt, int ft, int random)
{
    return \
    random == 0 ? Mask_3dtwirl(at, bt, ft) : \
    random == 1 ? Mask_Cicle(at, bt, ft) : \
    random == 2 ? Mask_Circ(at, bt, ft) : \
    random == 3 ? Mask_Clouds(at, bt, ft) : \
    random == 4 ? Mask_Crack(at, bt, ft) : \
    random == 5 ? Mask_Dots(at, bt, ft) : \
    random == 6 ? Mask_Doubleclock(at, bt, ft) : \
    random == 7 ? Mask_Drew(at, bt, ft) : \
    random == 8 ? Mask_Fingers(at, bt, ft) : \
    random == 9 ? Mask_Fish(at, bt, ft) : \
    random == 10 ? Mask_FishDeep(at, bt, ft) : \
    random == 11 ? Mask_Heart(at, bt, ft) : \
    random == 12 ? Mask_Odd(at, bt, ft) : \
    random == 13 ? Mask_Pieces(at, bt, ft) : \
    random == 14 ? Mask_Pixelcloud(at, bt, ft) : \
    random == 15 ? Mask_Pixelrot(at, bt, ft) : \
    random == 16 ? Mask_Pixels(at, bt, ft) : \
    random == 17 ? Mask_Pixelwipe(at, bt, ft) : \
    random == 18 ? Mask_Polar(at, bt, ft) : \
    random == 19 ? Mask_Rays(at, bt, ft) : \
    random == 20 ? Mask_Rays_Cornor(at, bt, ft) : \
    random == 21 ? Mask_Rays_Cornor_Hard(at, bt, ft) : \
    random == 22 ? Mask_Rays_Glass(at, bt, ft) : \
    random == 23 ? Mask_Rays_Pixels(at, bt, ft) : \
    random == 24 ? Mask_Rays_Stretch(at, bt, ft) : \
    random == 25 ? Mask_Rays_Turn(at, bt, ft) : \
    random == 26 ? Mask_Relief(at, bt, ft) : \
    random == 27 ? Mask_Reliefwipedown(at, bt, ft) : \
    random == 28 ? Mask_Ringlight(at, bt, ft) : \
    random == 29 ? Mask_Sinenegsphere(at, bt, ft) : \
    random == 30 ? Mask_Sinepond(at, bt, ft) : \
    random == 31 ? Mask_Sinerip(at, bt, ft) : \
    random == 32 ? Mask_Sinesquare(at, bt, ft) : \
    random == 33 ? Mask_Sinetri(at, bt, ft) : \
    random == 34 ? Mask_Sinewave(at, bt, ft) : \
    random == 35 ? Mask_Snakerelief(at, bt, ft) : \
    random == 36 ? Mask_Snakeskin(at, bt, ft) : \
    random == 37 ? Mask_Spikes(at, bt, ft) : \
    random == 38 ? Mask_Spikesaphere(at, bt, ft) : \
    random == 39 ? Mask_Spikesfrosted(at, bt, ft) : \
    random == 40 ? Mask_Spikessphere(at, bt, ft) : \
    random == 41 ? Mask_Spikessphereinv(at, bt, ft) : \
    random == 42 ? Mask_Sspinners(at, bt, ft) : \
    random == 43 ? Mask_Sspiral(at, bt, ft) : \
    random == 44 ? Mask_Sqares(at, bt, ft) : \
    random == 45 ? Mask_Squares(at, bt, ft) : \
    random == 46 ? Mask_SquaresLD(at, bt, ft) : \
    random == 47 ? Mask_Squarestwist(at, bt, ft) : \
    random == 48 ? Mask_Stainedglass(at, bt, ft) : \
    random == 49 ? Mask_Sstainedglass2(at, bt, ft) : \
    random == 50 ? Mask_Star(at, bt, ft) : \
    random == 51 ? Mask_Tiles(at, bt, ft) : \
    random == 52 ? Mask_Timewarp(at, bt, ft) : \
    random == 53 ? Mask_Trifield(at, bt, ft) : \
    random == 54 ? Mask_Turn_Type1(at, bt, ft) : \
    random == 55 ? Mask_Turn_Type2(at, bt, ft) : \
    random == 56 ? Mask_Turn_UD(at, bt, ft) : \
    random == 57 ? Mask_Twirl(at, bt, ft) : \
    random == 58 ? Mask_Twirl2(at, bt, ft) : \
    random == 59 ? Mask_TwistedFish(at, bt, ft) : \
    random == 60 ? Mask_Twocirc(at, bt, ft) : \
    random == 61 ? Mask_Wallcloth(at, bt, ft) : \
    random == 62 ? Mask_Wickedwipe(at, bt, ft) : \
    random == 63 ? Mask_Wipedots(at, bt, ft) : \
    random == 64 ? Accord_Horisontal_In(at, bt, ft)[*Group 2*] : \
    random == 65 ? Accord_Horisontal_Out(at, bt, ft) : \
    random == 66 ? Accord_Left(at, bt, ft) : \
    random == 67 ? Accord_Up(at, bt, ft) : \
    random == 68 ? Accord_Vertical_In(at, bt, ft) : \
    random == 69 ? Accord_Vertical_Out(at, bt, ft) : \
    random == 70 ? Bars_Hors_LLL(at, bt, ft)[*Group 3*] : \
    random == 71 ? Bars_Hors_LRL(at, bt, ft) : \
    random == 72 ? Bars_Hors_RLR(at, bt, ft) : \
    random == 73 ? Bars_Hors_RRR(at, bt, ft) : \
    random == 74 ? Bars_Hors_TTT(at, bt, ft) : \
    random == 75 ? Bars_Hors_BBB(at, bt, ft) : \
    random == 76 ? Bars_Hors_BTB(at, bt, ft) : \
    random == 77 ? Bars_Hors_TBT(at, bt, ft) : \
    random == 78 ? Bars_Hors_TTT(at, bt, ft) : \
    random == 79 ? Bubbles_Move(at, bt, ft)[*Group 4*] : \
    random == 80 ? Bubbles_Static(at, bt, ft) : \
    random == 81 ? Central_In(at, bt, ft)[*Group 5*] : \
    random == 82 ? Central_Out(at, bt, ft) : \
    random == 83 ? Central_Rotate_In(at, bt, ft) : \
    random == 84 ? Central_Rotate_Out(at, bt, ft) : \
    random == 85 ? Crumple_In(at, bt, ft)[*Group 6*] : \
    random == 86 ? Crumple_Out(at, bt, ft) : \
    random == 87 ? Dias_Down(at, bt, ft)[*Group 7*] : \
    random == 88 ? Dias_Up(at, bt, ft) : \
    random == 89 ? Dias_Left(at, bt, ft) : \
    random == 90 ? Dias_Right(at, bt, ft) : \
    random == 91 ? Disco1(at, bt, ft)[*Group 8*] : \
    random == 92 ? Disco2(at, bt, ft) : \
    random == 93 ? Disco3(at, bt, ft) : \
    random == 94 ? Disco4(at, bt, ft) : \
    random == 95 ? DissolveBloom(at, bt, ft)[*Group 9*] : \
    random == 96 ? DissolveBlur(at, bt, ft) : \
    random == 97 ? DissolveBright(at, bt, ft)/*YUV*/ : \
    random == 98 ? DissolveBurn(at, bt, ft)/*YUV*/ : \
    random == 99 ? DissolveDark(at, bt, ft)/*YUV*/ : \
    random == 100 ? DissolveDesat(at, bt, ft)/*YUV*/ : \
    random == 101 ? DissolveNegative(at, bt, ft)/*YUV*/ : \
    random == 102 ? Door_LR_Open(at, bt, ft)[*Group 10*] : \
    random == 103 ? Door_LR_Close(at, bt, ft) : \
    random == 104 ? Door_UP_Close(at, bt, ft) : \
    random == 105 ? Door_UP_Open(at, bt, ft) : \
    random == 106 ? FanIn(at, bt, ft)[*Group 11*] : \
    random == 107 ? FanOut(at, bt, ft) : \
    random == 108 ? FF_MetaImage(at, bt, ft)[*Group 12*] : \
    random == 109 ? FF_PeteKaleidascope(at, bt, ft) : \
    random == 110 ? FFrameKaleidascope(at, bt, ft) : \
    random == 111 ? FF_RadialBlur(at, bt, ft) : \
    random == 112 ? FF_SmearDown(at, bt, ft) : \
    random == 113 ? FF_SmearUp(at, bt, ft) : \
    random == 114 ? FF_SmearRight(at, bt, ft) : \
    random == 115 ? FF_SmearLeft(at, bt, ft) : \
    random == 116 ? FF_SquashHor(at, bt, ft) : \
    random == 117 ? FF_SquashHorBackwards(at, bt, ft) : \
    random == 118 ? FF_SquashVer(at, bt, ft) : \
    random == 119 ? FF_SquashVerUpsideDown(at, bt, ft) : \
    random == 120 ? FlipPageUp(at, bt, ft)[*Group 13*] : \
    random == 121 ? FlipPageRight(at, bt, ft) : \
    random == 122 ? FlipPageLeft(at, bt, ft) : \
    random == 123 ? FlipPageDown(at, bt, ft) : \
    random == 123 ? FunnelUp(at, bt, ft)[*Group 14*] : \
    random == 124 ? FunnelRight(at, bt, ft) : \
    random == 125 ? FunnelLeft(at, bt, ft) : \
    random == 126 ? FunnelDown(at, bt, ft) : \
    random == 127 ? Marbles(at, bt, ft)[*Group 15*] : \
    random == 128 ? Marbles2(at, bt, ft) : \
    random == 139 ? Marbles3(at, bt, ft) : \
    random == 130 ? Marbles4(at, bt, ft) : \
    random == 131 ? MirrorUpDown(at, bt, ft)[*Group 16*] : \
    random == 132 ? PaintBricks(at, bt, ft)[*Group 17*] : \
    random == 133 ? PaintFence(at, bt, ft) : \
    random == 134 ? PaintPaint(at, bt, ft) : \
    random == 135 ? PaintRings(at, bt, ft) : \
    random == 136 ? PeelUp(at, bt, ft)[*Group 18*] : \
    random == 137 ? PeelDown(at, bt, ft) : \
    random == 138 ? PeelLeft(at, bt, ft) : \
    random == 139 ? PeelRight(at, bt, ft) : \
    random == 140 ? PushUp(at, bt, ft)[*Group 19*] : \
    random == 141 ? PushDown(at, bt, ft) : \
    random == 142 ? PushLeft(at, bt, ft) : \
    random == 143 ? PushRight(at, bt, ft) : \
    random == 144 ? Ripple(at, bt, ft)[*Group 20*] : \
    random == 145 ? Ripples_Center_1(at, bt, ft) : \
    random == 146 ? Ripples_Center_2(at, bt, ft) : \
    random == 147 ? Ripples_Center_3(at, bt, ft) : \
    random == 148 ? Ripples_Corners(at, bt, ft) : \
    random == 149 ? Ripples_EW(at, bt, ft) : \
    random == 150 ? Ripples_NE(at, bt, ft) : \
    random == 151 ? Ripples_NS(at, bt, ft) : \
    random == 152 ? Ripples_NSEW(at, bt, ft) : \
    random == 153 ? Ripples_NW(at, bt, ft) : \
    random == 154 ? Ripples_NWSE_1(at, bt, ft) : \
    random == 155 ? Ripples_NWSE_2(at, bt, ft) : \
    random == 156 ? Ripples_SE(at, bt, ft) : \
    random == 157 ? ScratchDust(at, bt, ft)[*Group 21*] : \
    random == 158 ? ScratchFount(at, bt, ft) : \
    random == 159 ? ScratchHline(at, bt, ft) : \
    random == 160 ? ScratchMerge(at, bt, ft) : \
    random == 161 ? ScratchOring(at, bt, ft) : \
    random == 162 ? ScratchRain(at, bt, ft) : \
    random == 163 ? ScratchVline(at, bt, ft) : \
    random == 164 ? ShuffleUp(at, bt, ft)[*Group 22*] : \
    random == 165 ? ShuffleDown(at, bt, ft) : \
    random == 166 ? ShuffleLeft(at, bt, ft) : \
    random == 167 ? ShuffleRight(at, bt, ft) : \
    random == 168 ? SlantRoll_In(at, bt, ft)[*Group 23*] : \
    random == 169 ? SlantRoll_In_NE(at, bt, ft) : \
    random == 170 ? SlantRoll_In_NW(at, bt, ft) : \
    random == 171 ? SlantRoll_In_SE(at, bt, ft) : \
    random == 172 ? SlantRoll_In_Shade(at, bt, ft) : \
    random == 173 ? SlantRoll_In_SW(at, bt, ft) : \
    random == 174 ? SlantRoll_Out(at, bt, ft) : \
    random == 175 ? SlantRoll_Out_Dia(at, bt, ft) : \
    random == 176 ? SlantRoll_Out_NE(at, bt, ft) : \
    random == 177 ? SlantRoll_Out_NW(at, bt, ft) : \
    random == 178 ? SlantRoll_Out_SE(at, bt, ft) : \
    random == 179 ? SlantRoll_Out_SW(at, bt, ft) : \
    random == 180 ? Slant_Wipe_NE(at, bt, ft)[*Group 24*] : \
    random == 181 ? Slant_Wipe_NW(at, bt, ft) : \
    random == 182 ? Slant_Wipe_SE(at, bt, ft) : \
    random == 183 ? Slant_Wipe_SW(at, bt, ft) : \
    random == 184 ? SlideIn_Center(at, bt, ft)[*Group 25*] : \
    random == 185 ? SlideIn_East(at, bt, ft) : \
    random == 186 ? SlideIn_NE(at, bt, ft) : \
    random == 187 ? SlideIn_North(at, bt, ft) : \
    random == 188 ? SlideIn_South(at, bt, ft) : \
    random == 189 ? SlideIn_SW(at, bt, ft) : \
    random == 190 ? SlideIn_West(at, bt, ft) : \
    random == 191 ? SlideOut_Center(at, bt, ft) : \
    random == 192 ? SlideOut_East(at, bt, ft) : \
    random == 193 ? SlideOut_North(at, bt, ft) : \
    random == 194 ? SlideOut_SW(at, bt, ft) : \
    random == 195 ? SlideOut_South(at, bt, ft) : \
    random == 196 ? SlideOut_West(at, bt, ft) : \
    random == 197 ? SoftWipe_Up(at, bt, ft)[*Group 26*] : \
    random == 198 ? SoftWipe_Down(at, bt, ft) : \
    random == 199 ? SoftWipe_Left(at, bt, ft) : \
    random == 200 ? SoftWipe_Right(at, bt, ft) : \
    random == 201 ? Split_Horisontal(at, bt, ft)[*Group 27*] : \
    random == 202 ? Split_Vertical(at, bt, ft) : \
    random == 203 ? Split_Vertical_Full(at, bt, ft) : \
    random == 204 ? Split_Vertical_Random(at, bt, ft) : \
    random == 205 ? Split_Vertical_UpDown(at, bt, ft) : \
    random == 206 ? SpriteUp(at, bt, ft)[*Group 28*] : \
    random == 207 ? SpriteDown(at, bt, ft) : \
    random == 208 ? SpriteLeft(at, bt, ft) : \
    random == 209 ? SpriteRight(at, bt, ft) : \
    random == 210 ? Swing(at, bt, ft)[*Group 29*] : \
    random == 211 ? Swing2(at, bt, ft) : \
    random == 212 ? Swing_Corner(at, bt, ft) : \
    random == 213 ? Swing_Ndoors(at, bt, ft) : \
    random == 214 ? Swing_One_In(at, bt, ft) : \
    random == 215 ? Swing_One_In2(at, bt, ft) : \
    random == 216 ? Swing_One_In3(at, bt, ft) : \
    random == 217 ? Swing_One_In4(at, bt, ft) : \
    random == 218 ? Swing_One_Out(at, bt, ft) : \
    random == 219 ? Swing_One_Out2(at, bt, ft) : \
    random == 220 ? Swing_One_Out3(at, bt, ft) : \
    random == 221 ? Swing_One_Out4(at, bt, ft) : \
    random == 222 ? Swirl(at, bt, ft)[*Group 30*] : \
    random == 223 ? Swirl_Anti(at, bt, ft) : \
    random == 224 ? Swirl_Clock(at, bt, ft) : \
    random == 225 ? TwinDoors(at, bt, ft)[*Group 31*] : \
    random == 226 ? TwinDoors_Horisontal_Close(at, bt, ft) : \
    random == 227 ? TwinDoors_Horisontal_Open(at, bt, ft) : \
    random == 228 ? TwinDoors_Vertical_Close(at, bt, ft) : \
    random == 229 ? TwinDoors_Vertical_Open(at, bt, ft) : \
    random == 230 ? VenetianBlinds(at, bt, ft)[*Group 32*] : \
    random == 231 ? VenetianBlinds_Cheq(at, bt, ft) : \
    random == 232 ? VenetianBlinds_Diam(at, bt, ft) : \
    random == 233 ? VenetianBlinds_Hor(at, bt, ft) : \
    random == 234 ? VenetianBlinds_Vert(at, bt, ft) : \
    random == 235 ? VenetianBlinds_Width(at, bt, ft) : \
    random == 236 ? Weave_Hor(at, bt, ft)[*Group 33*] : \
    random == 237 ? Weave_Jigsaw(at, bt, ft) : \
    random == 238 ? Weave_Vert(at, bt, ft) : \
    random == 239 ? Weave_Weave(at, bt, ft) : \
    random == 240 ? Wipe_Down(at, bt, ft)[*Group 34*] : \
    random == 241 ? Wipe_Left(at, bt, ft) : \
    random == 242 ? Wipe_Right(at, bt, ft) : \
    random == 243 ? Wipe_Up(at, bt, ft) : \
    Dissolve(at, bt, ft, color=$FFFFFF)
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# MaskTransition
/*RGB Only*/
function Mask_3dtwirl(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_3dtwirl, ft)
}

function Mask_Cicle(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_cicle, ft)
}

function Mask_Circ(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_circ, ft)
}

function Mask_Clouds(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_clouds, ft)
}

function Mask_Crack(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_crack, ft)
}

function Mask_Dots(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_dots, ft)
}

function Mask_Doubleclock(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_doubleclock, ft)
}

function Mask_Drew(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_drew, ft)
}

function Mask_Fingers(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_fingers, ft)
}

function Mask_Fish(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_fish, ft)
}

function Mask_FishDeep(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_fishDeep, ft)
}

function Mask_Heart(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_heart, ft)
}

function Mask_Odd(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_odd, ft)
}

function Mask_Pieces(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_pieces, ft)
}

function Mask_Pixelcloud(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_pixelcloud, ft)
}

function Mask_Pixelrot(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_pixelrot, ft)
}

function Mask_Pixels(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_pixels, ft)
}

function Mask_Pixelwipe(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_pixelwipe, ft)
}

function Mask_Polar(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_polar, ft)
}

function Mask_Rays(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_rays, ft)
}

function Mask_Rays_Cornor(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_rays_cornor, ft)
}

function Mask_Rays_Cornor_Hard(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_rays_cornor_hard, ft)
}

function Mask_Rays_Glass(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_rays_glass, ft)
}

function Mask_Rays_Pixels(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_rays_pixels, ft)
}

function Mask_Rays_Stretch(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_rays_stretch, ft)
}

function Mask_Rays_Turn(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_rays_turn, ft)
}

function Mask_Relief(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_relief, ft)
}

function Mask_Reliefwipedown(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_reliefwipedown, ft)
}

function Mask_Ringlight(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_ringlight, ft)
}

function Mask_Sinenegsphere(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_sinenegsphere, ft)
}

function Mask_Sinepond(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_sinepond, ft)
}

function Mask_Sinerip(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_sinerip, ft)
}

function Mask_Sinesquare(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_sinesquare, ft)
}

function Mask_Sinetri(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_sinetri, ft)
}

function Mask_Sinewave(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_sinewave, ft)
}

function Mask_Snakerelief(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_snakerelief, ft)
}

function Mask_Snakeskin(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_snakeskin, ft)
}

function Mask_Spikes(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_spikes, ft)
}

function Mask_Spikesaphere(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_spikesaphere, ft)
}

function Mask_Spikesfrosted(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_spikesfrosted, ft)
}

function Mask_Spikessphere(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_spikessphere, ft)
}

function Mask_Spikessphereinv(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_spikessphereinv, ft)
}

function Mask_Sspinners(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_spinners, ft)
}

function Mask_Sspiral(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_spiral, ft)
}

function Mask_Sqares(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_sqares, ft)
}

function Mask_Squares(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_squares, ft)
}

function Mask_SquaresLD(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_squaresLD, ft)
}

function Mask_Squarestwist(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_squarestwist, ft)
}

function Mask_Stainedglass(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_stainedglass, ft)
}

function Mask_Sstainedglass2(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_stainedglass2, ft)
}

function Mask_Star(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_star, ft)
}

function Mask_Tiles(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_tiles, ft)
}

function Mask_Timewarp(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_timewarp, ft)
}

function Mask_Trifield(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_trifield, ft)
}

function Mask_Turn_Type1(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_turn_type1, ft)
}

function Mask_Turn_Type2(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_turn_type2, ft)
}

function Mask_Turn_UD(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_turn_ud, ft)
}

function Mask_Twirl(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_twirl, ft)
}

function Mask_Twirl2(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_twirl2, ft)
}

function Mask_TwistedFish(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_twistedFish, ft)
}

function Mask_Twocirc(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_twocirc, ft)
}

function Mask_Wallcloth(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_wallcloth, ft)
}

function Mask_Wickedwipe(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_wickedwipe, ft)
}

function Mask_Wipedots(clip at, clip bt, int ft)
{
    MaskTransBase(at, bt, g_trans_image_wipedots, ft)
}

function MaskTransBase(clip at, clip bt, string imgpath, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    MaskTransition(at, bt, imgpath, ft)
    _at1++last++_bt2
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransAccord
function Accord_Horisontal_In(clip at, clip bt, int ft)
{
    TransAccord(at, bt, ft, dir="hor", open= false)
}

function Accord_Horisontal_Out(clip at, clip bt, int ft)
{
    TransAccord(at, bt, ft, dir="hor", open= true)
}

function Accord_Left(clip at, clip bt, int ft)
{
    TransAccord(at, bt, ft, dir="vert", twin= false)
}

function Accord_Up(clip at, clip bt, int ft)
{
    TransAccord(at, bt, ft, dir="hor", twin= false)
}

function Accord_Vertical_In(clip at, clip bt, int ft)
{
    TransAccord(at, bt, ft, "vert", true, false)
}

function Accord_Vertical_Out(clip at, clip bt, int ft)
{
    TransAccord(at, bt, ft)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransAccord

/*RGB32 Only*/
function Bars_Hors_LLL(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    atwidth=at.width
    atheight=at.height
    bt1=SmartCrop(bt,0,0,bt.width,int(bt.height/3),0,0)
    bt2=SmartCrop(bt,0,int(bt.height/3),bt.width,int(bt.height/3),0,int(bt.height/3))
    bt3=SmartCrop(bt,0,int(bt.height/3)*2,bt.width,int(bt.height/3),0,int(bt.height/3)*2)

    bt=Animate(0,int(at.framecount/3),"layer",at,bt1,"add",257,atwidth*-1,0,at,bt1,"add",257,0,0)
    bt=Animate(int(at.framecount/3),int(at.framecount/3)*2,"layer",bt,bt2,"add",257,atwidth*-1,0,bt,bt2,"add",257,0,0)
    bt=Animate(int(at.framecount/3)*2,at.framecount-1,"layer",bt,bt3,"add",257,atwidth*-1,0,bt,bt3,"add",257,0,0)
    bt
    _at1++last++_bt2
}

/*RGB32 Only*/
function Bars_Hors_LRL(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    atwidth=at.width
    atheight=at.height
    bt1=SmartCrop(bt,0,0,bt.width,int(bt.height/3),0,0)
    bt2=SmartCrop(bt,0,int(bt.height/3),bt.width,int(bt.height/3),0,int(bt.height/3))
    bt3=SmartCrop(bt,0,int(bt.height/3)*2,bt.width,int(bt.height/3),0,int(bt.height/3)*2)

    bt=Animate(1,int(at.framecount/3),"layer",at,bt1,"add",257,atwidth*-1,0,at,bt1,"add",257,0,0)
    bt=Animate(int(at.framecount/3),int(at.framecount/3)*2,"layer",bt,bt2,"add",257,atwidth,0,bt,bt2,"add",257,0,0)
    bt=Animate(int(at.framecount/3)*2,at.framecount,"layer",bt,bt3,"add",257,atwidth*-1,0,bt,bt3,"add",257,0,0)
    bt
    _at1++last++_bt2
}

/*RGB32 Only*/
function Bars_Hors_RLR(clip at, clip bt,  int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    atwidth=at.width
    atheight=at.height
    bt1=SmartCrop(bt,0,0,bt.width,int(bt.height/3),0,0)
    bt2=SmartCrop(bt,0,int(bt.height/3),bt.width,int(bt.height/3),0,int(bt.height/3))
    bt3=SmartCrop(bt,0,int(bt.height/3)*2,bt.width,int(bt.height/3),0,int(bt.height/3)*2)

    bt=Animate(0,int(at.framecount/3),"layer",at,bt1,"add",257,atwidth,0,at,bt1,"add",257,0,0)
    bt=Animate(int(at.framecount/3),int(at.framecount/3)*2,"layer",bt,bt2,"add",257,atwidth*-1,0,bt,bt2,"add",257,0,0)
    bt=Animate(int(at.framecount/3)*2,at.framecount-1,"layer",bt,bt3,"add",257,atwidth,0,bt,bt3,"add",257,0,0)
    bt
    _at1++last++_bt2
}

/*RGB32 Only*/
function Bars_Hors_RRR(clip at, clip bt,  int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    atwidth=at.width
    atheight=at.height
    bt1=SmartCrop(bt,0,0,bt.width,int(bt.height/3),0,0)
    bt2=SmartCrop(bt,0,int(bt.height/3),bt.width,int(bt.height/3),0,int(bt.height/3))
    bt3=SmartCrop(bt,0,int(bt.height/3)*2,bt.width,int(bt.height/3),0,int(bt.height/3)*2)

    bt=Animate(0,int(at.framecount/3),"layer",at,bt1,"add",257,atwidth,0,at,bt1,"add",257,0,0)
    bt=Animate(int(at.framecount/3),int(at.framecount/3)*2,"layer",bt,bt2,"add",257,atwidth,0,bt,bt2,"add",257,0,0)
    bt=Animate(int(at.framecount/3)*2,at.framecount-1,"layer",bt,bt3,"add",257,atwidth,0,bt,bt3,"add",257,0,0)
    bt
    _at1++last++_bt2
}

/*RGB32 Only*/
function Bars_Hors_TTT(clip at, clip bt,  int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    atwidth=at.width
    atheight=at.height
    ct1=BlankClip(width=at.width, height=at.height, color=$000ff000, length=ft,pixel_type="rgb32").ConvertToRGB32().KillAudio()
    ct2=ColorBars(720,576).Trim(0,ft)
    bt1=SmartCrop(bt,0,0,bt.width,int(bt.height/3),0,0)
    bt2=SmartCrop(bt,0,int(bt.height/3),bt.width,int(bt.height/3),0,int(bt.height/3))
    bt3=SmartCrop(bt,0,int(bt.height/3)*2,bt.width,int(bt.height/3),0,int(bt.height/3)*2)

    bt=Animate(1,int(at.framecount/3)-1,"layer",at,bt3,"add",257,0,atheight*-1,at,bt1,"add",257,0,0)
    bt=Animate(int(at.framecount/3),int(at.framecount/3)*2-1,"layer",bt,bt2,"add",257,0,atheight*-1,bt,bt2,"add",257,0,0)
    bt=Animate(int(at.framecount/3)*2,at.framecount-1,"layer",bt,bt1,"add",257,0,atheight*-1,bt,bt3,"add",257,0,0)
    bt
    _at1++last++_bt2
}

/*RGB32 Only*/
function Bars_Hors_BBB(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    atwidth=at.width
    atheight=at.height

    bt1=SmartCrop(bt,0,0,int(bt.width/3),bt.height,0,0)
    bt2=SmartCrop(bt,int(bt.width/3),0,int(bt.width/3),bt.height,int(bt.width/3),0)
    bt3=SmartCrop(bt,int(bt.width/3)*2,0,int(bt.width/3),bt.height,int(bt.width/3)*2,0)

    bt=Animate(0,int(ft/3),"layer",at,bt1,"add",257,0,atheight,at,bt1,"add",257,0,0)
    bt=Animate(int(ft/3),int(ft/3)*2,"layer",bt,bt2,"add",257,0,atheight,bt,bt2,"add",257,0,0)
    bt=Animate(int(ft/3)*2,ft,"layer",bt,bt3,"add",257,0,atheight,bt,bt3,"add",257,0,0)
    at++bt
}

/*RGB32 Only*/
function Bars_Hors_BTB(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at=at.Trim(0, at.FrameCount() - ft - 1)
    atwidth=at.width
    atheight=at.height

    bt1=SmartCrop(bt,0,0,int(bt.width/3),bt.height,0,0)
    bt2=SmartCrop(bt,int(bt.width/3),0,int(bt.width/3),bt.height,int(bt.width/3),0)
    bt3=SmartCrop(bt,int(bt.width/3)*2,0,int(bt.width/3),bt.height,int(bt.width/3)*2,0)

    bt=Animate(0,int(ft/3),"layer",at,bt1,"add",257,0,atheight,at,bt1,"add",257,0,0)
    bt=Animate(int(ft/3),int(ft/3)*2,"layer",bt,bt2,"add",257,0,atheight*-1,bt,bt2,"add",257,0,0)
    bt=Animate(int(ft/3)*2,ft,"layer",bt,bt3,"add",257,0,atheight,bt,bt3,"add",257,0,0)
    _at++bt
}

/*RGB32 Only*/
function Bars_Hors_TBT(clip at,clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at=at.Trim(0, at.FrameCount() - ft - 1)
    atwidth=at.width
    atheight=at.height

    bt1=SmartCrop(bt,0,0,int(bt.width/3),bt.height,0,0)
    bt2=SmartCrop(bt,int(bt.width/3),0,int(bt.width/3),bt.height,int(bt.width/3),0)
    bt3=SmartCrop(bt,int(bt.width/3)*2,0,int(bt.width/3),bt.height,int(bt.width/3)*2,0)

    bt=Animate(0,int(ft/3),"layer",at,bt1,"add",257,0,atheight*-1,at,bt1,"add",257,0,0)
    bt=Animate(int(ft/3),int(ft/3)*2,"layer",bt,bt2,"add",257,0,atheight,bt,bt2,"add",257,0,0)
    bt=Animate(int(ft/3)*2,ft,"layer",bt,bt3,"add",257,0,atheight*-1,bt,bt3,"add",257,0,0)
    _at++bt
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransBubbles
function Bubbles_Move(clip at,clip bt, int ft)
{
    TransBubbles(at, bt, ft, true)
}

function Bubbles_Static(clip at,clip bt, int ft)
{
    TransBubbles(at, bt, ft, false)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransCentral
function Central_In(clip at,clip bt, int ft)
{
    TransCentral(at, bt, ft)
}

function Central_Out(clip at,clip bt, int ft)
{
    TransCentral(at, bt, ft, false)
}

function Central_Rotate_In(clip at,clip bt, int ft)
{
    TransCentral(at, bt, ft, true, true, -2)
}

function Central_Rotate_Out(clip at,clip bt, int ft)
{
    TransCentral(at, bt, ft, false, false, -4)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransCrumple
function Crumple_In(clip at,clip bt, int ft)
{
    TransCrumple(at, bt, ft, "crumple", fold=true)
}

function Crumple_Out(clip at,clip bt, int ft)
{
    TransCrumple(at, bt, ft, "crumple", fold=false)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransPush
function Dias_Down(clip at, clip bt, int ft)
{
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    diasblack=at.Levels(0,1,255,0,0,true)
    half=(ft >= 5) ? ( (ft%2 == 0) ? int((ft-3)/2) : int((ft-2)/2) ) : int(ft/2)
    MidClip=(ft%2 == 0) ? diasblack.Trim(0, 1) : diasblack.Trim(0, -1)
    FxClip1=TransPush(at.Trim(0,half), diasblack.Trim(0,half),half+1,"down")
    FxClip2=TransPush(diasblack.Trim(0,half), bt.Trim(0,half),half+1,"up")
    (ft >= 5) ? FxClip1++MidClip++FxClip2 : (ft == 3) ? Dissolve(FxClip1, FxClip2, 1) : Dissolve(FxClip1, FxClip2, 2)
    _at1++last++_bt2
}

function Dias_Up(clip at, clip bt, int ft)
{
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    diasblack=at.Levels(0,1,255,0,0,true)
    half=(ft >= 5) ? ( (ft%2 == 0) ? int((ft-3)/2) : int((ft-2)/2) ) : int(ft/2)
    MidClip=(ft%2 == 0) ? diasblack.Trim(0, 1) : diasblack.Trim(0, -1)
    FxClip1=TransPush(at.trim(0,half), diasblack.trim(0,half),half+1,"up")
    FxClip2=TransPush(diasblack.trim(0,half), bt.trim(0,half),half+1,"down")
    (ft >= 5) ? FxClip1++MidClip++FxClip2 : (ft == 3) ? Dissolve(FxClip1, FxClip2, 1) : Dissolve(FxClip1, FxClip2, 2)
    _at1++last++_bt2
}

function Dias_Left(clip at, clip bt, int ft)
{
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    diasblack=at.Levels(0,1,255,0,0,true)
    half=(ft >= 5) ? ( (ft%2 == 0) ? int((ft-3)/2) : int((ft-2)/2) ) : int(ft/2)
    MidClip=(ft%2 == 0) ? diasblack.Trim(0, 1) : diasblack.Trim(0, -1)
    FxClip1=TransPush(at.trim(0,half), diasblack.trim(0,half),half+1,"left")
    FxClip2=TransPush(diasblack.trim(0,half), bt.trim(0,half),half+1,"right")
    (ft >= 5) ? FxClip1++MidClip++FxClip2 : (ft == 3) ? Dissolve(FxClip1, FxClip2, 1) : Dissolve(FxClip1, FxClip2, 2)
    _at1++last++_bt2
}

function Dias_Right(clip at, clip bt, int ft)
{
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    diasblack=at.Levels(0,1,255,0,0,true)
    half=(ft >= 5) ? ( (ft%2 == 0) ? int((ft-3)/2) : int((ft-2)/2) ) : int(ft/2)
    MidClip=(ft%2 == 0) ? diasblack.Trim(0, 1) : diasblack.Trim(0, -1)
    FxClip1=TransPush(at.trim(0,half), diasblack.trim(0,half),half+1,"right")
    FxClip2=TransPush(diasblack.trim(0,half), bt.trim(0,half),half+1,"left")
    (ft >= 5) ? FxClip1++MidClip++FxClip2 : (ft == 3) ? Dissolve(FxClip1, FxClip2, 1) : Dissolve(FxClip1, FxClip2, 2)
 }
 
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransDisco
function Disco1(clip at, clip bt, int ft)
{
    TransDisco(at, bt, ft)
}

function Disco2(clip at, clip bt, int ft)
{
    TransDisco(at, bt, ft, 80, -4, true)
}

function Disco3(clip at, clip bt, int ft)
{
    TransDisco(at, bt, ft, 400, 2, false)
}

function Disco4(clip at, clip bt, int ft)
{
    TransDisco(at, bt, ft, emerge=false)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Dissolve
function DissolveBloom(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    function Bloom(clip last, int "threshold", int "radius") 
    {
        radius = Default(radius, Round (Width / 120.0))
        threshold = Default(threshold, 255)
        threshold = Round(threshold * 219 / 255.0) + 16
        bloom = BoxBlur(radius, 3, 1000).ConvertToYV12()
        bloommask = bloom.Tweak(sat = 0, coring = false).Levels(1, 1, threshold, 1, 255, false).GreyScale()
        Overlay(last, bloom, mode="lighten", mask=bloommask)
    }
    
    at=Animate(at,1,Round(at.framecount/1),"Bloom",50,0,0,30)
    bt=Animate(bt,0,Round(at.framecount/1)-1,"Bloom",0,50,15,0)
    ct=Dissolve(at,bt,ft)
    return _at1++ct++_bt2
}

function DissolveBlur(clip at, clip bt, int ft)
{
    at=Animate(at,0,at.framecount,"Blur",0,1.58)
    bt=Animate(bt,0,at.framecount,"Blur",1.58,0)
    at=Animate(at,0,at.framecount,"Blur",0,1.58)
    bt=Animate(bt,0,at.framecount,"Blur",1.58,0)
    at=Animate(at,0,at.framecount,"Blur",0,1.58)
    bt=Animate(bt,0,at.framecount,"Blur",1.58,0)
    at=Animate(at,0,at.framecount,"Blur",0,1.58)
    bt=Animate(bt,0,at.framecount,"Blur",1.58,0)
    ct=Dissolve(at,bt,ft)
    return ct
}

/*YUV Only*/
function DissolveBright(clip at, clip bt, int ft)
{
    at=(at.IsYV12()) ? at : at.ConvertToYV12()
    bt=(bt.IsYV12()) ? bt : bt.ConvertToYV12()
    at=Animate(at,at.FrameCount()-ft-1,at.FrameCount()-1,"Tweak",0,1,0,1, 0,2,255,0.5)
    bt=Animate(bt,0,ft,"Tweak",0,2,255,0.5, 0,1,0,1)
    ct=Dissolve(at, bt, ft)
    return ct
}

/*YUV Only*/
function DissolveBurn(clip at, clip bt, int ft)
{
    at=(at.IsYV12()) ? at : at.ConvertToYV12()
    bt=(bt.IsYV12()) ? bt : bt.ConvertToYV12()
    at=Animate(at,at.FrameCount()-ft-1,at.FrameCount()-1,"Tweak",0,1,0,1, 0,1,255,2.9)
    bt=Animate(bt,0,ft,"Tweak",0,1,255,2.9, 0,1,0,1)
    ct=Dissolve(at, bt, ft)
    return ct
}

/*YUV Only*/
function DissolveDark(clip at, clip bt, int ft)
{
    at=(at.IsYV12()) ? at : at.ConvertToYV12()
    bt=(bt.IsYV12()) ? bt : bt.ConvertToYV12()
    at=Animate(at,at.FrameCount()-ft-1,at.FrameCount()-1,"Tweak",0,1,0,1, 0,0.0,-255,0.1)
    bt=Animate(bt,0,ft,"Tweak",0,0.0,-255,0.1, 0,1,0,1)
    ct=Dissolve(at,bt,ft)
    return ct
}

/*YUV Only*/
function DissolveDesat(clip at, clip bt, int ft)
{
    at=(at.IsYV12()) ? at : at.ConvertToYV12()
    bt=(bt.IsYV12()) ? bt : bt.ConvertToYV12()
    at=Animate(at,at.FrameCount()-ft-1,at.FrameCount()-1,"Tweak",0,1,0,1, 0,0.1,0,2)
    bt=Animate(bt,0,ft,"Tweak",0,0.1,0,2, 0,1,0,1)
    ct=Dissolve(at,bt,ft)
    return ct
}

/*YUV Only*/
function DissolveNegative(clip at, clip bt, int ft)
{
    at=(at.IsYV12()) ? at : at.ConvertToYV12()
    bt=(bt.IsYV12()) ? bt : bt.ConvertToYV12()
    at=animate(at,at.FrameCount()-ft-1,at.FrameCount()-1,"Tweak",0,1,0,1, 180,2,0,0.5)
    bt=animate(bt,0,ft,"Tweak",180,2,0,0.5, 0,1,0,1)
    ct=Dissolve(at,bt,ft)
    return ct
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransDoor
function Door_LR_Open(clip at, clip bt, int ft)
{
    TransDoor(at, bt, ft, true, true)
}

function Door_LR_Close(clip at, clip bt, int ft)
{
    TransDoor(at, bt, ft, true, false)
}

function Door_UP_Close(clip at, clip bt, int ft)
{
    TransDoor(at, bt, ft, false, false)
}

function Door_UP_Open(clip at, clip bt, int ft)
{
    TransDoor(at, bt, ft, false, true)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransCrumple
function FanIn(clip at, clip bt, int ft)
{
    TransCrumple(at, bt, ft, "fan", fold=true)
}

function FanOut(clip at, clip bt, int ft)
{
    TransCrumple(at, bt, ft, "fan", fold=false)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# FreeFrame
# RGB Only
function FF_MetaImage(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    function FFrameMetaImage(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteMetaImage, false, vaerdi, 0, 1)
    }
    
    Dissolve(at, bt, ft)
    Animate(0, FrameCount(), "FFrameMetaImage", 1.00, 0.00)
    _at1++last++_bt2
}

# RGB Only
function FF_PeteKaleidascope(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    function FFrameKaleidascope(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteKaleidascope, false, vaerdi, 1)
    }

    Dissolve(at, bt, ft)
    Animate(Trim(last,0,int(ft/2)),0,int(ft/2),"FFrameKaleidascope",0.00,0.50)
    \++Animate(Trim(last,int(ft/2)+1,ft),0,int(ft/2),"fframeKaleidascope",0.50,0.00)
    _at1++last++_bt2
}

# RGB Only
function FF_RadialBlur(clip at,clip bt,int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1
    
    function FFrameRadialBlur(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteRadialBlur, false, vaerdi, 1)
    }

    Dissolve(at, bt, ft)
    Animate(trim(last,0,int(ft/2)),0,int(ft/2),"FFrameRadialBlur",0.00,0.50)\
    ++Animate(trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameRadialBlur",0.50,0.00)
    _at1++last++_bt2
}

# RGB Only
function FF_SmearDown(clip at,clip bt,int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSmearDown(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteSmear, false, 0.75, 0, 1 - vaerdi)
    }
    
    Trim(at,0,int(ft/2))++Trim(bt,0,int(ft/2))
    FxClip1=Animate(Trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSmearDown",0.00,1.00)
    FxClip2=Animate(Trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSmearDown",1.00,0.00)
    Dissolve(FxClip1, FxClip2,1)
    _at1++last++_bt2
}

# RGB Only
function FF_SmearUp(clip at,clip bt,int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSmearUp(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteSmear, false, 0.25, 0, vaerdi)
    }

    Trim(at,0,int(ft/2))++Trim(bt,0,int(ft/2))
    FxClip1=Animate(Trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSmearUp",0.00,1.00)
    FxClip2=Animate(Trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSmearUp",1.00,0.00)
    Dissolve(FxClip1, FxClip2,1)
    _at1++last++_bt2
}

# RGB Only
function FF_SmearRight(clip at,clip bt,int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSmearRight(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteSmear, false, 0.5, 1 - vaerdi, 1)
    }
    
    Trim(at,0,int(ft/2))++Trim(bt,0,int(ft/2))
    FxClip1=Animate(trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSmearRight",0.00,1.00)
    FxClip2=Animate(trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSmearRight",1.00,0.00)
    Dissolve(FxClip1, FxClip2,1)
    _at1++last++_bt2
}

# RGB Only
function FF_SmearLeft(clip at,clip bt,int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSmearLeft(clip in, val vaerdi)
    {
    return in.FreeFrame(g_freeframe_peteSmear, false, 0, vaerdi, 1)
    }
    
    Trim(at,0,int(ft/2))++Trim(bt,0,int(ft/2))
    FxClip1=Animate(trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSmearLeft",0.00,1.00)
    FxClip2=Animate(trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSmearLeft",1.00,0.00)
    Dissolve(FxClip1, FxClip2,1)
    _at1++last++_bt2
}

# RGB Only
function FF_SquashHor(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSquashHor(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteSquash, false, 0, vaerdi)
    }

    Dissolve(at, bt, ft)
    FxClip1=Animate(trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSquashHor",0.5625,1.00)
    FxClip2=Animate(trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSquashHor",1.00,0.5625)
    FxClip1++FxClip2
    _at1++last++_bt2
}

# RGB Only
function FF_SquashHorBackwards(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSquashHorBackwards(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteSquash, false, 0, vaerdi)
    }
    
    Dissolve(at, bt, ft)
    FxClip1=Animate(trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSquashHorBackwards",0.5625,0.00)
    FxClip2=Animate(trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSquashHorBackwards",0.00,0.5625)
    FxClip1++FxClip2
    _at1++last++_bt2
}

# RGB Only
function FF_SquashVer(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSquashVer(clip in, val vaerdi)
    {
        return in.FreeFrame(g_freeframe_peteSquash, false, 1, vaerdi)
    }
    
    Dissolve(at, bt, ft)
    FxClip1=Animate(trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSquashVer",0.5625,1.00)
    FxClip2=Animate(trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSquashVer",1.00,0.5625)
    FxClip1++FxClip2
    _at1++last++_bt2
}

# RGB Only
function FF_SquashVerUpsideDown(clip at,clip bt,int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function FFrameSquashVerUpsideDown(clip in, val vaerdi)
    {
        return in.freeframe(g_freeframe_peteSquash,false,1,vaerdi)
    }
    
    Dissolve(at, bt, ft)
    FxClip1=Animate(trim(last,0,int(ft/2)),0,int(ft/2),"FFrameSquashVerUpsideDown",0.5625,0.00)
    FxClip2=Animate(trim(last,int(ft/2)+1,ft),0,int(ft/2),"FFrameSquashVerUpsideDown",0.00,0.5625)
    FxClip1++FxClip2
    _at1++last++_bt2
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransFlipPage
function FlipPageUp(clip at, clip bt, int ft)
{
    TransFlipPage(at, bt, ft, "up")
}

function FlipPageRight(clip at, clip bt, int ft)
{
    TransFlipPage(at, bt, ft, "right")
}

function FlipPageLeft(clip at, clip bt, int ft)
{
    TransFlipPage(at, bt, ft, "left")
}

function FlipPageDown(clip at, clip bt, int ft)
{
    TransFlipPage(at, bt, ft, "down")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransFunnel
function FunnelUp(clip at, clip bt, int ft)
{
    TransFunnel(at, bt, ft, "up")
}

function FunnelRight(clip at, clip bt, int ft)
{
    TransFunnel(at, bt, ft, "right")
}

function FunnelLeft(clip at, clip bt, int ft)
{
    TransFunnel(at, bt, ft, "left")
}

function FunnelDown(clip at, clip bt, int ft)
{
    TransFunnel(at, bt, ft, "down")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransMarbles
function Marbles(clip at, clip bt, int ft)
{
    TransMarbles(at, bt, ft, 80, 24, true)
}

function Marbles2(clip at, clip bt, int ft)
{
    TransMarbles(at, bt, ft, drop=false)
}

function Marbles3(clip at, clip bt, int ft)
{
    TransMarbles(at, bt, ft, mag=8)
}

function Marbles4(clip at, clip bt, int ft)
{
    TransMarbles(at, bt, ft)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Mirror
function MirrorUpDown(clip at, clip bt, int ft)
{
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    function Mirror(clip clip1, Mirrorline)
    {
        Mir_height=clip1.height()
        Mir_width=clip1.width()
        ct=clip1.FlipVertical().Crop(0,(Mir_height-Mirrorline)/2*2,-0,-0).BilinearResize(Mir_width,Mir_height)
        bla=BlankClip(width=Mir_width,height=Mir_height)
        GaMask=bla.GraMaMa(4,3,Mir_height,5)
        a1=Overlay(bla, ct,0, 0, mask=showalpha(GaMask),mode="blend", opacity=1)
        return Overlay(clip1, a1,0, Mirrorline,mode="blend", opacity=1)
    }

    a1=Animate(0,int(ft/2),"Mirror",at.Trim(1,int(ft/2)),at.height(),at.Trim(1,int(ft/2)),4)
    b1=Animate(0,int(ft/2),"Mirror",bt.Trim(int(ft/2),ft),4,bt.Trim(int(ft/2),ft),bt.height())
    a1++b1
    _at1++last++_bt2
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransPaint
function PaintBricks(clip at, clip bt, int ft)
{
    TransPaint(at, bt, ft, "bricks")
}

function PaintFence(clip at, clip bt, int ft)
{
    TransPaint(at, bt, ft, "fence")
}

function PaintPaint(clip at, clip bt, int ft)
{
    TransPaint(at, bt, ft, "paint")
}

function PaintRings(clip at, clip bt, int ft)
{
    TransPaint(at, bt, ft, "rings")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
#TransPeel
function PeelUp(clip at, clip bt, int ft)
{
    TransPeel(at, bt, ft, "up", 80, -60, false)
}

function PeelDown(clip at, clip bt, int ft)
{
    TransPeel(at, bt, ft, "down")
}

function PeelLeft(clip at, clip bt, int ft)
{
    TransPeel(at, bt, ft, "left", 80, -60, false)
}

function PeelRight(clip at, clip bt, int ft)
{
    TransPeel(at, bt, ft, "right", shade=-180)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransPush
function PushUp(clip at, clip bt, int ft)
{
    TransPush(at, bt, ft, "up")
}

function PushDown(clip at, clip bt, int ft)
{
    TransPush(at, bt, ft, "down")
}

function PushLeft(clip at, clip bt, int ft)
{
    TransPush(at, bt, ft, "left")
}

function PushRight(clip at, clip bt, int ft)
{
    TransPush(at, bt, ft, "right")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransRipples
function Ripple(clip at, clip bt, int ft)
{
    TransRipple(at, bt, ft, 80, 4)
}

function Ripples_Center_1(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, origin="center", amp=4, lambda=8)
}

function Ripples_Center_2(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, origin="center", amp=8, lambda=16)
}

function Ripples_Center_3(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, origin="center", amp=16, lambda=32)
}

function Ripples_Corners(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, nrip=4, origin="corners")
}

function Ripples_EW(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, nrip=2, origin="ew")
}

function Ripples_NE(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, origin="ne", lambda=48)
}

function Ripples_NS(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, nrip=2, origin="ns", opt=2)
}

function Ripples_NSEW(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, nrip=4, origin="nsew", opt=3)
}

function Ripples_NW(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, origin="nw", opt=3)
}

function Ripples_NWSE_1(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, nrip=2, origin="nwse")
}

function Ripples_NWSE_2(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, nrip=2, origin="nesw", opt=2)
}

function Ripples_SE(clip at, clip bt, int ft)
{
    TransRipples(at, bt, ft, origin="se", lambda=64)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransScratch
function ScratchDust(clip at, clip bt, int ft)
{
    TransScratch(at, bt, ft, "dust")
}

function ScratchFount(clip at, clip bt, int ft)
{
    TransScratch(at, bt, ft, "fount")
}

function ScratchHline(clip at, clip bt, int ft)
{
    TransScratch(at, bt, ft, "hline")
}

function ScratchMerge(clip at, clip bt, int ft)
{
    TransScratch(at, bt, ft, "merge")
}

function ScratchOring(clip at, clip bt, int ft)
{
    TransScratch(at, bt, ft, "oring")
}

function ScratchRain(clip at, clip bt, int ft)
{
    TransScratch(at, bt, ft, "rain")
}

function ScratchVline(clip at, clip bt, int ft)
{
    TransScratch(at, bt, ft, "vline")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransShuffle
function ShuffleUp(clip at, clip bt, int ft)
{
    TransShuffle(at, bt, ft, "up")
}

function ShuffleDown(clip at, clip bt, int ft)
{
    TransShuffle(at, bt, ft, "down")
}

function ShuffleLeft(clip at, clip bt, int ft)
{
    TransShuffle(at, bt, ft, "left")
}

function ShuffleRight(clip at, clip bt, int ft)
{
    TransShuffle(at, bt, ft, "right")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransSlantRollIn
function SlantRoll_In(clip at, clip bt, int ft)
{
    TransSlantRollIn(at, bt, ft)
}

function SlantRoll_In_NE(clip at, clip bt, int ft)
{
    TransSlantRollIn(at, bt, ft, "ne", 120, -60)
}

function SlantRoll_In_NW(clip at, clip bt, int ft)
{
    TransSlantRollIn(at, bt, ft, "nw", 120, -60)
}

function SlantRoll_In_SE(clip at, clip bt, int ft)
{
    TransSlantRollIn(at, bt, ft, "se", 120, -60)
}

function SlantRoll_In_Shade(clip at, clip bt, int ft)
{
    TransSlantRollIn(at, bt, ft, shade=160)
}

function SlantRoll_In_SW(clip at, clip bt, int ft)
{
    TransSlantRollIn(at, bt, ft, "sw", 120, -60)
}

function SlantRoll_Out(clip at, clip bt, int ft)
{
    TransSlantRollOut(at, bt, ft)
}

function SlantRoll_Out_Dia(clip at, clip bt, int ft)
{
    TransSlantRollOut(at, bt, ft, rolldia=120)
}

function SlantRoll_Out_NE(clip at, clip bt, int ft)
{
    TransSlantRollOut(at, bt, ft, "ne", 120, -60)
}

function SlantRoll_Out_NW(clip at, clip bt, int ft)
{
    TransSlantRollOut(at, bt, ft, "nw", 120, -60)
}

function SlantRoll_Out_SE(clip at, clip bt, int ft)
{
    TransSlantRollOut(at, bt, ft, "se", 120, -60)
}

function SlantRoll_Out_SW(clip at, clip bt, int ft)
{
    TransSlantRollOut(at, bt, ft, "sw", 120, -60)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransSlantWipe
function Slant_Wipe_NE(clip at, clip bt, int ft)
{
    TransSlantWipe(at, bt, ft, "ne")
}

function Slant_Wipe_NW(clip at, clip bt, int ft)
{
    TransSlantWipe(at, bt, ft, "nw")
}

function Slant_Wipe_SE(clip at, clip bt, int ft)
{
    TransSlantWipe(at, bt, ft, "se")
}

function Slant_Wipe_SW(clip at, clip bt, int ft)
{
    TransSlantWipe(at, bt, ft, "sw")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransSlideIn/TransSlideOut
function SlideIn_Center(clip at, clip bt, int ft)
{
    TransSlideIn(at, bt, ft, "center")
}

function SlideIn_East(clip at, clip bt, int ft)
{
    TransSlideIn(at, bt, ft, "east")
}

function SlideIn_NE(clip at, clip bt, int ft)
{
    TransSlideIn(at, bt, ft, "ne")
}

function SlideIn_North(clip at, clip bt, int ft)
{
    TransSlideIn(at, bt, ft, "north")
}

function SlideIn_South(clip at, clip bt, int ft)
{
    TransSlideIn(at, bt, ft, "south")
}

function SlideIn_SW(clip at, clip bt, int ft)
{
    TransSlideIn(at, bt, ft, "sw")
}

function SlideIn_West(clip at, clip bt, int ft)
{
    TransSlideIn(at, bt, ft, "west")
}

function SlideOut_Center(clip at, clip bt, int ft)
{
    TransSlideOut(at, bt, ft, "center")
}

function SlideOut_East(clip at, clip bt, int ft)
{
    TransSlideOut(at, bt, ft, "east")
}

function SlideOut_North(clip at, clip bt, int ft)
{
    TransSlideOut(at, bt, ft, "north")
}

function SlideOut_SW(clip at, clip bt, int ft)
{
    TransSlideOut(at, bt, ft, "sw")
}

function SlideOut_South(clip at, clip bt, int ft)
{
    TransSlideOut(at, bt, ft, "south")
}

function SlideOut_West(clip at, clip bt, int ft)
{
    TransSlideOut(at, bt, ft, "west")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# SoftWipe
function SoftWipe_Up(clip at, clip bt, int ft)
{
    SoftWipe(at, bt, duration=ft, direction=2)
}

function SoftWipe_Down(clip at, clip bt, int ft)
{
    SoftWipe(at, bt, duration=ft, direction=3)
}

function SoftWipe_Left(clip at, clip bt, int ft)
{
    SoftWipe(at, bt, duration=ft, direction=0)
}

function SoftWipe_Right(clip at, clip bt, int ft)
{
    SoftWipe(at, bt, duration=ft, direction=1)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Split
/*RGB32 Only*/
function Split_Horisontal(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    atwidth=at.width
    atheight=at.height
    crack=int(at.width/4)*2
    at1=SmartCrop(at,0,0,at.width,int(crack),0,0)
    at2=SmartCrop(at,0,int(crack),at.width,int(at.height-crack),0,crack)

    at=Animate(0,ft,"layer",bt,at1,"add",257,0,0,at,at1,"add",0,0,int((crack*-1)))
    at=Animate(0,ft,"layer",at,at2,"add",257,0,0,at,at2,"add",0,0,int((at.height-crack)))
    at
    _at1++last++_bt2
}

/*RGB32 Only*/
function Split_Vertical(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    atwidth=at.width
    atheight=at.height
    crack=int(at.width/4)*2
    at1=SmartCrop(at,0,0,int(crack),at.height,0,0)
    at2=SmartCrop(at,int(at.width-crack),0,int(at.width-crack),int(at.height),int(at.width-crack),0)

    at=Animate(0,int(at.framecount),"layer",bt,at1,"add",257,0,0,at,at1,"add",0,int((crack*-1)),0)
    at=Animate(0,int(bt.framecount),"layer",at,at2,"add",257,0,0,at,at2,"add",0,int((at.width-crack)),0)
    at
    _at1++last++_bt2
}

/*RGB32 Only*/
function Split_Vertical_Full(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    atwidth=at.width
    atheight=at.height
    crack=int(at.height/4)*2
    at1=SmartCrop(at,0,0,at.width,int(crack),0,0)
    at2=SmartCrop(at,0,int(crack),at.width,int(at.height-crack),0,crack)

    at=Animate(0,int(at.framecount),"layer",bt,at1,"add",257,0,0,at,at1,"add",0,0,int((crack*-1)))
    at=Animate(0,int(bt.framecount),"layer",at,at2,"add",257,0,0,at,at2,"add",0,0,int((at.height-crack)))
    at
    _at1++last++_bt2
}

/*RGB32 Only*/
function Split_Vertical_Random(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    atwidth=at.width
    atheight=at.height
    crack=int(Rand(at.height-60,seed=false)/2)*2+30
    at1=SmartCrop(at,0,0,at.width,int(crack),0,0)
    at2=SmartCrop(at,0,int(crack),at.width,int(at.height-crack),0,crack)

    at=Animate(0,int(at.framecount),"layer",bt,at1,"add",257,0,0,at,at1,"add",257,0,int((crack*-1)/2))
    at=Animate(0,int(bt.framecount),"layer",at,at2,"add",257,0,0,at,at2,"add",257,0,int((at.height-crack)/2))
    at
    _at1++last++_bt2
}

/*RGB32 Only*/
function Split_Vertical_UpDown(clip at, clip bt, int ft)
{
    at=(at.IsRGB32()) ? at : at.ConvertToRGB32()
    bt=(bt.IsRGB32()) ? bt : bt.ConvertToRGB32()
    _at1 = at.Trim(0, at.FrameCount() - ft - 1)
    _at2 = at.Trim(at.FrameCount() - ft, 0)
    _bt1 = bt.Trim(0, ft - 1)
    _bt2 = bt.Trim(ft, 0)
    at = _at2
    bt = _bt1

    atwidth=at.width
    atheight=at.height
    crack=int(at.width/4)*2
    at1=SmartCrop(at,0,0,int(crack),at.height,0,0)
    at2=SmartCrop(at,int(at.width-crack),0,int(at.width-crack),int(at.height),int(at.width-crack),0)

    at=Animate(0,int(at.framecount),"layer",bt,at1,"add",257,0,0,at,at1,"add",0,0,int((crack*-1)))
    at=Animate(0,int(bt.framecount),"layer",at,at2,"add",257,0,0,at,at2,"add",0,0,int((at.height-crack)))
    at
    _at1++last++_bt2
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransSprite
function SpriteUp(clip at, clip bt, int ft)
{
    TransSprite(at, bt, ft, "up")
}

function SpriteDown(clip at, clip bt, int ft)
{
    TransSprite(at, bt, ft, "down")
}

function SpriteLeft(clip at, clip bt, int ft)
{
    TransSprite(at, bt, ft, "left")
}

function SpriteRight(clip at, clip bt, int ft)
{
    TransSprite(at, bt, ft, "right")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransSwing
function Swing(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft)
}

function Swing2(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, false, 4, 3)
}

function Swing_Corner(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, corner=3)
}

function Swing_Ndoors(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, ndoors=4)
}

function Swing_One_In(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, true, 1, 1)
}

function Swing_One_In2(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, true, 1, 2)
}

function Swing_One_In3(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, true, 1, 3)
}

function Swing_One_In4(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, true, 1, 4)
}

function Swing_One_Out(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, false, 1, 1)
}

function Swing_One_Out2(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, false, 1, 2)
}

function Swing_One_Out3(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, false, 1, 3)
}

function Swing_One_Out4(clip at, clip bt, int ft)
{
    TransSwing(at, bt, ft, false, 1, 4)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransSwirl
function Swirl(clip at, clip bt, int ft)
{
    TransSwirl(at, bt, ft, step=16)
}

function Swirl_Anti(clip at, clip bt, int ft)
{
    TransSwirl(at, bt, ft, "anti", 10)
}

function Swirl_Clock(clip at, clip bt, int ft)
{
    TransSwirl(at, bt, ft, "clock", 10)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransTwinDoors
function TwinDoors(clip at, clip bt, int ft)
{
    TransTwinDoors(at, bt, ft, true, false)
}

function TwinDoors_Horisontal_Close(clip at, clip bt, int ft)
{
    TransTwinDoors(at, bt, ft, false, false)
}

function TwinDoors_Horisontal_Open(clip at, clip bt, int ft)
{
    TransTwinDoors(at, bt, ft, false, true)
}

function TwinDoors_Vertical_Close(clip at, clip bt, int ft)
{
    TransTwinDoors(at, bt, ft, true, false)
}

function TwinDoors_Vertical_Open(clip at, clip bt, int ft)
{
    TransTwinDoors(at, bt, ft, true, true)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransVenetianBlinds
function VenetianBlinds(clip at, clip bt, int ft)
{
    TransVenetianBlinds(at, bt, ft)
}

function VenetianBlinds_Cheq(clip at, clip bt, int ft)
{
    TransVenetianBlinds(at, bt, ft, type="cheq")
}

function VenetianBlinds_Diam(clip at, clip bt, int ft)
{
    TransVenetianBlinds(at, bt, ft, 40, "diam")
}

function VenetianBlinds_Hor(clip at, clip bt, int ft)
{
    TransVenetianBlinds(at, bt, ft, type="hor")
}

function VenetianBlinds_Vert(clip at, clip bt, int ft)
{
    TransVenetianBlinds(at, bt, ft, type="vert")
}

function VenetianBlinds_Width(clip at, clip bt, int ft)
{
    TransVenetianBlinds(at, bt, ft, width=60)
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransWeave
function Weave_Hor(clip at, clip bt, int ft)
{
    TransWeave(at, bt, ft, "hor")
}

function Weave_Jigsaw(clip at, clip bt, int ft)
{
    TransWeave(at, bt, ft, "jigsaw")
}

function Weave_Vert(clip at, clip bt, int ft)
{
    TransWeave(at, bt, ft, "vert")
}

function Weave_Weave(clip at, clip bt, int ft)
{
    TransWeave(at, bt, ft, "weave")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# TransWipe
function Wipe_Down(clip at, clip bt, int ft)
{
    TransWipe(at, bt, ft, "down")
}

function Wipe_Left(clip at, clip bt, int ft)
{
    TransWipe(at, bt, ft, "left")
}

function Wipe_Right(clip at, clip bt, int ft)
{
    TransWipe(at, bt, ft, "right")
}

function Wipe_Up(clip at, clip bt, int ft)
{
    TransWipe(at, bt, ft, "up")
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
# Subfuncs
function Trim2(clip c, Int Start, Int "end", Int "Length")
{
    Assert(!(Defined(end) && Defined(Length)),
    \      "Trim2: <end> and <Length> parameters cannot be used together")
    Assert(!Defined(Length) || Length >= 0,
    \      "Trim2: invalid Length: " + string(Length))

    end = Defined(end)
    \     ? ((end < 0) ? (c.FrameCount() + end) : end)
    \     : Max(Start, c.FrameCount())
    end = Defined(Length) ? (Start + Length) : end

    Assert(Start >= 0, "Trim2: Start frame out of bounds: " + string(Start))
    Assert(end >= Start, "Trim2: end frame out of bounds: " + string(end))

    Start = Min(Start, c.FrameCount())
    end = Min(end, c.FrameCount())

    # we can't use Trim(Start, end - 1) in case end == 1
    return (Start == end)
    \      ? c.NullClip()
    \      : c.Trim(Start, -(end - Start))
}

function Trim3(clip c, Int Start, Int "end", Int "Length")
{
    Assert(!(Defined(end) && Defined(Length)),
    \      "Trim3: <end> and <Length> parameters cannot be used together")
    Assert(!Defined(Length) || Length > 0,
    \      "Trim3: invalid Length: " + string(Length))

    end = Defined(Length) ? (Start + Length) : Default(end, c.FrameCount())
    end = (end < 0) ? (c.FrameCount() + end) : end

    Assert(Start >= 0 && Start < c.FrameCount(),
    \      "Trim3: Start frame out of bounds: " + string(Start))
    Assert(end > Start && end <= c.FrameCount(),
    \      "Trim3: end frame out of bounds: " + string(end))

    return c.Trim2(Start, end)
}

function MaskTransition(clip c1, clip c2, imgpath , int dur) 
{
    ramp = ImageSource(imgpath, 0, 0, 1, false).BilinearResize(c2.Width(),c2.Height()).ConvertToRGB32()
    ramp = ramp.Lanczos4Resize(c2.Width(),c2.Height())
    ramp = ramp.AssumeFPS(c1.FrameRate()).Loop(dur)
    transitionMask = Animate(ramp, 0, dur, "Levels",
    \                  0, 1.0, 00, 0, 255,
    \               235, 1.0,  255, 0, 255)

    overlap = transitionMask.FrameCount()
    trans1 = mask(c1.Trim3(c1.FrameCount() - overlap).ConvertToRGB32(),transitionMask)
    trans2 = c2.Trim3(0, Length=overlap).ConvertToRGB32()
    trans = layer(trans2, trans1, "add",257,0,0)

    video = trans 
    return video
}

function TransPrep( clip TpClip, Int TPLength)
{
    TpFrames = TpClip.framecount()
    TpClip= (TpFrames-Abs(TpLength)<0) ? TpClip+loop(Trim(TpClip, TpFrames, TpFrames),(Abs(TpLength+TpFrames))) : Trim (TpClip, TpFrames-Abs(TpLength), TpFrames)
    Tpclip= (TpLength>0) ? loop(Trim(TpClip, TpFrames, TpFrames),Abs(TPLength)) : TpClip
    return TpClip
}

function PointChk(inval, outval)
{
    return inval>outval
}

function OverlayM(clip src, int w, int h, int "color", bool "showa")
{
    showa = Default(showa, False)
    color = Default(color, $FFFFFF)
    blank = BlankClip(length=src.FrameCount(), fps=src.FrameRate(), width=w, height=h, color=color).KillAudio()
    src_w = src.Width()
    src_h = src.Height()
    src_sar = src_w / src_h
    sar = w / h
    isRW = (src_sar > sar) ? True : False
    w_target = (isRW) ? w : (Round(src_w * h / src_h))
    h_target = (isRW) ? (Round(src_h * w / src_w)) : h
    src = src.LanczosResize(w_target, h_target)
    src = (showa) ? src.ShowAlpha() : src
    x = (isRW) ? 0 : (w / 2 - w_target / 2)
    y = (isRW) ? (h / 2 - h_target / 2) : 0
    return Overlay(blank, src, x=x, y=y)
}

function SmartCrop(clip clip, int x, int y, int w, int h, int xo, int yo) 
{
    black=BlankClip(width=clip.width, height=clip.height, color=$00000000, length=clip.framecount, pixel_type="rgb32").KillAudio()
    c=Clip.ConvertToRGB32().Crop(x, y, w, h).ResetMask()
    Layer(black, c, "Add", 257, xo, yo)
}
