#
# scan directories and extract archives
#

module Unarchive
  ARCHIVE_TYPES = {
    ".7z" => 'Unarchive::SevenZip',
    ".zip" => 'Unarchive::StandardZip' 
  }

  DESTIN_PATH  = "../bin/homework"
  TMP_PATH = "../bin/temp"
  WORK_PATH = "../bin/my_folder" 
end
