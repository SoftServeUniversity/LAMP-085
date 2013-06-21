module HomeWorkChecker
  module ArchiveResult
    def self.execute(tmp_path, name)
      language_name = LANGUAGE_TYPES[name.split('_')[1] ]
      raise DirectoryFormatError, "Directory '#{name}' does not match needed format" if language_name.nil? 
       stats = MODULE_TYPES[language_name].split(' ').map do |class_name|
        class_name.constatize.new(tmp_path, name).perform
      end
      [language_name, stats.first, stats.last ]
    end
  end
end
