echo "Dowloading new files from Git"
cd /home/pt/
git clone https://github.com/photrackDKL/DKL-ZM.git

echo "Installing new files on DKL"
sudo chmod +x DKL-ZM/*
sudo chmod +x DKL-ZM/DKL/*
sudo mv /home/pt/DKL /home/pt/DKL_"$(date +%Y%m%d_%H%M)"
sudo mv DKL-ZM/DKL/ /home/pt/
sudo mv -f -t /home/pt/Desktop/ DKL-ZM/run_DKL.sh DKL-ZM/camera_liveview.sh
sudo rm -r DKL-ZM/

echo "DKL script installation done"