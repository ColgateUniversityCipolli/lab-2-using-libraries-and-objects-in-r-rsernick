library("stringr")
dirs = list.dirs("Music") 
count = str_count(dirs, "/")
subdirectories = dirs[which(count==2)]

files = c()
for(x in subdirectories){
  song.name = list.files(x)
  for(i in 1:length(song.name)){
    files = c(files, song.name[i])
  }
}
str_count(files, ".wav")

# Code to find the file paths
file.paths = c()
for(i in 1:length(files)){
  file.paths = c(file.paths, paste(subdirectories[ceiling(i/2)], "/", files[i], sep=""))
}

# Code to isolate the track names
cut.names = c()
split.names = c()
track= c()
for(i in 1:length(files)){
  cut.names[i] = str_sub(files[i], 1, length(files[i])-6)
  track = c(track, str_split_i(cut.names[i], "-", 3))
}
#Code to isolate artist and album
album= c()
artist= c()
split.paths= c()
for(i in 1:length(file.paths)){
  artist = c(artist, str_split_i(file.paths[i], "/", 2))
  album = c(album, str_split_i(file.paths[i], "/", 3))
}
output = c()
for(i in 1:length(files)){
  output = c(output, paste(artist[i], "-", album[i], "-", track[i], ".json", sep=""))
}
code.to.process = c()
for(i in 1:length(files)){
  code.to.process = c(code.to.process, paste("streaming_extractor_music.exe", ' "', files[i], '" ', '"', output[i], '"', sep=""))
}
# create bat file
txt.file = file("batfile.txt", "a")
writeLines(code.to.process, txt.file)
close(txt.file)
###############################################################################
# Task 2
###############################################################################

#install and load package
install.packages("jsonlite")
library(jsonlite)

# artist, album, and track name already extracted
# artist
# album
# track

# load json file and extract data

json = fromJSON("The Front Bottoms-Talon Of The Hawk-Au Revoir (Adios).json")
average_loudness = json$lowlevel$average_loudness
mean.spectral.energy = json$lowlevel$spectral_energy$mean
bpm = json$rhythm$bpm
key_key = json$tonal$key_key
key_scale = json$tonal$key_scale
length = json$metadata$audio_properties$length


