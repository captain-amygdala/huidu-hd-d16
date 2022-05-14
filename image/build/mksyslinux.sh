dd if=/dev/zero of=boot.img bs=1M count=32
sudo mkfs.fat boot.img
rm -rf tmp
mkdir tmp
sudo mount boot.img tmp/
sudo cp -r boot/* tmp/
sudo umount tmp
mv boot.img ../.
