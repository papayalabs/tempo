require 'openai'
require 'dotenv/load'
require 'json'
require 'fileutils'
require 'open3'
require 'colored'
require 'diffy'

OpenAI.configure do |config|
  config.access_token = File.read('openai_key.txt').strip
end

def send_code_to_gpt(client, type_of_file, script_name)
  file_lines = File.readlines(script_name)
  file_with_lines = file_lines.each_with_index.map { |line, idx| "#{idx + 1}: #{line}" }.join

  initial_prompt_text = ""
  if type_of_file == "html"
    initial_prompt_text = File.read('prompt_html.txt')
  elsif type_of_file == "txt"
    initial_prompt_text = File.read('prompt_txt.txt')
  end

  prompt = build_prompt(initial_prompt_text, file_with_lines)

  response = client.chat(
    parameters: { model: 'gpt-3.5-turbo', messages: [{ role: 'user', content: prompt }], temperature: 0.7 }
  )

  output =  response.dig('choices', 0, 'message', 'content').strip
  status = response.dig('object')
  [output, status]
end

def build_prompt(initial_prompt_text, file_with_lines)
  initial_prompt_text +
    "\n\n" \
    "Here is the code that needs to be analized:\n\n" \
    "#{file_with_lines}\n\n" \
    'Please provide your suggested template builder'
end

def main
  if ARGV.length < 2
    puts 'Usage: tempo.rb <type_of_file> <file_name>'
    puts 'Remember that type_of_file cound be txt or html'
    exit(1)
    end

    type_of_file = ARGV[0]
    file_name = ARGV[1]
    client = OpenAI::Client.new

  loop do
    output, status = send_code_to_gpt(client,type_of_file,file_name)

    if status == 'chat.completion'
      puts 'Script ran successfully.'.blue
      puts "Output: #{output}"
      break
    else
      puts 'Script crashed. Trying to fix...'.blue
      puts "Output: #{output}"
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
