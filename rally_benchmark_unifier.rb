require 'yaml'
require 'fileutils'

path = "../rally/doc/samples/tasks/scenarios"
default_flavor = "m1.tiny"
default_image = "cirros"

puts "Finding benchmarks in #{path} ..."
array_of_all_benchmarks = Dir.glob("#{path}/**/*.yaml").reject { |file_path| File.directory? file_path }
cleaned_benchmarks_array = []

## Remove unwanted benchmarks
ARGV.each do |a|
  if a.include? "--no-"
    remove_service = a.gsub("--no-", '')
    puts "Not testing #{remove_service}"

    array_of_all_benchmarks.each do |benchmark|
      if benchmark.include? remove_service
        puts "x #{benchmark}"
      else
        cleaned_benchmarks_array.push benchmark
      end
    end
  end
end

puts cleaned_benchmarks_array
puts "-----"
puts "Number of benchmarks found: #{cleaned_benchmarks_array.count}"

# Create all_benchmarks.yaml file
puts "Combining benchmarks in single YAML file..."
all_benchmarks = ""

cleaned_benchmarks_array.each do |benchmark|
  all_benchmarks << YAML.load_file(benchmark).to_yaml
end

# Replace Flavor and Image. Remove "---"
all_benchmarks.gsub!("m1.nano", default_flavor)
all_benchmarks.gsub!("cirros-0.3.1-x86_64-uec", default_image)
all_benchmarks.gsub!("---", "")

# Save new YAML content
File.open("all_benchmarks.yaml", 'w') {|f| f.write(all_benchmarks) }

# Move file to rally folder
puts "Moving YAML file..."
FileUtils.mv('all_benchmarks.yaml', '../rally')

puts "SUCCESS!"