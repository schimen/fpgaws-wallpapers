# Define some paths
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
logfile="$scriptpath/wget-log"
image_folder="$scriptpath/images"
slideshow_file="$scriptpath/slideshow.xml"
gnome_background_dir="$HOME/.local/share/gnome-background-properties"

# Add wallpapers here
wallpapers=(
    "https://d3i71xaburhd42.cloudfront.net/cf62fa492294768686646609f4d62bcd0522ab63/1-Figure1-1.png"
    "https://thefunnybeavercomd030b.zapwp.com/q:i/r:0/wp:1/w:498/u:https://thefunnybeaver.com/wp-content/uploads/2021/01/Top-40-Funniest-Minions-Memes-funniest-300x274.jpg"
    "https://i.pinimg.com/564x/9e/fb/0f/9efb0f27f73b74fac32100a06752c7fa.jpg"
    "https://i.imgur.com/IShWtbo.png"
    "https://thefunnybeavercomd030b.zapwp.com/q:i/r:0/wp:1/w:701/u:https://thefunnybeaver.com/wp-content/uploads/2018/07/minion-the-nerds.jpg"
    "https://i.pinimg.com/564x/46/89/2b/46892b6252e5b35a3860f1abfad24243.jpg"
    "https://i.pinimg.com/564x/6f/4b/91/6f4b9112a0e63d5eb6027789d39bec64.jpg"
    "https://i.pinimg.com/564x/69/c9/8a/69c98af467203ea4c310535a790b61c0.jpg"
)

# Loop through wallpapers and download all
rm $logfile
echo "Will download ${#wallpapers[@]} images to $image_folder, see log in $logfile"
for url in "${wallpapers[@]}"; do
    echo "Download $url"
    wget -nv -N -a $logfile -P $image_folder $url
done

# Create xml file for ubuntu slideshow :)
echo "Creating slideshow xml file in $slideshow_file"
duration="60.0"
echo "<?xml version="1.0" ?><background>" > $slideshow_file
for file in $(ls -d $image_folder/*); do
    echo "<static><duration>$duration</duration><file>$file</file></static>" >> $slideshow_file
done
echo "</background>" >> $slideshow_file

# Make sure slideshow is available in gnome backgrounds
echo "Copy and prepare xml file in $gnome_background_dir/fpgaws-wallpapers.xml"
mkdir -p $gnome_background_dir
cp $scriptpath/fpgaws-wallpapers.xml $gnome_background_dir/fpgaws-wallpapers.xml
sed -i "s,SLIDESHOW_PATH,$slideshow_file,g" $gnome_background_dir/fpgaws-wallpapers.xml