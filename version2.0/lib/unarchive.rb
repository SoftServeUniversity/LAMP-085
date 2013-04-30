#
# scan directories and extract archives
#

module Unarchive
  ARCHIVE_TYPES = {
    ".7z" => 'Unarchive::P7z',
    ".zip" => 'Unarchive::PZip' 
  }
  WORK_PATH = "#{Dir::pwd}/../my_folder"
  DESTIN_PATH = "#{Dir::pwd}/../temp"
  #TMP_PATH = "/tmp"
end