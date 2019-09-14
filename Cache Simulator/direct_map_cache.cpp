#include <iostream>
#include<stdio.h>
#include<fstream>
#include <math.h>

using namespace std;

struct cache_content{
	bool v;
	unsigned int  tag;
	int w;
//	unsigned int	data[16];    
};


const int K=1024;



void simulate(int cache_size, int block_size, int n){
	unsigned int tag,index,x;

	int offset_bit = (int) log2(block_size);
	
	int index_bit = (int) log2(cache_size/block_size/n);
	int line= cache_size>>(offset_bit);
    int current_w = 0;
    double access = 0, miss = 0;
	//int miss_num=0;
	//int hit_num=0;
	//int hit_in[70000],miss_in[70000];


	cache_content *cache =new cache_content[line];
	//cout<<"cache line:"<<line<<endl;

	for(int j=0;j<line;j++)
    {
        cache[j].v=false;
        cache[j].w=0;
    }
	
  FILE * fp=fopen("Trace.txt","r");					//read file
	
	while(fscanf(fp,"%x",&x)!=EOF){
		
		bool hit=false;

		//cout<<hex<<x<<" ";
		//cout<<line/n<<endl;
		index=((x>>offset_bit)%(line / n)) * n;//一個set有n個相同index的block
		tag=x>>(index_bit+offset_bit);

		current_w++;
		
        
        
		for(int i = 0 ;i < n ; ++i){
				//cout<<cache[index + i].v
				//cout<<"cache"<<i<<": "<<index<<" "<<cache[index+i].tag<<" "<<cache[index + i].v<<endl;	
			if(cache[index+i].v && cache[index+i].tag==tag){
				cache[index + i].v=true; 			//hit
				cache[index + i].w=current_w;		
				hit = true;
				//hit_in[hit_num]=access+1;
				//hit_num++;
				break;
			}
		}
        
		if(!hit){
			//miss_in[miss_num]=access+1;
			
			//miss_num++;
			int replace = index;
			miss++;
			for(int i=0;i<n;++i)if(cache[index+i].w<cache[replace].w)replace=index+i;
			cache[replace].w = current_w;
			cache[replace].tag = tag;	
			cache[replace].v = true;


		}
		else{};

		/*if(cache[index].v && cache[index].tag==tag){
			cache[index].v=true; 			//hit
		}
		else{						
			cache[index].v=true;			//miss
			cache[index].tag=tag;
		}*/
		access++;

	}
	//cout<<line<<endl;
	cout <<n<< "-way associative"<< endl;
	cout<<"cache size: " << cache_size << endl;
	//cout << "block size: " << block_size << endl;
	
	cout<<miss<<endl;
	cout<<access<<endl;
	double rate=miss/access;
	cout<<"Miss rate: "<<rate*100<<"%"<<endl;
	fclose(fp);
	
	/*cout<<"Hits instructions: ";
	for(int i=0;i<hit_num;i++){
		cout<<hit_in[i];
		if(i!=hit_num-1)cout<<",";
		else cout<<endl;
	}*/
	/*cout<<"Misses instructions: ";
	for(int i=0;i<miss_num;i++){
		cout<<miss_in[i];
		if(i!=miss_num-1)cout<<",";
		else cout<<endl;
	}*/
	



	delete [] cache;
}
	
int main(){
	int c_size[9]={1, 2, 4, 8, 16, 32, 64, 128, 256};
	int b_size[5]={16, 32, 64, 128, 256};
	int n_way[14]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192};
	// Let us simulate 4KB cache with 16B blocks
	for(int i = 0;i<9;i++){
	for (int j=0;j<5;j++)simulate(c_size[i]*K, b_size[j],1);

	}
	//simulate(1*K, 32,1);
	//for(int i=0;i<6;i++)simulate(1*K, 32, n_way[i]);
	//for(int i=0;i<7;i++)simulate(2*K, 32, n_way[i]);
	//for(int i=0;i<8;i++)simulate(4*K, 32, n_way[i]);
	//for(int i=0;i<9;i++)simulate(8*K, 32, n_way[i]);
	//for(int i=0;i<10;i++)simulate(16*K, 32, n_way[i]);
	//for(int i=0;i<11;i++)simulate(32*K, 32, n_way[i]);
	//for(int i=0;i<12;i++)simulate(64*K, 32, n_way[i]);
	//for(int i=0;i<13;i++)simulate(128*K, 32, n_way[i]);
	//for(int i=0;i<14;i++)simulate(256*K, 32, n_way[i]);

	
	return 0;
}
