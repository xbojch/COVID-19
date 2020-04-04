require 'csv'
require 'json'

class Converter
    TIME_SERIES_PATH = '../csse_covid_19_data/csse_covid_19_time_series/'
    TIME_SERIES_OUTPUT_PATH = '../json/csse_covid_19_time_series/'

    DAILY_REPORTS_PATH = '../csse_covid_19_data/csse_covid_19_daily_reports/'
    DAILY_REPORTS_OUTPUT_PATH = '../json/csse_covid_19_daily_reports/'

    def convert_time_series(csv_filename)
        parsed_csv = CSV.read("#{TIME_SERIES_PATH}#{csv_filename}")

        headers = parsed_csv.shift

        rows = parsed_csv.map do |row|
            row_hash = Hash.new

            row.each_index do |index|
                row_hash[headers[index]] = row[index]
            end

            row_hash
        end

        File.open("#{TIME_SERIES_OUTPUT_PATH}#{csv_filename[0..-5]}.json", 'w') {|file| file.write(JSON.generate(rows))}
    end

    def convert_daily_reports(csv_filename)
        parsed_csv = CSV.read("#{DAILY_REPORTS_PATH}#{csv_filename}")

        headers = parsed_csv.shift

        rows = parsed_csv.map do |row|
            row_hash = Hash.new

            row.each_index do |index|
                row_hash[headers[index]] = row[index]
            end

            row_hash
        end

        File.open("#{DAILY_REPORTS_OUTPUT_PATH}#{csv_filename[0..-5]}.json", 'w') {|file| file.write(JSON.generate(rows))}
    end
end

c = Converter.new

Dir["#{Converter::TIME_SERIES_PATH}*.csv"].each {|filename| c.convert_time_series(filename.split('/').last)}
Dir["#{Converter::DAILY_REPORTS_PATH}*.csv"].each {|filename| c.convert_daily_reports(filename.split('/').last)}