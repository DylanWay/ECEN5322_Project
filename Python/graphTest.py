#Test script for comparing the compression of tracks

#Similarity computation:

#S(Ai)+S(Aj)-S(AiAj)

#For tracks, we will utilize the time/frequency plot
#This will be found using scipy

import scipy.io.wavfile as wav
import networkx as nx
import numpy as np
import gzip
import shutil
import os
import random
import pandas

#Create a track object: stores the original wave and spectrogram
class track(object):
    def __init__(self,audio):
        self.audio = audio #Label of track
        
        #Audio is a wave file, read as such
        self.samplerate,self.samples = wav.read(audio)

#Create concatenated wave file from two
def join(a1,a2):
    r1,s1 = wav.read(a1)
    r2,s2 = wav.read(a2)
    
    if r1 == r2:
        s3 = np.concatenate((s1,s2))
        a3 = os.path.basename(a1.split('.',1)[0])+'_'+os.path.basename(a2.split('.',1)[0])+'.wav'
        #Now write it
        wav.write(a3,r1,s3)
        return a3

def compare(f1,f2):
    f3 = join(f1,f2)
    cT1 = compress(f1)
    cT2 = compress(f2)
    cT3 = compress(f3)

    e = size(cT1)+size(cT2)-size(cT3)
    
    # Delete compressed files
    os.remove(cT1)
    os.remove(cT2)
    os.remove(cT3)
    os.remove(f3)
    
    print(f3)
    print(e)
    return e

def compress(*args):
    if len(args) == 1:
        infile = args[0]
        outfile = os.path.basename(infile)
    elif len(args) == 2:
        infile = args[0]
        outfile = args[1]
        
#    outfile = outfile.split('.',1)[0] #Remove extension
    with open(infile,'rb') as f_in:
        with gzip.open(outfile+'.gz','wb') as f_out:
            shutil.copyfileobj(f_in,f_out)
    return outfile+'.gz'
    
def size(file):
    return os.path.getsize(file)

#Real quick application for testing here
#First, read the audio track

#Find all files in directory with extension
path = os.getcwd();
path = os.path.join(path,'ecen5322\\Volumes\\project\\tracks')

csv = os.path.join(path,'..\\ground_truth.csv')
#Load the csv
truth = pandas.read_csv(csv)


#t = [file for file in os.listdir(path) if file.endswith(".wav")]
genres = list(set(truth['Genre']))
tracklist = truth['Tracks']
#Fix the extension
tracklist = [os.path.basename(file.split('.',1)[0])+'.wav' for file in tracklist]

#Create colors
color_map = {genres[0]:'b', genres[1]:'r', genres[2]:'g',genres[3]:'y',genres[4]:'orange',genres[5]:'purple'} 
node_colors = []

#n = 50 #Query 3 songs, tell me how similar they are
#threshold = 0
#rand = [0]*n

#Let's build a graph!
G = nx.Graph() #Create a new graph

#i=0
#while i < len(rand):
#    rand[i] = random.randrange(0,len(tracklist)-1,2)
#    i+=1
rand = tracklist
    
#Now check similarities
ls = [os.path.join(path,i) for i in rand]

#Only use songs in the list
for i,item in enumerate(ls):
    #Adding a node
    G.add_node(item)
    node_colors.append(color_map[truth['Genre'][tracklist.index(os.path.basename(item))]])
    
    for item2 in ls[i:]:
        if item is not item2:
            w = compare(item,item2)
            if (w > threshold):
                G.add_edge(item,item2,weight=w)

nx.draw_random(G, node_color=node_colors)