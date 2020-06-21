# Israeli court SGN extractor
I got some attachment by mail that is an SGN file from the Israeli court system.  
They require a Windows-only software to view the files.  
This is unthinkable.  

## Requirements
* Needs [yq](https://github.com/kislyuk/yq) installed, for XML-jq-ing

## Usage
* Run `extract.sh` with the SGN filepath

## Caveats
* Doesn't actually verify the digital signature of the file. Be suspicious
* Extracts to current directory

## Fixes
Are welcome! Please PR me

## License 
GPLv3. See LICENSE file
