# opengl acceleration
export MOZ_ACCELERATED=1
# force webrender to enable
export MOZ_WEBRENDER=1

export LANG=en_US.UTF-8

xrdb -DHOME=$HOME < ~/.Xresources

xset r rate 250 40
setxkbmap -layout us,ru -option 'grp:caps_toggle'

hsetroot -solid "#83988e"

picom -b

exec i3
