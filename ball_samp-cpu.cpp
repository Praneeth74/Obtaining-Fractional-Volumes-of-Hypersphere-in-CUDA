#include <iostream>
#include <random>
#include <assert.h>
#include <string>
#include <iomanip>

int main(){
	int dims = 17;
	int n = 150000;
	int r = 1;
for(int dim=2; dim<dims; dim++){
	int rows=n;
	int cols = dim;
	double mat[rows];
	int seed = 5;
	std::mt19937 gen(seed);
	std::uniform_real_distribution<double> dis(-r, r);
	// selecting the relevant points
	int mat_inds = 0; // to know the index of the final relevant row
	double randnum = 0;
	while(1){
		double sum = 0;
		for(int j=0; j<cols; j++){
			randnum = dis(gen);
			sum += randnum*randnum;
		}
//		std::cout<<sum<<std::endl;
		if(sum < r*r){
			mat[mat_inds] = sum;
			mat_inds++;
			if(mat_inds==n)
				break;
		}
	}
//	std::cout<<"done"<<std::endl;

	// shells range (0, 1, 0.01)
	int nump = 101;
	double arr[nump];
	arr[0] = 0; 	
	for(int i=1; i<nump; i++){
		arr[i] = arr[i-1] + 0.01;
//		std::cout<<arr[i]<<std::endl;
	}

	// obtaining squares sum 

	// initiating fractions
	double fracs[nump-1];
	for(int i = 0; i<nump-1; i++)
		fracs[i] = 0;

	// getting fractions
	for(int i=0; i<nump-1; i++){
		int count = 0;
		for(int j=0; j<mat_inds; j++){
			if((mat[j]>arr[i]*arr[i]) && (mat[j]<arr[i+1]*arr[i+1]))
				count += 1;
		}
//		std::cout<<count<<std::endl;

		fracs[i] = (double)count/(long double)mat_inds;
//		std::cout<<fracs[i]<<std::endl;
	}

	// getting sum of fracs
	double total_sum = 0;
	for(int i=0; i<nump-1; i++)
		total_sum+=fracs[i];

	
	std::cout<< "For dimensions - "<<dim<<": ";
	for(int i=0; i<nump-1; i++){
		std::cout<<fracs[i]<< " ";
	}
	std::cout<<std::endl;
	std::cout<<std::endl;
	n /= 1.1;
}
}


