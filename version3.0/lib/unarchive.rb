#
# scan directories and extract archives
#

module Unarchive
  ARCHIVE_TYPES = {
    ".7z" => 'Unarchive::P7z',
    ".zip" => 'Unarchive::PZip' 
  }
  WORK_PATH = "#{Dir::pwd}/../my_folder"
  TMP_PATH = "#{Dir::pwd}/../temp"
  DESTIN_PATH  = "#{Dir::pwd}/../homework"
end