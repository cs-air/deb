apt-get install vnc4server
vncserver
#vncpasswd
cp ~/.vnc/xstartup  ~/.vnc/xstartup.bak
vi ~/.vnc/xstartup
vncserver -kill :1
vncserver :1
startxfce4 & 

