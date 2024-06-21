#include <iostream>
#include <random>
#include <assert.h>
#include <string>
#include <iomanip>

int main(){
	// **Note** The following variables in the editables can be changed. Select what works best with your system.
	// Editables {	
	int min_dim = 1; // Min dimension - start dimension
	int n = 150000; // Number of points to sample for dim = min_dim
	float d = 1.5; // Number of points to sample decreases by a factor of d for each increament in dim 
	int max_dim = 16; // Max dimension - end dimension
	// }
	
	int r = 1;
for(int dim=min_dim; dim<max_dim+1; dim++){
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


	double total_sum = 0;
        std::cout<<"For dimension - "<<dim<<": "<<std::endl;
        std::cout<<"Number of points sampled = "<< mat_inds<<std::endl;
        std::cout<<"Fractional volumes = { " ;
        for(int i=0; i<nump-1; i++){
                total_sum += fracs[i];
                std::cout<<fracs[i]<<", ";
        }
        std::cout<<" }";
        std::cout<<std::endl;
        std::cout<<"Total sum of fractions = "<<total_sum<<std::endl;
        std::cout<<std::endl;

	n /= d;
}
}


