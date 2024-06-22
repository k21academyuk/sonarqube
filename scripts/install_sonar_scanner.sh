#!/bin/bash

cd /tmp || exit

echo "Downloading sonar-scanner..."
if [ -f "/tmp/sonar-scanner-cli-6.0.0.4432-linux.zip" ]; then
    sudo rm /tmp/sonar-scanner-cli-6.0.0.4432-linux.zip
fi

wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.0.0.4432-linux.zip
if [ $? -ne 0 ]; then
    echo "Download failed."
    exit 1
fi
echo "Download completed."

echo "Unzipping downloaded file..."
unzip -q sonar-scanner-cli-6.0.0.4432-linux.zip
if [ $? -ne 0 ]; then
    echo "Unzip failed."
    exit 1
fi
echo "Unzip completed."
rm sonar-scanner-cli-6.0.0.4432-linux.zip

echo "Installing to /var/opt..."
if [ -d "/var/opt/sonar-scanner-6.0.0.4432-linux" ]; then
    sudo rm -rf /var/opt/sonar-scanner-6.0.0.4432-linux
fi
sudo mv sonar-scanner-6.0.0.4432-linux /var/opt

echo "Creating alias for sonar-scanner..."
if ! grep -q "alias sonar-scanner=/var/opt/sonar-scanner-6.0.0.4432-linux/bin/sonar-scanner" ~/.bashrc; then
    echo "alias sonar-scanner=/var/opt/sonar-scanner-6.0.0.4432-linux/bin/sonar-scanner" >> ~/.bashrc
    source ~/.bashrc
else
    echo "Alias already exists in ~/.bashrc"
fi

echo "Installation and setup completed."
