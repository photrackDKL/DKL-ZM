echo "Dowloading new files from Git"
git clone https://github.com/photrackDKL/DKL-ZM.git

echo "Installing new files on DKL"
sudo chmod +x DKL-ZM/*
sudo chmod +x DKL-ZM/DKL/*
sudo mv DKL-ZM/DKL/ /home/pt/
sudo mv -t /home/pt/Desktop/ DKL-ZM/run_DKL.sh DKL-ZM/camera_liveview.sh
sudo rm -r DKL-ZM/

"DKL script installation done"

