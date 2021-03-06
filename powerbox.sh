HOSTARCH=$(uname -m)
mount -o rw,remount /
echo "Which directory would you like to install powerbox to? (/linux is recommended): "
read -r powerdir

if [ "$powerdir" == "" ]
then
  powerdir = /linux
fi

mkdir $powerdir
echo "How many gigabytes of space would you like to allocate to the chroot image? (no symbols, in gigabytes): "

read -r powersize 
if [ "$powersize" == "" ]
then
  powersize = 10
fi
powerimgsize = powersize * 1000000 / 16
echo "How would you like to name the image? (linux is recommended): "
read -r powerimgname

if [ "$powerimgname" == "" ]
then
  powerimgname = "linux"
fi

echo "Creating image..."
dd if=/dev/zero of=/sdcard/$powerimgname.img bs=16k count=$powerimgsize
mkfs.ext4 /sdcard/$powerimgname

echo "Downloading archive..."
wget https://github.com/egor4ka/powerbox/releases/download/0.1/powerbox-$HOSTARCH.tar.gz

echo "Unpacking archive..."
tar -xvf powerbox-$HOSTARCH.tar.gz -C $powerdir

echo "Cleaning up..."
rm powerbox-$HOSTARCH.tar.gz

echo "Done! Now, just mount the img and bind the dev and stuff and you should be fine, unless you used a different path/.img path, in which case run alpishell -h to get some help."
