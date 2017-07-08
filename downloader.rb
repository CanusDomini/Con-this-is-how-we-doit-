require "youtube-dl"

# going to make ensure that the count of ARGV = 2 otherwise it should display an error message/prompt to re-input correct info
if ARGV.count != 2
  p "Please input source url and desired output name."
  Kernel.exit!(1)
end
url, output = ARGV
p "url is #{url}, output is #{output}"
@video = YoutubeDL.download "#{url}", output: "#{output}.mp4"
#File.exists?("test")
# There are 2 main ways of executing shell commands in Ruby
# system("ls")
# backick 'ls', %x[ls]
# The difference between the two is that system returns Bool (true if command is successfully run, false if not).  And backtick/%x will return the string response from the terminal command.
`ls`
@ls_output = `ls`
@ls_output_array = @ls_output.split("\n")
#^ Array of items in the folder now, array of strings, the strings are the filenames
#(This is a method of ruby String class)
#if "this_string"
@status = {success: false, downloaded_file: ""}
@ls_output_array.each do |filename|
  if filename.includes?(output)
    @status[:success] = true
    @status[:downloaded_file] = filename
  end
end
if @status[:success]
  system("ffmpeg -i #{@status[:downloaded_file]} #{output}.mp3")
  system("rm #{filename}")
  system("scp #{output}.mp3 user@conduit/media/user/Conduit/Music/yt_singles")
  p "Ok, now check the Conduit or simply listen with your ears to hear the song."
else
  p "The program geht nicht."



