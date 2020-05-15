#http://kmdouglass.github.io/posts/create-a-custom-raspbian-image-with-pi-gen-part-1/

#make executable .sh
cd pi-gen
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
#make lite img

touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP
touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES


sudo docker run -it --privileged --volumes-from=pigen_work pi-gen /bin/bash
sudo CONTINUE=1 ./build-docker.sh
PRESERVE_CONTAINER=1 ./build-docker.sh

