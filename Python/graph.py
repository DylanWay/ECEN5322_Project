#Networking class

import networkx as nx
import numpy as np
#from enthought.mayavi import mlab

G = nx.Graph() #Create a new graph
G.add_node("0")
G.add_edge(1,5)

nx.draw_shell(G)

#G=nx.convert_node_labels_to_integers(G)
#
#pos = nx.spring_layout(G,dim=3)
#xyz = np.array([pos[v] for v in sorted(G)])
#scalars=np.array(G.nodes())+5
#
#mlab.figure(1, bgcolor=(0, 0, 0))
#mlab.clf()
#
#pts = mlab.points3d(xyz[:,0], xyz[:,1], xyz[:,2],
#                    scalars,
#                    scale_factor=0.1,
#                    scale_mode='none',
#                    colormap='Blues',
#                    resolution=20)
#
#pts.mlab_source.dataset.lines = np.array(G.edges())
#tube = mlab.pipeline.tube(pts, tube_radius=0.01)
#mlab.pipeline.surface(tube, color=(0.8, 0.8, 0.8))
#
#mlab.savefig('mayavi2_spring.png')
## mlab.show() # interactive window