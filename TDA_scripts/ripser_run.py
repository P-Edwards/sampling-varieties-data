from subprocess import call
import sys,os

file_path = os.path.realpath(__file__)
input_file_names = [os.path.abspath(file_name) for file_name in sys.argv[1:]]
file_directory = os.path.dirname(file_path)




pointcloud_to_distmat_path = file_directory
ripser_plotting_path = file_directory
dipha_script_path = file_directory
matlab_path = "matlab"
ripser_executable_path = os.path.realpath(os.path.join(file_directory,"ripser/ripser"))



def run_ripser(input_file_path): 
	sample_name = os.path.basename(input_file_path).split(".")[0]
	output_path = os.path.join(os.path.dirname(input_file_path),sample_name+"_persistence.txt")
	print "output path: ", output_path
	with open(output_path,"w") as output:
		# Save the distance matrix for dipha 

		# Call dipha
		dipha_call_string = ripser_executable_path+" --dim 1 --format point-cloud "+input_file_path
		print "dipha info: ",dipha_call_string
		call(args=[dipha_call_string],cwd=file_directory,shell=True,stdout=output.fileno())
	with open("/dev/null","w") as devnull: 
		# Matlab portion to generate persistence diagrams
		call(args=[matlab_path,"-nodisplay -nosplash -nodesktop -r","\"cd %s;ripser_reformat_output('%s');cd %s;save_ripser_plot('%s',0.0);exit;\"" % (ripser_plotting_path,output_path,dipha_script_path,output_path)],
			stdout=devnull.fileno(),cwd=file_directory)


for input_file_name in input_file_names:
	run_ripser(input_file_name)

