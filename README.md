# AvisynthScript-Trans
Avisynth Auto Scripts.

This is a auto scripts to create slideshow using avisynth.
GUI soft see http://download.videohelp.com/tin2tin/

DLL LIB author list:
1.The Pete files are by Pete Warden
2.SoftWipe_by_vampiredom
3.GScript_by_Gavino

Example1:
Import("..\Trans\TransMain.avsi")
at=OverlayM(ImageSource("a.png",pixel_type="rgb32",0,99),1280,720)
bt=OverlayM(ImageSource("b.png",pixel_type="rgb32",0,99),1280,720)
ft=int((at.FrameRate()+bt.FrameRate())/2)
Mask_3dtwirl(at, bt, ft)

Example2:
Import("..\Trans\TransMain.avsi")
Slideshow("image (*).jpg", 1, 8, 90)
