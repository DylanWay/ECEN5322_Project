function [ outAudio, Fs ] = ReadAudio( file,T )
%READAUDIO is used to extract T seconds of audio from the middle of an
%input track
    %Read in the audio file completely
    [y,Fs] = audioread(file);

    %Now check the length by dividing size(y) by sampling frequency
    len = length(y)/Fs;

    if (T < len)
        %Extract the portion of the track (T seconds)
        %Extracts middle of song
        samp = T*Fs; %Time in samples
        outAudio = y(floor((length(y)-samp)/2):ceil((length(y)+samp)/2));
        
    else %Use the whole length of the track
        outAudio = y;
    end
end

