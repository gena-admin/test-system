require 'importer/attack'

namespace :questions do
  namespace :attack do
    desc 'Destroy all attack questions with related answers'
    task :clear => :environment do
      Answer.delete_all
      Question.delete_all
    end

    desc 'Import attack questions from questions/attack/ directory'
    task :import => :environment do
      puts '=' * 150
      puts 'Started attack questions importing'
      count = 0
      Dir[File.join Rails.root, 'questions', 'attack', '*.xlsx'].each { |file_path|
        begin
          Importer::Attack.new(file_path).import!
          count += 1
          print '+'
        rescue Exception => e
          puts ''
          puts file_path
          puts e.message
        end
      }
      puts ''
      puts "Finished attack questions importing. Imported #{count} questions"
      puts '=' * 150
    end
  end
end
