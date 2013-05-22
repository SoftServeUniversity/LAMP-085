require 'mysql2'
module HomeWorkChecker
  class DataBaseWrite
    def initialize
    @client = Mysql2::Client.new(
      :host => "localhost", 
      :username => "root", 
      :database => "test", 
      :password => "root")
    @student  = 'test'; @homework = 'test'; @test_quantity = 5; @passed_tests = 2; @failed_tests = 3; @avg_time = 0.05; @language = 'rb';
    @student_name = []
    end

    def result
      student_id = 0
      result = @client.query("SELECT students_id, name FROM students")
      result.each(:as => :array) do |k, v|
        if v == @student
         student_id = k
        end
      end

      if student_id == 0
        @client.query("INSERT INTO students (name) VALUES ('#{@student}')")
      end
      result = @client.query("SELECT students_id, name FROM students")
      result.each(:as => :array) do |k, v|
        if v == @student
          student_id = k
        end
      end

      homework_id = 0
      result = @client.query("SELECT homeworks_id, name FROM homeworks")
      result.each(:as => :array) do |k, v|
        if v == @homework
         homework_id = k
        end
      end

      if homework_id == 0
        @client.query("INSERT INTO homeworks (name) VALUES ('#{@homework}')")
      end
      result = @client.query("SELECT homeworks_id, name FROM homeworks")
      result.each(:as => :array) do |k, v|
        if v == @homework
          homework_id = k
        end
      end
        @client.query("INSERT INTO tests (students_id,
                                         homeworks_id,
                                        test_quantity,
                                         passed_tests,
                                         failed_tests,
                                             avg_time, 
                                             language) 
                                VALUES (#{student_id}, 
                                       #{homework_id}, 
                                    #{@test_quantity}, 
                                     #{@passed_tests}, 
                                     #{@failed_tests}, 
                                         #{@avg_time}, 
                                        '#{@language}')")
    end
  end
end
