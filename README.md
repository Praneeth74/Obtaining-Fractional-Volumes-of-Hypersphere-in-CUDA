To run cpu executable -
make ball_samp-cpu

To run gpu executable - 
make ball_samp-cuda


Description:

Consider a unit hypersphere and split it into 100 shells of equal thickness. Now, this implementation is for obtaining fractional volumes of each shell.

The method considered here is to first sample sufficient number of points in the hypershpere. After sampling we can consider counting number of points in each shell as a measurement to their volume. We finally divide each count by total number of points sampled in the whole of hypershpere. 

Here for sampling points, Rejection sampling is used where the points are uniformly sampled in an unit hypercube and then select those points that are present in the hypersphere. That is, rejecting those points which are outside hypersphere.


Procedure:

For sampling one point - 

1. Consider sampling the coordinates $(x_{1}, x_{2}, x_{3},...., x_{n})$ uniformly randomly in (0, 1), where $n$ denotes number of dimensions.

2. Now, select this point only if it satisfies the following condition -
	$x_{1}$


