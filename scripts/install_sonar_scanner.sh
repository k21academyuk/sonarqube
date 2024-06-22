#!/bin/sh

cd /tmp || exit

echo "Downloading sonar-scanner....."
if [ -e "/tmp/sonar-scanner-cli-6.0.0.4432-linux.zip" ]; then
    rm /tmp/sonar-scanner-cli-6.0.0.4432-linux.zip
fi

wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.0.0.4432-linux.zip
echo "Download completed."

echo "Unzipping downloaded file..."
unzip sonar-scanner-cli-6.0.0.4432-linux.zip
echo "Unzip completed."
rm sonar-scanner-cli-6.0.0.4432-linux.zip

echo "Installing to /var/opt..."
if [ -d "/var/opt/sonar-scanner-6.0.0.4432-linux" ]; then
    rm -rf /var/opt/sonar-scanner-6.0.0.4432-linux
fi
mv sonar-scanner-6.0.0.4432-linux /var/opt

echo "Creating alias for sonar-scanner..."
echo "alias sonar-scanner='/var/opt/sonar-scanner-6.0.0.4432-linux/bin/sonar-scanner'" >> ~/.bashrc
. ~/.bashrc

echo "Installation and setup completed."
