#
# scan directories and extract archives
#

module Unarchive
  ARCHIVE_TYPES = {
    ".7z" => 'Unarchive::P7z',
    ".zip" => 'Unarchive::PZip' 
  }
  WORK_PATH = "/home/#{`whoami`.strip}/my_folder"
  DESTIN_PATH = "/home/#{`whoami`.strip}/hw"
  #TMP_PATH = "/tmp"
end