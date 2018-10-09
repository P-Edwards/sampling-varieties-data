from rtree import index
import numpy as np 
import os,sys
from math import sqrt
np.set_printoptions(threshold=np.nan)


template_stem = os.path.dirname(sys.argv[1])

def _createRadiusBox(point,radius): 
	dimension = len(point)
	range_length = radius/sqrt(dimension)
	box_coordinates = list()
	for coordinate in point: 
		box_coordinates.append(coordinate - range_length)
		box_coordinates.append(coordinate + range_length)
	return box_coordinates

def subsample_with_radius(path_to_sample,radius,dimension,output_file_name): 
	p = index.Property() 
	p.dimension = dimension 
	spatial_database = index.Index(properties=p)
	spatial_database.interleaved = False
	output = []
	idx = 0
	with open(path_to_sample) as sample_file: 
		for line in sample_file: 
			point = [float(coordinate) for coordinate in line.strip().split(",")]
			box = _createRadiusBox(point,radius)
			number_intersecting_points = spatial_database.count(box)
			if number_intersecting_points == 0: 
				spatial_database.insert(idx,box)
				output.append(point) 
				idx += 1
	output = np.array(output)
	output_path = os.path.join(template_stem,output_file_name)
	np.savetxt(output_path,output,delimiter=",")


sample_path = os.path.realpath(sys.argv[1])
radius = float(sys.argv[2])
dimension = int(sys.argv[3])
output_name = sys.argv[4]


subsample_with_radius(sample_path,radius,dimension,output_name)