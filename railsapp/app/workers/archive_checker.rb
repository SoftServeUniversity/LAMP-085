#rake resque:work QUEUE='*'
class ArchiveChecker
  @queue = :archive_checker

  def self.perform(work_path, tmp_path, name, type)
    HomeWorkChecker::Base.start(work_path, tmp_path, name, type)
    result = Report.add_record("#{work_path}/#{name}-result.xml")
    OwnLogger::HomeWorkChecker.new.add_line(
      result ? Report.archive_passed("#{name+type}") : Report.archive_failed(
      "#{name+type}")
    )
  end
end
