require 'csv'

namespace :db do
  task :import => [:environment] do

  csv_library = File.read(Rails.root.join("books.csv"))
  csv = CSV.parse(csv_library, :headers => true, :encoding => "ISO-8859-1")
  csv.each do |row|
    b = Book.new
    b.title = row["Title"]
    b.author = row["Author"]
    b.genre = row["Genre"]
    b.sub_genre = row["SubGenre"]
    b.pages = row["Pages"]
    b.publisher = row["Publisher"]
    b.copies = row["Copies"]
    b.save
    puts "#{b.title}, #{b.author} saved"
  end

  puts "There are now #{Book.count} rows in the books table"
 end
end