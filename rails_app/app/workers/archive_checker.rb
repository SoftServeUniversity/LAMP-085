#rake resque:work QUEUE='*'
class ArchiveChecker
  @queue = :archive_checker

  def self.perform(archive_path, result_path, name, type)
    HomeWorkChecker::Base.start(archive_path, result_path, name, type)
    result = Report.add_record("#{result_path}/#{name}.xml")
    logger = OwnLogger::HomeWorkChecker.new(Report::LOG_PATH)
    logger.add_line(result ? Report.archive_passed(
      "#{name+type}") : Report.archive_failed("#{name+type}") )
  end
end
